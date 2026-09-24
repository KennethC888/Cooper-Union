#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include "spinlock.h"
// Note: It takes a while to compile  
// To compile: 
// gcc -o partA test.c spinlock.c tas64.S spinlock.h 

struct shared_data
{
    SPINLOCK lock;
    int counter;
}; 

int main() 
{

    const int NUM_ITERATIONS = 1000000;
    int my_procnum = 0; // This value will range between 0 and N_PROC-1, not needed for this program... 

    // Create shared memory for the spinlock and counter
    struct shared_data *shared_data = mmap(NULL, sizeof(shared_data), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
    if (shared_data == MAP_FAILED) 
    {
        perror("mmap");
        exit(EXIT_FAILURE);
    }

    shared_data->lock = 0;
    shared_data->counter = 0;

    // CHILD PROCESSES
    for (int my_procnum = 0; my_procnum < N_PROC; my_procnum++) 
    {
        pid_t pid = fork();
        if (pid < 0) 
        {
            perror("fork");
            exit(EXIT_FAILURE);
        } 
        else if (pid == 0) 
        {
            for (int j = 0; j < NUM_ITERATIONS; j++) 
            {
                spin_lock(&shared_data->lock); //Comment out this line to see what happens without spinlock 
                shared_data->counter++;
                spin_unlock(&shared_data->lock); //Comment out this line to see what happens without spinlock 
            }
            exit(EXIT_SUCCESS);
        }
    }

    // Parent waits for children to finish and exit
    for (int i = 0; i < N_PROC; i++) 
    {
        wait(NULL);
    }

    printf("Result of counter incrementing: %d\n", shared_data->counter);
    return 0;
}

