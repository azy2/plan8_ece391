#include "idt.h"
#include "i8259.h"
#include "lib.h"

void hang(){
    asm volatile(".1: hlt; jmp .1;");
}

void do_divide_error(const struct pt_regs* regs) {
    blue_screen();
    set_cursor(34, 11);
    printf("divide error\n");
    set_cursor(35, 12);
    printf("0x%#x", regs->eip);
    hang();
}

void do_debug(const struct pt_regs* regs) {
    blue_screen();
    set_cursor(37, 11);
    printf("debug\n");
    set_cursor(35, 12);
    printf("0x%#x", regs->eip);
    hang();
}

void do_nmi(const struct pt_regs* regs) {
    blue_screen();
    set_cursor(38, 11);
    printf("nmi\n");
    set_cursor(35, 12);
    printf("0x%#x", regs->eip);
    hang();
}

void do_int3(const struct pt_regs* regs) {
    blue_screen();
    set_cursor(38, 11);
    printf("int3\n");
    set_cursor(35, 12);
    printf("0x%#x", regs->eip);
    hang();
}

void do_overflow(const struct pt_regs* regs) {
    blue_screen();
    set_cursor(36, 11);
    printf("overflow\n");
    set_cursor(35, 12);
    printf("0x%#x", regs->eip);
    hang();
}

void do_bounds(const struct pt_regs* regs) {
    blue_screen();
    set_cursor(37, 11);
    printf("bounds\n");
    set_cursor(35, 12);
    printf("0x%#x", regs->eip);
    hang();
}

void do_invalid_op(const struct pt_regs* regs) {
    blue_screen();
    set_cursor(35, 11);
    printf("invalid_op\n");
    hang();
}

void do_device_not_available(const struct pt_regs* regs) {
    blue_screen();
    set_cursor(30, 11);
    printf("device_not_available\n");
    set_cursor(35, 12);
    printf("0x%#x", regs->eip);
    hang();
}

void do_double_fault(const struct pt_regs* regs, uint32_t error) {
    blue_screen();
    set_cursor(35, 11);
    printf("double fault");
    set_cursor(35, 12);
    printf("0x%#x", regs->eip);
    hang();
}

void do_coprocessor_segment_overrun(const struct pt_regs* regs) {
    blue_screen();
    set_cursor(26, 11);
    printf("coprocessor_segment_overrun\n");
    set_cursor(35, 12);
    printf("0x%#x", regs->eip);
    hang();
}

void do_invalid_TSS(const struct pt_regs* regs, uint32_t error) {
    blue_screen();
    set_cursor(34, 11);
    printf("invalid_TSS\n");
    set_cursor(35, 12);
    printf("0x%#x", regs->eip);
    hang();
}

void do_segment_not_present(const struct pt_regs* regs, uint32_t error) {
    blue_screen();
    set_cursor(30, 11);
    printf("segment_not_present\n");
    set_cursor(35, 12);
    printf("0x%#x", regs->eip);
    hang();
}

void do_stack_segment(const struct pt_regs* regs, uint32_t error) {
    blue_screen();
    set_cursor(34, 11);
    printf("stack_segment\n");
    set_cursor(35, 12);
    printf("0x%#x", regs->eip);
    hang();
}

void do_general_protection(const struct pt_regs* regs, uint32_t error) {
    blue_screen();
    set_cursor(31, 11);
    printf("general_protection\n");
    set_cursor(35, 12);
    printf("0x%#x", regs->eip);
    hang();
}

void do_page_fault(const struct pt_regs* regs, uint32_t error) {
    blue_screen();
    set_cursor(35, 11);
    printf("page_fault\n");
    set_cursor(35, 12);
    printf("0x%#x", regs->eip);
    hang();
}

void do_coprocessor_error(const struct pt_regs* regs) {
    blue_screen();
    set_cursor(35, 11);
    printf("coprocessor_error\n");
    set_cursor(35, 12);
    printf("0x%#x", regs->eip);
    hang();
}

void do_alignment_check(const struct pt_regs* regs, uint32_t error) {
    blue_screen();
    set_cursor(32, 11);
    printf("alignment_check\n");
    set_cursor(35, 12);
    printf("0x%#x", regs->eip);
    hang();
}

void do_machine_check(const struct pt_regs* regs) {
    blue_screen();
    set_cursor(33, 11);
    printf("machine_check\n");
    set_cursor(35, 12);
    printf("0x%#x", regs->eip);
    hang();
}

void do_simd_coprocessor_error(const struct pt_regs* regs) {
    blue_screen();
    set_cursor(29, 11);
    printf("simd_coprocessor_error\n");
    set_cursor(35, 12);
    printf("0x%#x", regs->eip);
    hang();
}

// TODO: Make this support threading and preempt_count. See UTLK page 213
__attribute__((fastcall)) void do_IRQ(const struct pt_regs* regs) {
    int irq = ~(regs->orig_eax);
    irqaction *irq_p = irq_desc[irq];
    while (irq_p) {
        (*irq_p->handle)(irq_p->dev_id);
        irq_p = irq_p->next;
    }
    send_eoi(irq);
}