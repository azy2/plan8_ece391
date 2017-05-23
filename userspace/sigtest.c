#include <stdint.h>

#include "support.h"
#include "syscall.h"

#define BUFSIZE 1024

static uint8_t charbuf;
static volatile uint8_t* badbuf = 0;
void segfault_sighandler (int signum);
void alarm_sighandler (int signum);

int main ()
{
    int32_t cnt;
    uint8_t buf[BUFSIZE];

    if (0 != getargs (buf, BUFSIZE)) {
        fdputs (1, (uint8_t*)"could not read argument\n");
        return 3;
    }

    if (buf[0] == '1') {
        fdputs(1, (uint8_t*)"Installing signal handlers\n");
        set_handler(SEGFAULT, segfault_sighandler);
        set_handler(ALARM, alarm_sighandler);
    }

    fdputs (1, (uint8_t*)"Hi, what's your name? ");
    if (-1 == (cnt = read (0, buf, BUFSIZE-1))) {
        fdputs (1, (uint8_t*)"Can't read name from keyboard.\n");
        return 3;
    }

    (*badbuf) = 1;
    buf[cnt] = '\0';
    fdputs (1, (uint8_t*)"Hello, ");
    fdputs (1, buf);
    if (charbuf == 1) {
        fdputs(1, (uint8_t*)"success\n");
    } else {
        fdputs(1, (uint8_t*)"failure\n");
    }

    return 0;
}

void
segfault_sighandler (int signum)
{
    char buf;
    uint32_t* eax;
    fdputs(1, (uint8_t*)"Segfault signal handler called, signum: ");
    switch (signum) {
    case 0: fdputs(1, (uint8_t*)"0\n"); break;
    case 1: fdputs(1, (uint8_t*)"1\n"); break;
    case 2: fdputs(1, (uint8_t*)"2\n"); break;
    case 3: fdputs(1, (uint8_t*)"3\n"); break;
    default: fdputs(1, (uint8_t*)"invalid\n"); break;
    }
    fdputs(1, (uint8_t*)"Press enter to continue...\n");
    read(0, &buf, 1);
    badbuf = &charbuf;
    eax = (uint32_t*)(&signum + 7);
    *eax = (uint32_t)&charbuf;

    fdputs(1, (uint8_t*)"Signal handler returning\n");
}

void
alarm_sighandler (int signum)
{
    fdputs(1, (uint8_t*)"Alarm signal handler called, signum: ");
    switch (signum) {
    case 0: fdputs(1, (uint8_t*)"0\n"); break;
    case 1: fdputs(1, (uint8_t*)"1\n"); break;
    case 2: fdputs(1, (uint8_t*)"2\n"); break;
    case 3: fdputs(1, (uint8_t*)"3\n"); break;
    default: fdputs(1, (uint8_t*)"invalid\n"); break;
    }
}
