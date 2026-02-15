#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <signal.h>

int main(int argc, char **argv) 
{
    int pipe1[2], pipe2[2];
    pid_t pid1, pid2, pid3;
    int status;
    
    pipe(pipe1);
    pipe(pipe2);

    // IGNORING SIGPIPE
    signal(SIGPIPE, SIG_IGN);

    // wordgen child
    pid1 = fork();
    if (pid1 == 0) {
        dup2(pipe1[1], STDOUT_FILENO);
        close(pipe1[0]);
        close(pipe1[1]);
        close(pipe2[0]);
        close(pipe2[1]);
        
        if (argc > 1) 
        {
            execl("./wordgen", "wordgen", argv[1], NULL);
        } 
        else 
        {
            execl("./wordgen", "wordgen", "0", NULL);
        }
        exit(1);
    }

    // wordsearch child
    pid2 = fork();
    if (pid2 == 0) 
    {
        dup2(pipe1[0], STDIN_FILENO);
        dup2(pipe2[1], STDOUT_FILENO);
        close(pipe1[0]);
        close(pipe1[1]);
        close(pipe2[0]);
        close(pipe2[1]);
        
        execl("./wordsearch", "wordsearch", "dict.txt", NULL);
        exit(1);
    }

    // pager child
    pid3 = fork();
    if (pid3 == 0) 
    {
        dup2(pipe2[0], STDIN_FILENO);
        close(pipe1[0]);
        close(pipe1[1]);
        close(pipe2[0]);
        close(pipe2[1]);
        
        execl("./pager", "pager", NULL);
        exit(1);
    }

    // Parent close all pipes
    close(pipe1[0]);
    close(pipe1[1]);
    close(pipe2[0]);
    close(pipe2[1]);

    // Had a bug where pressing q did nothing, so I checked for (pager) child process and exit status
    // to see if there was a pipe problem, if so, then I would kill the (wordsearch and wordgen child) and report exit status
    waitpid(pid3, &status, 0);
    printf("Child %d finished with status %d\n", pid3, WEXITSTATUS(status));
    
    kill(pid1, SIGTERM);
    kill(pid2, SIGTERM);

    waitpid(pid1, &status, 0);
    printf("Child %d finished with status %d\n", pid1, WEXITSTATUS(status));
    
    waitpid(pid2, &status, 0);
    printf("Child %d finished with status %d\n", pid2, WEXITSTATUS(status));

    return 0;
}