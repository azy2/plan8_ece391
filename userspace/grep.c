#include <stdint.h>

#include "support.h"
#include "syscall.h"

#define BUFSIZE 1024
#define SBUFSIZE 33

int32_t
do_one_file (const char* s, const char* fname) 
{
    int32_t fd, cnt, last, line_start, line_end, check, s_len;
    uint8_t data[BUFSIZE+1];

    s_len = strlen ((uint8_t*)s);
    if (-1 == (fd = open ((uint8_t*)fname))) {
        fdputs (1, (uint8_t*)"file open failed\n");
        return -1;
    }
    last = 0;
    while (1) {
        cnt = read (fd, data + last, BUFSIZE - last);
        if (-1 == cnt) {
            fdputs (1, (uint8_t*)"file read failed\n");
            return -1;
        }
        last += cnt;
        line_start = 0;
        while (1) {
            line_end = line_start;
            while (line_end < last && '\n' != data[line_end])
                line_end++;
            if ('\n' != data[line_end] && 0 != cnt && line_start != 0) {
                /* copy from line_start to last down to 0 and fix last */
                data[line_end] = '\0';
                strcpy (data, data + line_start);
                last -= line_start;
                break;
            }
            /* search the line */
            data[line_end] = '\0';
            for (check = line_start; check < line_end; check++) {
                if (s[0] == data[check] && 
                    0 == strncmp ((uint8_t*)(data + check), (uint8_t*)s, s_len)) {
                    fdputs (1, (uint8_t*)fname);
                    fdputs (1, (uint8_t*)":");
                    fdputs (1, data + line_start);
                    fdputs (1, (uint8_t*)"\n");
                    break;
                }
            }
            line_start = line_end + 1;
            if (line_start >= last) {
                last = 0;
                break;
            }
        }
        if (0 == cnt)
            break;
    }
    if (-1 == close (fd)) {
        fdputs (1, (uint8_t*)"file close failed\n");
        return -1;
    }
    return 0;
}

int main ()
{
    int32_t fd, cnt;
    uint8_t buf[SBUFSIZE];
    uint8_t search[BUFSIZE];

    if (0 != getargs (search, BUFSIZE)) {
        fdputs (1, (uint8_t*)"could not read argument\n");
        return 3;
    }

    if (-1 == (fd = open ((uint8_t*)"."))) {
        fdputs (1, (uint8_t*)"directory open failed\n");
        return 2;
    }

    while (0 != (cnt = read (fd, buf, SBUFSIZE-1))) {
        if (-1 == cnt) {
            fdputs (1, (uint8_t*)"directory entry read failed\n");
            return 3;
        }
        if ('.' == buf[0]) /* a directory... */
            continue;
        buf[cnt] = '\0';
        if (0 != do_one_file ((char*)search, (char*)buf))
            return 3;
    }

    return 0;
}
