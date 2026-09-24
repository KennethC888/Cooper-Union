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

typedef struct {
    char *cmd;             // Command name (like ls)
    char **argv;           // Argument list for execvp()
    char *stdin_file;      // input redirection "<"
    char *stdout_file;     // stdout redirection ">", ">>"
    char *stderr_file;     // stderr redirection "2>", "2>>"
    int append_stdout;     // 1 if ">>"
    int append_stderr;     // 1 if "2>>"
} command_t;

// Read a command line from stdin or a script file
char *read_command_line(FILE *input) {
    char *line = NULL;
    size_t len = 0;
    ssize_t read;  
    read = getline(&line, &len, input);
    if (read == -1) {
        free(line);
        return NULL;
    }
    // Remove trailing newline if present
    if (line[read - 1] == '\n') {
        line[read - 1] = '\0';
    }
    return line;
}

int parse_command_line(char *line, command_t *cmd)
{
    // Initialize fields
    cmd->cmd = NULL;
    cmd->argv = NULL;
    cmd->stdin_file = NULL;
    cmd->stdout_file = NULL;
    cmd->stderr_file = NULL;
    cmd->append_stdout = 0;
    cmd->append_stderr = 0;

    char *token = strtok(line, " \t");
    int argc = 0;
    char **argv = malloc(100 * sizeof(char*));

    while (token != NULL) {
        if (strncmp(token, "<", 1) == 0) {
            // Handle "<file"
            if (strlen(token) == 1) {
                fprintf(stderr, "Error: space after '<' not supported\n");
                free(argv);
                return -1;
            }
            cmd->stdin_file = strdup(token + 1);

        } else if (strncmp(token, ">>", 2) == 0) {
            // Handle ">>file"
            if (strlen(token) == 2) {
                fprintf(stderr, "Error: space after '>>' not supported\n");
                free(argv);
                return -1;
            }
            cmd->stdout_file = strdup(token + 2);
            cmd->append_stdout = 1;

        } else if (strncmp(token, ">", 1) == 0) {
            // Handle ">file"
            if (strlen(token) == 1) {
                fprintf(stderr, "Error: space after '>' not supported\n");
                free(argv);
                return -1;
            }
            cmd->stdout_file = strdup(token + 1);
            cmd->append_stdout = 0;

        } else if (strncmp(token, "2>>", 3) == 0) {
            // Handle "2>>file"
            if (strlen(token) == 3) {
                fprintf(stderr, "Error: space after '2>>' not supported\n");
                free(argv);
                return -1;
            }
            cmd->stderr_file = strdup(token + 3);
            cmd->append_stderr = 1;

        } else if (strncmp(token, "2>", 2) == 0) {
            // Handle "2>file"
            if (strlen(token) == 2) {
                fprintf(stderr, "Error: space after '2>' not supported\n");
                free(argv);
                return -1;
            }
            cmd->stderr_file = strdup(token + 2);
            cmd->append_stderr = 0;

        } else {
            // Regular command argument
            argv[argc++] = strdup(token);
        }

        token = strtok(NULL, " \t");
    }

    argv[argc] = NULL;
    if (argc > 0)
        cmd->cmd = strdup(argv[0]);
    cmd->argv = argv;

    return 0;
}


int handle_builtin(command_t *cmd, int *last_status) {
    
    if (cmd->cmd == NULL) 
    {
        return 0;
    }
    if (strcmp(cmd->cmd, "cd") == 0) 
    {
        if (cmd->argv[1] == NULL || strcmp(cmd->argv[1], "~") == 0) 
        {
            const char *home = getenv("HOME");
            if (home == NULL) 
            {
                fprintf(stderr, "cd: HOME not set\n");
                *last_status = 1;
                return 1;
            }
            if (chdir(home) != 0) 
            {
                perror("cd");
                *last_status = 1;
            } 
            else 
            {
                *last_status = 0;
            }
        } 
        else 
        {
            if (chdir(cmd->argv[1]) != 0) 
            {
                perror("cd");
                *last_status = 1;
            } 
            else 
            {
                *last_status = 0;
            }
        }
        return 1;
    } 
    else if (strcmp(cmd->cmd, "pwd") == 0) 
    {
        char cwd[1024];
        if (getcwd(cwd, sizeof(cwd)) != NULL) 
        {
            printf("%s\n", cwd);
            *last_status = 0;
        } 
        else 
        {
            perror("pwd");
            *last_status = 1;
        }
        return 1;
    } 
    else if (strcmp(cmd->cmd, "exit") == 0) 
    {
        int exit_code = *last_status; // default exit code
        if (cmd->argv[1] != NULL) 
        {
            exit_code = atoi(cmd->argv[1]);
        }
        fprintf(stderr, "exit command received, exiting shell with exit code %d\n", exit_code);
        exit(exit_code);
    }

    return 0;
}

int setup_redirections(command_t *cmd) {
   
    int fd;
    if (cmd->stdin_file) {
        fd = open(cmd->stdin_file, O_RDONLY);
        if (fd == -1) {
            perror("open stdin");
            return -1;
        }
        if (dup2(fd, STDIN_FILENO) == -1) {
            perror("dup2 stdin");
            close(fd);
            return -1;
        }
        close(fd);
    }
    if (cmd->stdout_file) {
        int flags = O_WRONLY | O_CREAT;
        if (cmd->append_stdout) {
            flags |= O_APPEND;
        } else {
            flags |= O_TRUNC;
        }
        fd = open(cmd->stdout_file, flags, 0644);
        if (fd == -1) {
            perror("open stdout");
            return -1;
        }
        if (dup2(fd, STDOUT_FILENO) == -1) {
            perror("dup2 stdout");
            close(fd);
            return -1;
        }
        close(fd);
    }
    if (cmd->stderr_file) {
        int flags = O_WRONLY | O_CREAT;
        if (cmd->append_stderr) {
            flags |= O_APPEND;
        } else {
            flags |= O_TRUNC;
        }
        fd = open(cmd->stderr_file, flags, 0644);
        if (fd == -1) {
            perror("open stderr");
            return -1;
        }
        if (dup2(fd, STDERR_FILENO) == -1) {
            perror("dup2 stderr");
            close(fd);
            return -1;
        }
        close(fd);
    }

    return 0;
}

void report_status(pid_t pid, struct rusage *usage, struct timeval start, struct timeval end, int status) {
    fprintf(stderr, "Child process %d ", pid);
    if (WIFEXITED(status)) {
        fprintf(stderr, "exited normally with status %d\n", WEXITSTATUS(status));
    } else if (WIFSIGNALED(status)) {
        fprintf(stderr, "with signal %d\n", WTERMSIG(status));
    } else {
        fprintf(stderr, "terminated abnormally\n");
    }


    long real_usec = (end.tv_sec - start.tv_sec) * 1000000 + (end.tv_usec - start.tv_usec);
    long user_usec = usage->ru_utime.tv_sec * 1000000 + usage->ru_utime.tv_usec;
    long sys_usec = usage->ru_stime.tv_sec * 1000000 + usage->ru_stime.tv_usec;
    fprintf(stderr, "Real time: %ld ms, User time: %ld ms, Sys time: %ld ms\n",
        real_usec / 1000, user_usec / 1000, sys_usec /1000);
}

int execute_external(command_t *cmd) {
    pid_t pid;
    int status;
    struct rusage usage;
    struct timeval start, end;

    if (cmd->cmd == NULL) {
        return 0; // Nothing to execute
    }

    gettimeofday(&start, NULL);

    pid = fork();
    if (pid == -1) {
        perror("fork");
        return 1;
    }

    if (pid == 0) {
        // Child process
        if (setup_redirections(cmd) == -1) {
            exit(1); // Redirection setup failed
        }
        execvp(cmd->cmd, cmd->argv);
        // If execvp returns, an error occurred
        perror("execvp");
        exit(1);
    }

    // Parent process
    
    wait4(pid, &status, 0, &usage);
    gettimeofday(&end, NULL);
    report_status(pid, &usage, start, end, status);

    return WEXITSTATUS(status);
}

void free_command(command_t *cmd) {
    
    free(cmd->cmd);
    // Free redirection file strings
    if (cmd->stdin_file) free(cmd->stdin_file);
    if (cmd->stdout_file) free(cmd->stdout_file);
    if (cmd->stderr_file) free(cmd->stderr_file);
    // Free argument list
    if (cmd->argv) {
        for (int i = 0; cmd->argv[i] != NULL; i++) {
            free(cmd->argv[i]);
        }
        free(cmd->argv);
    }
}

int main(int argc, char *argv[]) {
    FILE *input = stdin;       // default to interactive mode
    int last_status = 0;       // last command exit status
    char *line = NULL;

    // Open script file if provided
    if (argc == 2) {
        input = fopen(argv[1], "r");
        if (!input) {
            perror("Error opening script file");
            exit(1);
        }
    }

    while ((line = read_command_line(input)) != NULL) {
        // Skips empty lines and comments
        if (line[0] == '#' || strlen(line) == 0) {
            free(line);
            continue;
        }

        command_t cmd;
        memset(&cmd, 0, sizeof(cmd));

        if (parse_command_line(line, &cmd) == 0) {
            if (!handle_builtin(&cmd, &last_status)) {
                last_status = execute_external(&cmd);
            }
        }
        free_command(&cmd);
        free(line);
    }

    if (feof(input)) {
    fprintf(stderr, "end of file read, exiting shell with exit code %d\n", last_status);
    }
    if (input != stdin) {
        fclose(input);
    }
    return last_status;
}
