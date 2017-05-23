#include <stdint.h>

#include "support.h"
#include "syscall.h"

#define SBUFSIZE 33

typedef struct fstat {
    uint8_t type;
    uint32_t size;
}fstat_t;

int main ()
{
    int32_t fd, cnt;
    uint8_t buf[SBUFSIZE];

    uint8_t args[128];
    getargs(args, 128);

    if (-1 == (fd = open ((uint8_t*)"."))) {
        fdputs (1, (uint8_t*)"directory open failed\n");
        return 2;
    }

    if (!strcmp(args, (uint8_t*)"-l")) {
        uint8_t text[33];
        fstat_t data;
        uint32_t it;
        while((read(fd, text, 33) != 0)) {
            text[32] = 0;
            printf((int8_t *)"File Name: %s",text);
            for(it = 0; it < 35 - strlen(text); it++)
                printf((int8_t *)" ");
            stat(fd, &data, sizeof(fstat_t));
            printf((int8_t*)"File Type: %d    File Size: %dB\n", data.type, data.size);
        }

    } else {
        while (0 != (cnt = read (fd, buf, SBUFSIZE-1))) {
            if (-1 == cnt) {
                fdputs (1, (uint8_t*)"directory entry read failed\n");
                return 3;
            }
            buf[cnt] = '\n';
            if (-1 == write (1, buf, cnt + 1))
                return 3;
        }
    }
    return 0;
}
