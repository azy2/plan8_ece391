#include <stdint.h>

#include "support.h"
#include "syscall.h"

#define BUFSIZE 1024

int main ()
{
    uint32_t i, cnt, max = 0;
    uint8_t buf[BUFSIZE];

    fdputs(1, (uint8_t*)"Enter the Test Number: (0): 100, (1): 10000, (2): 100000\n");
    if (-1 == (cnt = read(0, buf, BUFSIZE-1)) ) {
        fdputs(1, (uint8_t*)"Can't read the number from keyboard.\n");
        return 3;
    }
    buf[cnt] = '\0';

    if ((strlen(buf) > 1) || ((strlen(buf) == 1) && ((buf[0] < '0') || (buf[0] > '2')))) {
        fdputs(1, (uint8_t*)"Wrong Choice!\n");
        return 0;
    } else {
        switch (buf[0]) {
        case '0':
            max = 100;
            break;
        case '1':
            max = 10000;
            break;
        case '2':
            max = 100000;
            break;
        }
    }

    for (i = 0; i < max; i++) {
        itoa(i+1, buf, 10);
        fdputs(1, buf);
        fdputs(1, (uint8_t*)"\n");
    }

    return 0;
}

