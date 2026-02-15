#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <ctype.h>
#include <signal.h>
#include <errno.h>

// Ran this in my ternimal to test: 
// gcc -o fakegrep fakergrep.c 
// ./fakegrep -p pattern.txt test.txt
// ./fakegrep -c 5 -p pattern.txt test.txt
// ./fakegrep -c 16 Zidane test.txt
// ./fakegrep ABC test.txt

int we_got_a_sigbus_error = 0;

// Handles sigbus signal
void sigbus_handler(int sig) 
{
    (void)sig;
    we_got_a_sigbus_error = 1;
}

void print_context(const char *buf, int len) 
{
   
}

// Searches for pattern in data and prints the matches with its context
void search_pattern(const char *data, int data_len, const char *pattern, int pat_len, const char *filename, int context) 
{
    
}

// Loads pattern from file
void load_pattern_file(const char *path, char **buf_out, int *len_out) 
{
    
}

void process_file(const char *filename, const char *pattern, int pat_len, int context) 
{
    
}

int main(int argc, char *argv[]) 
{
    char *pattern = NULL;
    int pat_len = 0;
    int context = 0; 

    // argument parsing
    if (argc < 3) 
    {
        fprintf(stderr, "Need at least 3 arguments: ./fakegrep, pattern, filename, flags -c or -p\n");
        return 1;
    }

    // First argument is the pattern, rest are files
    pattern = argv[1];
    pat_len = strlen(pattern);
    for (int i = 2; i < argc; i++) 
    {
        process_file(argv[i], pattern, pat_len, context);
    }
    return 0;
}
