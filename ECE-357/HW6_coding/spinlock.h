#ifndef SPINLOCK_H
#define SPINLOCK_H
#include <sched.h>

#define N_PROC 64
#define SPINLOCK volatile char 

void spin_lock(SPINLOCK *s);
void spin_unlock(SPINLOCK *s);

#endif




