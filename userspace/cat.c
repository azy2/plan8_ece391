#include <stdint.h>

#include "support.h"
#include "syscall.h"

int main ()
{
    int32_t fd, cnt;
    uint8_t buf[1024];

    if (0 != getargs (buf, 1024)) {
        fdputs (1, (uint8_t*)"could not read arguments\n");
        return 3;
    }

    if (-1 == (fd = open (buf))) {
        fdputs (1, (uint8_t*)"file not found\n");
        return 2;
    }

    while (0 != (cnt = read (fd, buf, 1024))) {
        if (-1 == cnt) {
            fdputs (1, (uint8_t*)"file read failed\n");
            return 3;
        }
        if (-1 == write (1, buf, cnt))
            return 3;
    }

    return 0;
}

