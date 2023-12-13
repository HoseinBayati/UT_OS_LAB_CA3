#include "types.h"
#include "user.h"

int main(int argc, char *argv[])
{

    int pRatio = atoi(argv[1]);
    int aRatio = atoi(argv[2]);
    int eRatio = atoi(argv[3]);
    int sRatio = atoi(argv[4]);

    change_global_bjf(pRatio, aRatio, eRatio, sRatio);

    exit();
}
