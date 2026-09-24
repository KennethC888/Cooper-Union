#include <string.h>   // For strcmp, strerror, strlen
#include <unistd.h>   // For write, STDIN_FILENO, STDOUT_FILENO, STDERR_FILENO
#include <stdlib.h>   // For exit
#include <errno.h>    // For errno
#include "mylib.h"

#define EXIT_ERROR 255

// Function that prints an error message to stderr
void print_error(const char *prefix, int err_code) {
    const char *err_msg = strerror(err_code);
    write(STDERR_FILENO, prefix, strlen(prefix));
    write(STDERR_FILENO, ": ", 2);
    write(STDERR_FILENO, err_msg, strlen(err_msg));
    write(STDERR_FILENO, "\n", 1);
}

int main(int argc, char *argv[]) {
    struct MYSTREAM *input = NULL;
    struct MYSTREAM *output = NULL;
    char *infile = NULL;
    char *outfile = NULL;
    int c;

    // --- Argument Parsing ---
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-o") == 0) {
            if (++i < argc) {
                outfile = argv[i];
            } else {
                const char *msg = "Error: -o requires an output file\n";
                write(STDERR_FILENO, msg, strlen(msg));
                exit(EXIT_ERROR);
            }
        } else {
            if (infile == NULL) {
                infile = argv[i];
            } else {
                const char *msg = "Error: Too many input files specified\n";
                write(STDERR_FILENO, msg, strlen(msg));
                exit(EXIT_ERROR);
            }
        }
    }

    // Sets up the Stream
    if (infile == NULL) {
        input = myfdopen(STDIN_FILENO, "r");
    } else {
        input = myfopen(infile, "r");
    }
    if (input == NULL) {
        print_error("Error opening input", errno);
        exit(EXIT_ERROR);
    }

    if (outfile == NULL) {
        output = myfdopen(STDOUT_FILENO, "w");
    } else {
        output = myfopen(outfile, "w");
    }
    if (output == NULL) {
        print_error("Error opening output", errno);
        myfclose(input); // Clean up
        exit(EXIT_ERROR);
    }
    
    // --- Main Processing Loop ---
    while ((c = myfgetc(input)) != MY_EOF) {
        if (c == '\t') {
            myfputc(' ', output);
            myfputc(' ', output);
            myfputc(' ', output);
            myfputc(' ', output);
        } else {
            myfputc(c, output);
        }
    }

    // --- Cleanup ---
    if (myfclose(input) != 0) {
        print_error("Error closing input file", errno);
        myfclose(output); 
        exit(EXIT_ERROR);
    }
    if (myfclose(output) != 0) {
        print_error("Error closing output file", errno);
        exit(EXIT_ERROR);
    }

    return 0;
}