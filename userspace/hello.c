#include <stdint.h>

#include "support.h"
#include "syscall.h"

#define BUFSIZE 1024

int main ()
{
    int32_t cnt;
    uint8_t buf[BUFSIZE];

    fdputs (1, (uint8_t*)"Hi, what's your name? ");
    if (-1 == (cnt = read (0, buf, BUFSIZE-1))) {
        fdputs (1, (uint8_t*)"Can't read name from keyboard.\n");
        return 3;
    }
    buf[cnt] = '\0';
    fdputs (1, (uint8_t*)"Hello, ");
    fdputs (1, buf);

    return 0;
}

