#include "tas.h"
#include "spinlock.h"
#include <sched.h> 
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define N_PROC 64 
int my_procnum = 0; // This value will range between 0 and N_PROC-1, not needed for this program... 

void spin_lock(SPINLOCK *s)
{
    while (tas(s)) 
    {
        sched_yield();  // Allow other threads to run
    }
}

// Unlocks the lock
void spin_unlock(SPINLOCK *s) 
{
    *s = 0; 
}

