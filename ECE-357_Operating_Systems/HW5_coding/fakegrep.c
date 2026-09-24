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
// gcc -o fakegrep fakegrep.c 
// ./fakegrep -p pattern.txt test.txt
// ./fakegrep -c 5 -p pattern.txt test.txt
// ./fakegrep -c 16 Zidane test.txt
// ./fakegrep 80s test.txt
int we_got_a_sigbus_error = 0;

// Handles sigbus signal
void sigbus_handler(int sig) 
{
    (void)sig;
    we_got_a_sigbus_error = 1;
}

void print_context(const char *buf, int len) 
{
    for (int i = 0; i < len; i++) 
    {
        unsigned char byte = (unsigned char)buf[i];
        if (isprint(byte)) 
        {
            printf("%c ", byte);
        } 
        else 
        {
            printf("? ");
        }
    }
    printf("\n");
    for (int i = 0; i < len; i++) 
    {
        printf("%02X ", (unsigned char)buf[i]);
    }
    printf("\n");
}

// Searches for pattern in data and prints the matches with its context
void search_pattern(const char *data, int data_len, const char *pattern, int pattern_len, const char *filename, int context) 
{
    for (int i = 0; i <= data_len - pattern_len; i++) 
    {
        if (memcmp(&data[i], pattern, pattern_len) == 0) 
        {
            printf("%s:%d\n", filename, i);
            if (context > 0)
            {
                int start = i - context;
                if (start < 0) 
                {
                    start = 0;
                }

                int end = i + pattern_len + context;
                if (end > data_len) 
                {
                    end = data_len;
                }
                print_context(&data[start], end - start);
            }
        }
    }
}

// Loads pattern from file
void load_pattern_file(const char *path, char **buf_out, int *len_out) 
{
    FILE *fp = fopen(path, "rb");
    if (!fp) 
    {
        perror("fopen");
        exit(1);
    }

    fseek(fp, 0, SEEK_END);
    long fsize = ftell(fp);
    fseek(fp, 0, SEEK_SET);
    char *buffer = malloc(fsize);

    if (!buffer) 
    {
        perror("malloc");
        fclose(fp);
        exit(1);
    }

    fread(buffer, 1, fsize, fp);
    fclose(fp);
    *buf_out = buffer;
    *len_out = fsize;
}

void process_file(const char *filename, const char *pattern, int pattern_len, int context) 
{
    FILE *fp = fopen(filename, "rb");
    if (!fp) 
    {
        perror("fopen");
        return;
    }
    fseek(fp, 0, SEEK_END);
    long fsize = ftell(fp);
    fseek(fp, 0, SEEK_SET);
    char *data = malloc(fsize);

    if (!data) 
    {
        perror("malloc");
        fclose(fp);
        return;
    }

    fread(data, 1, fsize, fp);
    fclose(fp);
    search_pattern(data, fsize, pattern, pattern_len, filename, context);
    free(data);
}


int main(int argc, char *argv[]) 
{
    char *pattern = NULL;
    int pattern_len = 0;
    int context = 0;
    char *pattern_file = NULL;
    int saw_match = 0;
    int had_error = 0;

    if (argc < 2) 
    {
        printf("Format: ./fakegrep, (flags -c followed by a number, -p, or both -c and -p, pattern, filename(s)\n");
        return 255;
    }

    // Arg parsing
    int arg_index = 1;
    while (arg_index < argc && argv[arg_index][0] == '-') 
    {
        if (strcmp(argv[arg_index], "-c") == 0) 
        {
            if (arg_index + 1 >= argc) 
            {
                printf("Missing number of bits for -c\n");
                return 255;
            }

            context = atoi(argv[arg_index + 1]);
            arg_index = arg_index + 2;
        } 
        else if (strcmp(argv[arg_index], "-p") == 0) 
        {
            if (arg_index + 1 >= argc) 
            {
                printf("Missing value for -p\n");
                return 255;
            }
            pattern_file = argv[arg_index + 1];
            arg_index = arg_index + 2;
        } 
        else 
        {
            printf("Invalid option\n");
            return 255;
        }
    }

    // Load the pattern
    if (pattern_file != NULL) 
    {
        load_pattern_file(pattern_file, &pattern, &pattern_len);
        if (pattern == NULL)
         {
            printf("Failed to load pattern file\n");
            return 255;
        }
    } 
    else 
    {
        if (arg_index >= argc) 
        {
            printf("No pattern provided\n");
            return 255;
        }
        pattern = argv[arg_index];
        pattern_len = strlen(pattern);
        arg_index = arg_index + 1;
    }

    // Check if there are files to search
    if (arg_index >= argc) 
    {
        printf("No input files provided\n");
        if (pattern_file) free(pattern);
        return 255;
    }

    signal(SIGBUS, sigbus_handler);

    // Go through each file
    while (arg_index < argc)
    {
        char *filename = argv[arg_index];
        int fd = open(filename, O_RDONLY);
        if (fd < 0) 
        {
            printf("Can't open %s\n", filename);
            had_error = 1;
            arg_index++;
            continue;
        }

        struct stat st;
        if (fstat(fd, &st) < 0) 
        {
            printf("Can't stat %s\n", filename);
            had_error = 1;
            close(fd);
            arg_index++;
            continue;
        }

        size_t file_size = st.st_size;
        if (file_size == 0) 
        {
            close(fd);
            arg_index++;
            continue;
        }

        char *data = mmap(NULL, file_size, PROT_READ, MAP_PRIVATE, fd, 0);
        if (data == MAP_FAILED) 
        {
            printf("Can't mmap %s\n", filename);
            had_error = 1;
            close(fd);
            arg_index++;
            continue;
        }

        we_got_a_sigbus_error = 0;

        search_pattern(data, file_size, pattern, pattern_len, filename, context);

        if (we_got_a_sigbus_error) 
        {
            printf("SIGBUS received while processing file %s\n", filename);
            had_error = 1;
        } 
        else 
        {
            saw_match = 1;
        }

        munmap(data, file_size);
        close(fd);
        arg_index++;
    }

    if (pattern_file != NULL)
    {
        free(pattern);
    }

    if (had_error)
    {
        return 255;
    }

    if (saw_match) 
    {
        return 0;
    }

    return 1;
}
