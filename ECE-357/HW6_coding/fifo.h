#ifndef FIFO_H
#define FIFO_H
#include <sys/types.h>
#include "spinlock.h"
#include "sem.h"

#define N_PROC 64
#define MYFIFO_BUFSIZE 1024 

struct myfifo {
    unsigned long buf[MYFIFO_BUFSIZE];
    unsigned long read_idx;
    unsigned long write_idx;
    SPINLOCK spinlock;
    struct sem items; // counts available items to read
    struct sem spaces; // counts available spaces to write
};

void fifo_init(struct myfifo *f);
void fifo_wr(struct myfifo *f,unsigned long d);
unsigned long fifo_rd(struct myfifo *f);

#endif 