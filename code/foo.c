#include "types.h"
#include "stat.h"
#include "user.h"

#define HIGH 100000


int main()
{
    if(!fork())
    {
        calc(HIGH);
        exit();
    }
    else if(!fork())
    {
        calc(HIGH);
        exit();
    }
    else if(!fork())
    {
        calc(HIGH);
        exit();
    }
    else if(!fork())
    {
        calc(HIGH);
        exit();
    }
    else if(!fork())
    {
        calc(HIGH);
        exit();
    }
    else if(!fork())
    {
        calc(HIGH);
        exit();
    }
    else if(!fork())
    {
        calc(HIGH);
        exit();
    }
    else if(!fork())
    {
        calc(HIGH);
        exit();
    }
    else
    {
        calc(HIGH);
        while(wait() != -1);
    }
    exit();
}

// #include "types.h"
// #include "stat.h"
// #include "user.h"
// #include "fcntl.h"

// int main(int argc, char *argv[])
// {
//     int temp = 0;
//     int pid[10];
//     for (int i = 0 ; i < 10 ; i++)
//     {
//         temp = 0;
//         pid[i] = fork();
//         if(pid[i] < 0)
//             printf(1 , "fork failed\n");
//         if (pid[i] == 0)
//         {
//             for (int j = 0 ; j < 10000000000 ; j++)                     // remove one 0 from it for testing it faster
//                 temp++;
//             exit();
//         }
//     }
//     while(wait());
//     return 0;
// }