#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <signal.h>
#include <unistd.h>
#include <errno.h>
#include <sys/wait.h>
#include <time.h>

int main(int argc, char **argv)
{
    int input = 0;

    if (argc > 1) 
    {
        input = atoi(argv[1]);  
    }

    srand(time(NULL));
    int num_iterations = input; 
    int length = rand() % 8 + 3;

    if (input == 0)
    {
        while (input == 0) 
        {
        length = rand() % 8 + 3;

        for (int i = 0; i < length; i++) 
            {
                char letter = 'A' + (rand() % 26);
                putchar(letter);
            }

        putchar('\n');
        }
    
    }

    else 
    {
        for (int j = 0; j < num_iterations; j++) 
        {
            length = rand() % 8 + 3;

            for (int i = 0; i < length; i++) 
            {
                char letter = 'A' + (rand() % 26);
                putchar(letter);
            }

            putchar('\n');
        }
    }

    return 0; 
}