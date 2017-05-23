#include <stdint.h>

#include "support.h"
#include "syscall.h"

int main () {
    fdputs (1, (uint8_t*)"Hello, if this ran, the program was correct. Yay!\n");

    return 0;
}

