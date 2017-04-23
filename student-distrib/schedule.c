#include "schedule.h"
#include "idt.h"
#include "task.h"
#include "page.h"
#include "system_calls.h"
#include "lib.h"
#include "x86_desc.h"
#include "i8259.h"

uint32_t term_process[NUM_TERM] = {0, 0, 0};

uint32_t active = 0;

bool interupt_preempt = false;

static int cur_p = 0;

#define PIT_PORT_COMMAND 0x43
#define PIT_PORT_CHANNEL_0 0x40
#define LOW_FREQ_BYTE 0
// ~15ms time slices
#define HIGH_FREQ_BYTE 75

static bool dont_send_eoi = false;

void reschedule() {
    cli();

    outb(LOW_FREQ_BYTE, PIT_PORT_CHANNEL_0);
    outb(HIGH_FREQ_BYTE, PIT_PORT_CHANNEL_0);

    sti();

    dont_send_eoi = true;

    asm volatile("int $0x20;");
}

void schedule() {
    uint32_t ebp;
    asm volatile("movl %%ebp, %0;" : "=r"(ebp) : );
    tasks[cur_task]->ebp = ebp;

    if (interupt_preempt) {
        cur_task = term_process[active];
        interupt_preempt = false;
    } else {

        cur_task = INIT;

        // Starting with the task after the last one scheduled look for the
        // first task that is TASK_RUNNING, but skip over INIT.
        // If no task needs to be scheduled, only then do we schedule INIT
        int i;
        for (i = 0; i < (NUM_TASKS - 1); i++) {
            uint8_t task_i = ((cur_p + i) % (NUM_TASKS - 1)) + 1;
            if (tasks[task_i]->status == TASK_RUNNING) {
                cur_task = task_i;
                cur_p = task_i;
                break;
            }
        }
    }

    switch_page_directory(cur_task);

    tss.esp0 = tasks[cur_task]->kernel_esp;

    ebp = tasks[cur_task]->ebp;
    asm volatile("movl %0, %%ebp \n" : : "r"(ebp));

    if (dont_send_eoi) {
        dont_send_eoi = false;
    } else {
        send_eoi(0);
    }
    // GCC compiles this function with no leave call. Thus the ebp becomes useless.
    asm volatile("leave; ret;" : :);
}

void pit_init(){
    // 00110100b - Magic (sets the pit up for regular interrupts on IRQ0)
    outb(0x34, PIT_PORT_COMMAND);
    outb(LOW_FREQ_BYTE, PIT_PORT_CHANNEL_0);
    outb(HIGH_FREQ_BYTE, PIT_PORT_CHANNEL_0);
}


