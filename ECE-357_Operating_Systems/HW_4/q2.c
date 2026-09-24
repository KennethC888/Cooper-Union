#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <errno.h>
#include <fcntl.h>
#include <ctype.h>
#include <signal.h>
#include <unistd.h>
#include <sys/wait.h>
#include <time.h>

int niter;
volatile int count;

void hh(int sig)
{
    count++;
}

void xx(int sig)
{
    fprintf(stderr, "Child got signal %d, count is %d\n", sig, count);
    exit(128);
}

int main(int argc, char **argv)
{
    struct sigaction sa;
    int i, cpid, ws, signum;
    struct timespec ts;

    if (argc != 3) {
        fprintf(stderr, "Usage: %s <niter> <signum>\n", argv[0]);
        exit(1);
    }

    niter = atoi(argv[1]); //num interations
    signum = atoi(argv[2]); //signal number

    sa.sa_handler = hh;
    sa.sa_flags = 0;  // deprecated, use SA_NODEFER in modern Linux, normally set to SA_NOMASK
    sigemptyset(&sa.sa_mask);
    sigaction(signum, &sa, NULL);

    signal(SIGINT, xx);

    switch (cpid = fork()) {
    case 0: // child
        for (;;) ; // infinite loop
        fprintf(stderr, "Child broke loop\n");
        exit(1);

    default: // parent
        for (i = 0; i < niter; i++)
            kill(cpid, signum);

        ts.tv_sec = 1;
        ts.tv_nsec = 0;
        nanosleep(&ts, 0);

        kill(cpid, SIGINT);
        break;
    }

    wait(&ws);
    fprintf(stderr, "Parent got wait status %x\n", ws);
    return 0;
}
// to run: ./a.out 100000 15 (argument needs two numbers, number interations and signal number)
