#include <stdint.h>

#include "support.h"
#include "syscall.h"

int main() {
    uint8_t buf[128];
    getargs(buf, 128);

    int kbd = open((uint8_t *)"/dev/kbd");
    uint32_t layout;

    if (!strncmp(buf, (uint8_t*)"qwerty", strlen((uint8_t*)"qwerty"))) {
        layout = QWERTY;
        write(kbd, &layout, 4);
    } else if (!strncmp(buf, (uint8_t*)"dvorak", strlen((uint8_t*)"dvorak"))) {
        layout = DVORAK;
        write(kbd, &layout, 4);
    } else {
        fdputs(1, (uint8_t*)"Did not recognize keyboard layout");
        return 1;
    }

    return 0;
}
