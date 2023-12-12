// init: The initial user-level program

#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

char *argv[] = { "sh", 0 };

int
main(void)
{
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }

  dup(0);  // stdout
  dup(0);  // stderr

  for(;;){
    printf(1, "init: starting sh\n\n");
    printf(1, "Group 11:\n");

    printf(1, " - Hosein Bayati        810198366\n");
    printf(1, " - Amirreza Kaffashan   810899064\n");
    printf(1, " - Hossein Noroozi      810899073\n");

    printf(1 , "\nCommands:\n");
    printf(1 , " 1. get_status: show to status of all available processes\n");
    printf(1 , " 2. set_queue: set the queue of a process\n");
    printf(1 , " 3. set_bjf_params: set the bjf params of a process\n");
    printf(1 , " 4. set_all_bjf_params: set the bjf params of all processes\n\n");

    pid = fork();
    if(pid < 0){
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  }
}
