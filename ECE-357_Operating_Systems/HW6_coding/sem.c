#include "sem.h"
#include "spinlock.h"
#include <signal.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>

extern int my_procnum;
// To compile: 
// gcc -o partB sem.c spinlock.c tas64.S sem.h spinlock.h
// NOTE: To run part B, add the main function 
// int main()
// {
//     return 0;
// }

static void handler(int x) { } // Wakes up from sigsuspend, does nothing else 

void sem_init(struct sem *s, int count) // Set everything to 0 
{
    s->count = count;
    s->spinlock = 0; // lock is open

    for (int i = 0; i < N_PROC; i++) {
        s->waiting[i] = 0;
        s->pids[i] = 0; 
    }

    signal(SIGUSR1, handler); // SIGRUSR1 will be used to wake up waiting processes 
}

int sem_try(struct sem *s)
{
    int aura_loss = 0; // Were we able to decrement or get the semaphore/resources without waiting? 
    spin_lock(&s->spinlock);
    if (s->count > 0) {
        s->count--;
        aura_loss = 1;
    }
    spin_unlock(&s->spinlock);
    return aura_loss;
}

void sem_wait(struct sem *s)
{
    sigset_t set, oldset, tmp;
    sigemptyset(&set);
    sigaddset(&set, SIGUSR1);

    sigprocmask(SIG_BLOCK, &set, &oldset); // JUST LIKE HW6 PROBLEM 1 

    for (;;) {
        spin_lock(&s->spinlock);

        if (s->count > 0) {
            s->count--;
            spin_unlock(&s->spinlock);
            sigprocmask(SIG_SETMASK, &oldset, NULL);
            return;
        }

        if (!s->waiting[my_procnum]) {
            s->waiting[my_procnum] = 1;
            s->pids[my_procnum] = getpid();
        }

        spin_unlock(&s->spinlock);

        tmp = oldset;
        sigdelset(&tmp, SIGUSR1);
        sigsuspend(&tmp);
    }
}

void sem_inc(struct sem *s)
{
    pid_t wakes[N_PROC];
    int n = 0;

    spin_lock(&s->spinlock);
    s->count++;

    for (int i = 0; i < N_PROC; i++) {
        if (s->waiting[i]) {
            wakes[n++] = s->pids[i];
            s->waiting[i] = 0;
            s->pids[i] = 0;
        }
    }

    spin_unlock(&s->spinlock);

    for (int i = 0; i < n; i++) {
        kill(wakes[i], SIGUSR1);
    }
}

// Uncomment to run part B, but it doesn't do anything when you compile and ./partB
// int main()
// {
//     return 0;
// }
