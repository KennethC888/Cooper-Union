#include "sem.h"
#include "spinlock.h"
#include "fifo.h"
#include <signal.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>

extern int my_procnum; 
// To compile:
// gcc -o partC fifo.c sem.c spinlock.c tas64.S fifo.h sem.h spinlock.h
// Technically don't need to compile since part D does this already. 

void fifo_init(struct myfifo *f)
{
    f->read_idx = 0;
    f->write_idx = 0;
    f->spinlock = 0;
    sem_init(&f->items, 0); // no items to read
    sem_init(&f->spaces, MYFIFO_BUFSIZE); // 4096 spaces to write
}

void fifo_wr(struct myfifo *f,unsigned long d)
{
    sem_wait(&f->spaces); // wait for space to write

   // spin_lock(&f->spinlock);
    f->buf[f->write_idx % MYFIFO_BUFSIZE] = d;
    f->write_idx++;
    //spin_unlock(&f->spinlock);

    sem_inc(&f->items);
}

unsigned long fifo_rd(struct myfifo *f)
{
    unsigned long d;

    sem_wait(&f->items); // WAIT

    spin_lock(&f->spinlock); // Comment this line to get partD_run_fails.jpg
    d = f->buf[f->read_idx % MYFIFO_BUFSIZE];
    f->read_idx++;
    spin_unlock(&f->spinlock); // Comment this line to get partD_run_fails.jpg

    sem_inc(&f->spaces); 

    return d;
}





