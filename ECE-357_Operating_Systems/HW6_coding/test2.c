#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <signal.h>
#include "fifo.h"
#include "sem.h"
#include "spinlock.h"

extern int my_procnum;

// To compile:
// gcc -o partD test2.c fifo.c sem.c spinlock.c tas64.S fifo.h sem.h spinlock.h

int main()
{
    int start_waiting = 0; 
    int number_writers = 7; // FFVII 
    int num_iterations = 88888; // LUCKY 

    printf("FIFO TEST with %d writers and %d iterations.\n", number_writers, num_iterations);
    struct myfifo *fifo = mmap(NULL, sizeof(struct myfifo), PROT_READ | PROT_WRITE,MAP_SHARED | MAP_ANONYMOUS, -1, 0);

    if (fifo == MAP_FAILED) {
        perror("mmap");
        exit(1);
    }

    fifo_init(fifo);

    for (int i = 0; i < number_writers; i++) 
    {
        pid_t pid = fork();

        if (pid < 0) 
        {
            perror("fork");
            exit(1);
        } 
        else if (pid == 0) 
        {
            my_procnum = i;
            for (int j = 0; j < num_iterations; j++) 
            {
                unsigned long item = (unsigned long)(i * num_iterations + j);
                fifo_wr(fifo, item);
            }

            my_procnum = i; 
            printf("Writer %d completed.\n", i);
            fflush(stdout);
            exit(0);
        }
    }


    // Only one reader 
    pid_t reader_pid = fork();
    if (reader_pid < 0) 
    {
    perror("fork failed");
    exit(1);
    }

    else if (reader_pid == 0) 
    {
        my_procnum = number_writers;
        // This is the reader child
        unsigned long last_seen[number_writers];
        for (int w = 0; w < number_writers; w++)
        {
            last_seen[w] = (unsigned long) - 1;
        }

        long total_items = number_writers * num_iterations;

        for (long n = 0; n < total_items; n++) 
        {
            unsigned long value = fifo_rd(fifo);

            // decode (writer_id, sequence_number)
            unsigned long writer_id = value / num_iterations;
            unsigned long seq_num   = value % num_iterations;

            // check if seq_num is correct for this writer
            if (seq_num != last_seen[writer_id] + 1) 
            {
                printf("ERROR: writer %lu expected seq %lu, got %lu\n", writer_id, last_seen[writer_id] + 1, seq_num);
                exit(1);
            }

            // update last seen sequence number for that writer
            last_seen[writer_id] = seq_num;

            // If this writer's final item arrived, print completion
            if (seq_num == num_iterations - 1) 
            {
                printf("Reader stream %lu completed\n", writer_id);
                fflush(stdout);
            }
        }

        printf("All values read correctly.\n");
        fflush(stdout);
        start_waiting = 1;
        exit(0);
    }
    int status;

    // First wait for the reader to finish
    waitpid(reader_pid, &status, 0);

    printf("Parent waiting for writers to finish...\n");

    // Now wait for writers
    for (int i = 0; i < number_writers; i++) {
        wait(NULL);
    }

    printf("Test completed successfully.\n");
    return 0;

}