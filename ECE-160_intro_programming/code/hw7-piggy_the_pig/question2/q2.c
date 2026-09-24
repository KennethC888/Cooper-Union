#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define DEFAULT_LINES 10
#define MAX_LINE_LENGTH 1000


void tail(int n) 
{
    char *lines[n];
    char buffer[MAX_LINE_LENGTH];
    int line_count = 0;
    int pos = 0;
    char c;

    while ((c = getchar()) != EOF) 
    {
        if (c == '\n' || pos == MAX_LINE_LENGTH - 1) 
	{
            buffer[pos] = '\0'; 
            lines[line_count % n] = strdup(buffer);
            line_count++;
            pos = 0;
        } 
	else 
	{
            buffer[pos++] = c;
        }
    }

    
    int start = line_count > n ? line_count % n : 0;
    for (int i = start; i < start + n && i < line_count; i++) 
    {
        printf("%s\n", lines[i % n]);
        free(lines[i % n]);
    }
}

int main(int argc, char *argv[]) 
{
    int n = DEFAULT_LINES;
    if (argc == 2 && strncmp(argv[1], "-n", 2) == 0)
    {
	n = atoi(argv[1] + 2);
    }
    tail(n);

    return 0;
}

