#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <signal.h>
#include <unistd.h>
#include <errno.h>

#define MAX_WORDS 10000000
#define MAX_WORD_LENGTH 100000

char *dictionary[MAX_WORDS];
int word_count = 0;

int main(int argc, char **argv) 
{
    signal(SIGPIPE, SIG_IGN);
    
    if (argc != 2) 
    {
        fprintf(stderr, "Usage: %s <dictionary_file>\n", argv[0]);
        return 1;
    }
    
    // Load dictionary 
    FILE *file = fopen(argv[1], "r");
    if (!file) 
    {
        perror("Failed to open dictionary file");
        return 1;
    }
    
    char buffer[MAX_WORD_LENGTH];
    word_count = 0;
    
    while (fgets(buffer, sizeof(buffer), file) && word_count < MAX_WORDS) 
    {
        // Remove newline character
        buffer[strcspn(buffer, "\n")] = '\0';
        
        // Uppercase
        for (int i = 0; buffer[i]; i++) {
            buffer[i] = toupper(buffer[i]);
        }
        
        dictionary[word_count] = malloc(strlen(buffer) + 1);
        if (dictionary[word_count]) {
            strcpy(dictionary[word_count], buffer);
            word_count++;
        }
    }
    
    fclose(file);
    
    if (word_count <= 0) 
    {
        fprintf(stderr, "Failed to load dictionary from %s\n", argv[1]);
        return 1;
    }
    
    char line[MAX_WORD_LENGTH];
    while (fgets(line, sizeof(line), stdin)) 
    {
        // Remove newline character for dictionary check
        line[strcspn(line, "\n")] = '\0';
        
        char upper_word[MAX_WORD_LENGTH];
        strcpy(upper_word, line);
        for (int i = 0; upper_word[i]; i++) 
        {
            upper_word[i] = toupper(upper_word[i]);
        }
        
        // Is the word in the dictionary?
        int found = 0;
        for (int i = 0; i < word_count; i++) 
        {
            if (strcmp(upper_word, dictionary[i]) == 0) 
            {
                found = 1;
                break;
            }
        }
        
        if (found == 1) 
        {
            printf("%s\n", line);
            fflush(stdout);  
        }
    }
    
    for (int i = 0; i < word_count; i++) 
    {
        free(dictionary[i]);
    }
    
    return 0;
}