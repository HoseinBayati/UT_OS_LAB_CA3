#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char* argv[])
{
    char first = *(argv[1]);
    if((strcmp(argv[1], "print") == 0 && argc == 2) ||
        (strcmp(argv[1], "ticket") == 0 && argc == 4) ||
        (strcmp(argv[1], "change") == 0 && argc == 4))
    {
        switch((int)(first))
        {
            case (int)('p'):
                print_proc();
                break;
            case (int)('c'):
                change_queue(atoi(argv[2]), atoi(argv[3]));
                break;
            default:
                printf(1, "unknown\n");
                return 0;
        }
    }
    else
    {
        printf(1, "no such command \n");
    }
    exit();    
}