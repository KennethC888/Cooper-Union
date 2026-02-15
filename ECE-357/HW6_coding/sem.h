#ifndef SEM_H
#define SEM_H
#include <sys/types.h>
#include "spinlock.h"

#define N_PROC 64

struct sem {
    int count;
    SPINLOCK spinlock;
    unsigned char waiting[N_PROC];
    pid_t pids[N_PROC];
};

void sem_init(struct sem *s, int count);
int  sem_try(struct sem *s);
void sem_wait(struct sem *s);
void sem_inc(struct sem *s);

#endif
