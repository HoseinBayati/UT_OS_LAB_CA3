#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"

struct
{
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

struct queue
{
  struct proc *proc[NPROC];
  int pi;
};

struct queue rr_q;
struct queue lcfs_q;
struct queue bjf_q;

uint randGen(uint seed)
{
  uint cticks = ticks;
  seed += cticks;
  seed <<= 5;
  seed /= 13;
  seed <<= 1;
  seed *= 17;
  seed >>= 2;
  seed -= cticks / 3;
  return seed / 3;
}

static struct proc *initproc;
uint rr_counter = 0;

int nextpid = 1;
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);

void pinit(void)
{
  initlock(&ptable.lock, "ptable");

  rr_q.pi = -1;
  lcfs_q.pi = -1;
  bjf_q.pi = -1;
}

// Must be called with interrupts disabled
int cpuid()
{
  return mycpu() - cpus;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu *
mycpu(void)
{
  int apicid, i;

  if (readeflags() & FL_IF)
    panic("mycpu called with interrupts enabled\n");

  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i)
  {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc *
myproc(void)
{
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}

// PAGEBREAK: 32
//  Look in the process table for an UNUSED proc.
//  If found, change state to EMBRYO and initialize
//  state required to run in the kernel.
//  Otherwise return 0.

static struct proc *
allocproc(void)
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if (p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;

found:

  p->state = EMBRYO;
  p->pid = nextpid++;

  release(&ptable.lock);

  // Allocate kernel stack.
  if ((p->kstack = kalloc()) == 0)
  {
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe *)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint *)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context *)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  p->arrivetime = ticks;

  return p;
}

// PAGEBREAK: 32
//  Set up first user process.
void userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
  if (p == 0)
  {
    panic("userinit allocproc failed\n");
  }

  initproc = p;
  if ((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0; // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);

  // Default scheduling queue
  p->q_type = LCFS;
  lcfs_q.pi++;
  lcfs_q.proc[lcfs_q.pi] = p;

  p->state = RUNNABLE;

  release(&ptable.lock);
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if (n > 0)
  {
    if ((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  else if (n < 0)
  {
    if ((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int fork(void)
{
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if ((np = allocproc()) == 0)
  {
    return -1;
  }

  // Copy process state from proc.
  if ((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0)
  {
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for (i = 0; i < NOFILE; i++)
    if (curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));

  pid = np->pid;

  acquire(&ptable.lock);

  // Default scheduling queue
  np->q_type = LCFS;

  lcfs_q.pi++;
  lcfs_q.proc[lcfs_q.pi] = np;
  np->arrivetime = ticks;
  np->waiting_time = 0;
  np->executed_cycle = 0;

  acquire(&tickslock);
  np->priority = (ticks * ticks * 1021) % 100;
  release(&tickslock);

  np->priority_ratio = 0.25;
  np->executed_cycle_ratio = 0.25;
  np->arrivetime_ratio = 0.25;
  np->size_ratio = 0.25;

  np->state = RUNNABLE;

  release(&ptable.lock);

  return pid;
}

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.

// Lock of the q must have been acquired before usage.
void shiftOutQueue(struct queue *q, struct proc *p)
{
  struct proc *temp;
  if (!holding(&ptable.lock))
  {
    panic("scheduling queue lock not held");
  }
  int qi;
  for (qi = 0; qi <= q->pi; qi++)
  {
    if (q->proc[qi]->pid == p->pid)
    {
      break;
    }
  }

  while (qi <= q->pi)
  {
    temp = q->proc[qi];
    q->proc[qi] = q->proc[qi + 1];
    q->proc[qi + 1] = temp;
    qi++;
  }
  q->proc[qi] = (void *)(0); // NULL
}

void cleanupCorresQueue(struct proc *p)
{
  switch (p->q_type)
  {
  case RR:
    if (rr_q.pi <= -1)
    {
      panic("RR: nothing to clean");
    }
    shiftOutQueue(&rr_q, p);
    rr_q.pi--;
    break;
  case LCFS:
    if (lcfs_q.pi <= -1)
    {
      panic("LCFS: nothing to clean");
    }
    shiftOutQueue(&lcfs_q, p);
    lcfs_q.pi--;
    break;
  case BJF:
    if (bjf_q.pi <= -1)
    {
      panic("BJF: nothing to clean");
    }
    shiftOutQueue(&bjf_q, p);
    bjf_q.pi--;
    break;
  default:
    panic("defaut scheduling cleanup");
  }
}

void exit(void)
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if (curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for (fd = 0; fd < NOFILE; fd++)
  {
    if (curproc->ofile[fd])
    {
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;

  acquire(&ptable.lock);
  // remove from corresponding scheduling queue
  cleanupCorresQueue(curproc);

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->parent == curproc)
    {
      p->parent = initproc;
      if (p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;

  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();

  acquire(&ptable.lock);
  for (;;)
  {
    // Scan through table looking for exited children.
    havekids = 0;
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    {
      if (p->parent != curproc)
        continue;
      havekids = 1;
      if (p->state == ZOMBIE)
      {
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if (!havekids || curproc->killed)
    {
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock); // DOC: wait-sleep
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void set_bjf_params(int pid, int priority_ratio, int arrival_time_ratio, int executed_cycle_ratio)
{
  struct proc *p;

  acquire(&ptable.lock);
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->pid == pid)
    {
      p->priority_ratio = priority_ratio;
      p->arrivetime = arrival_time_ratio;
      p->executed_cycle_ratio = executed_cycle_ratio;
    }
  }
  release(&ptable.lock);
}

void set_all_bjf_params(int priority_ratio, int arrival_time_ratio, int executed_cycle_ratio)
{
  struct proc *p;

  acquire(&ptable.lock);
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    p->priority_ratio = priority_ratio;
    p->arrivetime = arrival_time_ratio;
    p->executed_cycle_ratio = executed_cycle_ratio;
  }
  release(&ptable.lock);
}

int calculate_rank(struct proc *p)
{
  return ((p->priority * p->priority_ratio) +
          (p->arrivetime * p->arrivetime_ratio) +
          (p->executed_cycle * p->executed_cycle_ratio));
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// PAGEBREAK: 42
//  Per-CPU process scheduler.
//  Each CPU calls scheduler() after setting itself up.
//  Scheduler never returns.  It loops, doing:
//   - choose a process to run
//   - swtch to start running that process
//   - eventually that process transfers control
//       via swtch back to the scheduler.
void scheduler(void)
{
  struct proc *p;
  struct cpu *c = mycpu();
  c->proc = 0;

  for (;;)
  {
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    uint found_runnable = 0;
    if (rr_q.pi >= 0)
    {
      p = rr_q.proc[rr_counter % (rr_q.pi + 1)];
      if (p->state == RUNNABLE)
      {
        found_runnable = 1;
      }
      else if (p->state == RUNNING)
      {
        // Find a new process to run for the idle core
        // Loop over queue with amount of its length
        for (int i = 0; i < rr_q.pi; i++)
        {
          if (rr_q.proc[(rr_counter + i + 1) % (rr_q.pi + 1)]->state == RUNNABLE)
          {
            p = rr_q.proc[(rr_counter + i + 1) % (rr_q.pi + 1)];
            found_runnable = 1;
            break;
          }
        }
      }
      else
      {
        panic("No runnable process\n");
      }
    }
    else if (lcfs_q.pi >= 0)
    {
      p = lcfs_q.proc[lcfs_q.pi];
      if (p->state == RUNNABLE)
      {
        found_runnable = 1;
      }
      else if (p->state == RUNNING)
      {
        for (int i = lcfs_q.pi; i > 0; i--)
        {
          if (lcfs_q.proc[i - 1]->state == RUNNABLE)
          {
            p = lcfs_q.proc[i - 1];
            found_runnable = 1;
            break;
          }
        }
      }
      else
      {
        panic("No runnable process\n");
      }
    }
    else if (bjf_q.pi >= 0)
    {
      float worst_rank = 999999999;
      float rank;

      for (int i = 0; i < bjf_q.pi; i++)
      {
        if (bjf_q.proc[i]->state != RUNNABLE)
          continue;

        rank = calculate_rank(bjf_q.proc[i]);

        if (rank < worst_rank)
        {
          p = bjf_q.proc[i];
          worst_rank = rank;
        }
      }
    }
    else
    {
      for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
      {
        if (p->state != RUNNABLE)
        {
          continue;
        }
        // Switch to chosen process.  It is the process's job
        // to release ptable.lock and then reacquire it
        // before jumping back to us.
        p->waiting_time = 0;
        c->proc = p;
        switchuvm(p);
        p->state = RUNNING;

        swtch(&(c->scheduler), p->context);
        switchkvm();

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;
      }
    }
    if (found_runnable)
    {
      p->waiting_time = 0;
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
      swtch(&(c->scheduler), p->context);
      switchkvm();
      c->proc = 0;
    }
    release(&ptable.lock);
  }
}

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void sched(void)
{
  int intena;
  struct proc *p = myproc();

  if (!holding(&ptable.lock))
    panic("sched ptable.lock");
  if (mycpu()->ncli != 1)
    panic("sched locks");
  if (p->state == RUNNING)
    panic("sched running");
  if (readeflags() & FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void yield(void)
{
  acquire(&ptable.lock); // DOC: yieldlock
  // According to TRICKS file
  // Change proc values before RUNNABLE
  myproc()->running_ticks = 0; // reset running ticks to 0
  if (myproc()->q_type == RR)
  {
    rr_counter++;
  }
  if (myproc()->change_running_queue)
  {
    switch (myproc()->q_type)
    {
    case RR:
      rr_q.pi++;
      rr_q.proc[rr_q.pi] = myproc();
      break;
    case LCFS:
      lcfs_q.pi++;
      lcfs_q.proc[lcfs_q.pi] = myproc();
      break;
    case BJF:
      bjf_q.pi++;
      bjf_q.proc[bjf_q.pi] = myproc();
      break;
    default:
      break;
    }
    // Change has been applied
    myproc()->change_running_queue = 0;
  }
  myproc()->state = RUNNABLE;
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first)
  {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();

  if (p == 0)
    panic("sleep");

  if (lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if (lk != &ptable.lock)
  {                        // DOC: sleeplock0
    acquire(&ptable.lock); // DOC: sleeplock1
    release(lk);
  }
  cleanupCorresQueue(p);
  // Cleanup from queue on sleep
  // Go to sleep.
  p->chan = chan;
  p->state = SLEEPING;

  sched();

  // Tidy up.
  p->chan = 0;

  // Reacquire original lock.
  if (lk != &ptable.lock)
  { // DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

// PAGEBREAK!
//  Wake up all processes sleeping on chan.
//  The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if (p->state == SLEEPING && p->chan == chan)
    {
      // Add to queue once again when woken up
      switch (p->q_type)
      {
      case RR:
        rr_q.pi++;
        rr_q.proc[rr_q.pi] = p;
        break;
      case LCFS:
        lcfs_q.pi++;
        lcfs_q.proc[lcfs_q.pi] = p;
        break;
      case BJF:
        bjf_q.pi++;
        bjf_q.proc[bjf_q.pi] = p;
        break;
      default:
        break;
      }
      p->state = RUNNABLE;
    }
}

// Wake up all processes sleeping on chan.
void wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->pid == pid)
    {
      p->killed = 1;
      // Wake process from sleep if necessary.
      if (p->state == SLEEPING)
      {
        if (p->q_type == RR)
        {
          rr_q.pi++;
          rr_q.proc[rr_q.pi] = p;
        }
        else if (p->q_type == LCFS)
        {
          lcfs_q.pi++;
          lcfs_q.proc[lcfs_q.pi] = p;
        }
        else if (p->q_type == BJF)
        {
          bjf_q.pi++;
          bjf_q.proc[bjf_q.pi] = p;
        }
        p->state = RUNNABLE;
      }
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}

// PAGEBREAK: 36
//  Print a process listing to console.  For debugging.
//  Runs when user types ^P on console.
//  No lock to avoid wedging a stuck machine further.
void procdump(void)
{
  static char *states[] = {
      [UNUSED] "unused",
      [EMBRYO] "embryo",
      [SLEEPING] "sleep ",
      [RUNNABLE] "runble",
      [RUNNING] "run   ",
      [ZOMBIE] "zombie"};
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->state == UNUSED)
      continue;
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if (p->state == SLEEPING)
    {
      getcallerpcs((uint *)p->context->ebp + 2, pc);
      for (i = 0; i < 10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}

char *wrap_space(char *inp, char *holder, const int len)
{
  memset(holder, ' ', len);
  holder[len] = 0;
  int n = len;
  int i = 0;
  while (n-- > 0)
  {
    if (*(inp + i) == 0)
      break;
    *(holder + i) = *(inp + i);
    i++;
  }
  return holder;
}

char *wrap_spacei(int inp, char *holder, const int len)
{
  if (inp < 0)
  {
    panic("negative pid or arrive time");
  }
  memset(holder, ' ', len);
  holder[len] = 0;
  int rev = 0;
  int cnt = 0;
  do
  {
    rev *= 10;
    rev += (inp % 10);
    inp /= 10;
    cnt++;
  } while (inp > 0);
  for (int i = 0; i < cnt; i++)
  {
    holder[i] = (rev % 10) + '0';
    rev /= 10;
  }
  return holder;
}

#define NAME_LEN 15
#define PID_LEN 3
#define STATE_LEN 8
#define AT_LEN 10
#define ATR_LEN 1 //Arrive time ratio

#define PR_LEN 13
#define PRR_LEN 1 //Priority ratio

#define EX_LEN 10
#define EXR_LEN 1 //Execution ratio

#define SIZE_LEN 7
#define SIZER_LEN 2 //Size ratio

#define TICKS_LEN 6

void print_proc(void)
{
  struct proc *p;
  char *states[] = {
      [UNUSED] "UNUSED  ",
      [EMBRYO] "EMBRYO  ",
      [SLEEPING] "SLEEPING",
      [RUNNABLE] "RUNNABLE",
      [RUNNING] "RUNNING ",
      [ZOMBIE] "ZOMBIE  "};
  cprintf("name          pid  state    queue  arr_time  priority Ratio:p a e s  exe_cycle  p_size  ticks\n");
  cprintf("..............................................................................\n");
  acquire(&ptable.lock);
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->state == UNUSED)
      continue;
    char name_holder[NAME_LEN + 1];
    char pid_holder[PID_LEN + 1];
    char at_holder[AT_LEN + 1];
    char atr_holder[ATR_LEN + 1];

    char pr_holder[PR_LEN + 1];
    char prr_holder[PRR_LEN + 1];

    char ex_holder[EX_LEN + 1];
    char exr_holder[EXR_LEN + 1];

    char size_holder[SIZE_LEN + 1];
    char sizer_holder[SIZER_LEN + 1];

    char ticks_holder[TICKS_LEN + 1];

    cprintf("%s %s %s   %d   %s %s %s %s %s %s %s %s %s\n",
            wrap_space(p->name, name_holder, NAME_LEN),
            wrap_spacei(p->pid, pid_holder, PID_LEN),
            states[p->state],
            p->q_type,
            wrap_spacei(p->arrivetime, at_holder, AT_LEN),
            wrap_spacei(p->priority, pr_holder, PR_LEN),
            wrap_spacei(p->priority_ratio, prr_holder, PRR_LEN),
            wrap_spacei(p->arrivetime_ratio, atr_holder, ATR_LEN),
            wrap_spacei(p->executed_cycle_ratio, exr_holder, EXR_LEN),
            wrap_spacei(p->size_ratio, sizer_holder, SIZER_LEN),
          
            wrap_spacei(p->running_ticks, ex_holder, EX_LEN),
            wrap_spacei(p->sz, size_holder, SIZE_LEN),
            wrap_spacei(ticks, ticks_holder, TICKS_LEN));
  }
  release(&ptable.lock);
}

void agingMechanism(void)
{
  struct proc *p;
  if (!holding(&ptable.lock))
  {
    acquire(&ptable.lock);
  }
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->state == RUNNABLE)
    {
      p->waiting_time++;
      if (p->waiting_time > AGING_BOUND && p->q_type != RR)
      {
        cleanupCorresQueue(p);
        p->q_type = RR;
        rr_q.pi++;
        rr_q.proc[rr_q.pi] = p;
      }
    }
  }
  release(&ptable.lock);
}

void change_queue(int pid, int queueID)
{
  struct proc *p;
  acquire(&ptable.lock);
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if (p->pid == pid)
    {
      break;
    }
  }
  if (p->pid != pid)
  {
    cprintf("incorrect pid");
    release(&ptable.lock);
    return;
  }
  if (p->state == RUNNING || p->state == RUNNABLE)
  {
    cleanupCorresQueue(p);
  }
  switch (queueID)
  {
  case DEF:
    p->q_type = DEF;
    break;
  case RR:
    p->q_type = RR;
    if (p->state == RUNNABLE)
    {
      rr_q.pi++;
      rr_q.proc[rr_q.pi] = p;
    }
    break;
  case LCFS:
    p->q_type = LCFS;
    if (p->state == RUNNABLE)
    {
      lcfs_q.pi++;
      lcfs_q.proc[lcfs_q.pi] = p;
    }
    break;
  case BJF:
    p->q_type = BJF;
    if (p->state == RUNNABLE)
    {
      bjf_q.pi++;
      bjf_q.proc[bjf_q.pi] = p;
    }
    break;
  default:
    cprintf("undefined queue");
  }

  if (p->state == RUNNING)
  {
    p->change_running_queue = 1;
  }
  release(&ptable.lock);
}