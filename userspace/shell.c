#include <stdint.h>

#include "support.h"
#include "syscall.h"

#define BUFSIZE 1024

int main ()
{
    int32_t cnt, rval;
    uint8_t buf[BUFSIZE];
    fdputs (1, (uint8_t*)"Starting 391 Shell\n");

    while (1) {
        fdputs (1, (uint8_t*)"391OS> ");
        if (-1 == (cnt = read (0, buf, BUFSIZE-1))) {
            fdputs (1, (uint8_t*)"read from keyboard failed\n");
            return 3;
        }
        if (cnt > 0 && '\n' == buf[cnt - 1])
            cnt--;
        buf[cnt] = '\0';
        if (0 == strcmp (buf, (uint8_t*)"exit"))
            return 0;
        if ('\0' == buf[0])
            continue;
        rval = execute (buf);
        if (-1 == rval)
            fdputs (1, (uint8_t*)"no such command\n");
        else if (256 == rval)
            fdputs (1, (uint8_t*)"program terminated by exception\n");
        else if (0 != rval)
            fdputs (1, (uint8_t*)"program terminated abnormally\n");
    }
}

