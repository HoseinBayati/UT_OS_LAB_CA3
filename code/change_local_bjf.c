#include "types.h"
#include "user.h"

int main(int argc, char *argv[]) 
{
  
    int pid = atoi(argv[1]);
    int pRatio = atoi(argv[2]);
    int aRatio = atoi(argv[3]);
    int eRatio = atoi(argv[4]);
    change_local_bjf(pid, pRatio, aRatio, eRatio);
 
  
  exit();
} 
