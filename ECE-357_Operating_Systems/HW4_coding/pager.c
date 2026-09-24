#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <signal.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>

int main() 
{
    FILE *tty;
    char buffer[1024];
    int line_count = 0;
    
    // Open the teletype
    tty = fopen("/dev/tty", "r");
    if (tty == NULL) 
    {
        perror("Failed to open /dev/tty");
        return 1;
    }

    while (1) 
    {  
        line_count = 0;
        
        while (line_count < 23) 
        {
            if (fgets(buffer, sizeof(buffer), stdin) != NULL) 
            {
                fputs(buffer, stdout);
                line_count++;
            } 
            else 
            {
  
                break;
            }
        }
        
        // Check if end of file
        if (feof(stdin)) 
        {
            break;  
        }
        
        printf("---Press RETURN for more---\n");
        
        if (fgets(buffer, sizeof(buffer), tty) == NULL) 
        {
            break;  
        }
        // Quit on q
        if (buffer[0] == 'q') 
        {
            break;
        }
        else if (buffer[0] == '\n') 
        {
            continue;  
        }
        
    }

    fclose(tty);
    return 0;
}