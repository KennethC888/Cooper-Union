#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_WORD_LENGTH 100
#define MAX_WORDS 1000

// Struct
struct Word_Count 
{
    char word[MAX_WORD_LENGTH];
    int count;
};

int compare(const void *a, const void *b) {
    return ((struct Word_Count *)b)->count - ((struct Word_Count *)a)->count;
}

void print_word_frequency(struct Word_Count *word_counts, int word_count) {

    qsort(word_counts, word_count, sizeof(struct Word_Count), compare);

   
    for (int i = 0; i < word_count; i++) {
        printf("%d: %s\n", word_counts[i].count, word_counts[i].word);
    }
}

int main() {
    //Getting input
    char text[MAX_WORDS][MAX_WORD_LENGTH];
    struct Word_Count word_counts[MAX_WORDS];
    int word_count = 0;

    char buffer[MAX_WORD_LENGTH];
    while (scanf("%s", buffer) != EOF && word_count < MAX_WORDS) 
    {
        int i;
        for (i = 0; i < word_count; i++) 
	{
            if (strcmp(word_counts[i].word, buffer) == 0) 
	    {
                word_counts[i].count++;
                break;
            }
        }

        if (i == word_count) 
	{
            strcpy(word_counts[word_count].word, buffer);
            word_counts[word_count].count = 1;
            word_count++;
        }
    }

    // Print final results
    print_word_frequency(word_counts, word_count);

    return 0;
}

