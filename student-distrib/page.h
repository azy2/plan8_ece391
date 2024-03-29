#ifndef PAGE_H
#define PAGE_H
#include "types.h"
#include "task.h"

#define DIR_SIZE 1024
#define TABLE_SIZE (DIR_SIZE * 4)
#define PAGE_RW 2
#define VIDEO   0x000B8000
#define KERNEL  0x00400000
#define KB 0x400
#define KB4 0x1000
#define MB 0x00100000
#define MB4 0x00400000
#define TASK_ADDR (128 * MB)
#define USR_CODE_OFFSET 0x48000
#define PER_TASK_KERNEL_STACK_SIZE 0x2000

typedef struct __attribute__((packed)) page_dir_kb_entry{
    uint32_t present : 1;
    uint32_t readWrite  : 1;
    uint32_t userSupervisor : 1;
    uint32_t writeThrough : 1;
    uint32_t cacheDisabled : 1;
    uint32_t accessed : 1;
    uint32_t reserved : 1;
    uint32_t pageSize : 1;
    uint32_t global : 1;
    uint32_t avail : 3;
    uint32_t addr : 20;
} page_dir_kb_entry_t;

typedef struct __attribute__((packed)) page_dir_mb_entry{
    uint32_t present : 1;
    uint32_t readWrite  : 1;
    uint32_t userSupervisor : 1;
    uint32_t writeThrough : 1;
    uint32_t cacheDisabled : 1;
    uint32_t accessed : 1;
    uint32_t dirty : 1;
    uint32_t pageSize : 1;
    uint32_t global : 1;
    uint32_t avail : 3;
    uint32_t pgTblAttIdx : 1;
    uint32_t reserved : 9;
    uint32_t addr : 10;
} page_dir_mb_entry_t;

typedef struct __attribute__((packed)) page_table_kb_entry{
    uint32_t present : 1;
    uint32_t readWrite  : 1;
    uint32_t userSupervisor : 1;
    uint32_t writeThrough : 1;
    uint32_t cacheDisabled : 1;
    uint32_t accessed : 1;
    uint32_t dirty : 1;
    uint32_t pgTblAttIdx : 1;
    uint32_t global : 1;
    uint32_t avail : 3;
    uint32_t addr : 20;
} page_table_kb_entry_t;

uint32_t page_directory_tables[NUM_TASKS][DIR_SIZE] __attribute__((aligned (KB4)));
uint32_t page_tables[NUM_TASKS][2][DIR_SIZE] __attribute__((aligned (KB4)));

// Sets PG, PSE, and PE flags
extern void init_paging();

//moves directory address to CR3
extern void switch_page_directory(int pd);

#endif // PAGE_H
