#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

void
sys_print_proc(void)
{
  // since ptable is only accessible in proc.c
  // we need yet another wrapper or
  // could've used extern keyword
  print_proc();
}

int
sys_change_queue(void)
{
  int pid;
  int queueID;
  if(argint(0, &pid) < 0 ||
    argint(1, &queueID) < 0 ||
    (queueID != DEF &&
    queueID != RR &&
    queueID != LCFS &&
    queueID != BJF))
  {
    return -1;
  }
  change_queue(pid, queueID);
  return 0;
}

int
sys_change_local_bjf(void)
{
  int pid;
  int pRatio;
  int aRatio;
  int eRatio;
  int sRatio;

  if(argint(0, &pid) < 0 || argint(1, &pRatio) < 0 || argint(2, &aRatio) < 0 || argint(3, &eRatio) < 0 || argint(4, &sRatio) < 0)
    return -1;

  return change_local_bjf(pid, pRatio, aRatio, eRatio, sRatio);
}
int
sys_change_global_bjf(void)
{
  int pRatio;
  int aRatio;
  int eRatio;
  int sRatio;

  if(argint(0, &pRatio) < 0 || argint(1, &aRatio) < 0 || argint(2, &eRatio) < 0 || argint(3, &sRatio) < 0)
    return -1;

  return change_global_bjf(pRatio, aRatio, eRatio, sRatio);
}