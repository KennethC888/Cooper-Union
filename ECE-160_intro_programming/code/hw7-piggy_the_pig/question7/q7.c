#include <stdio.h>

#define HASH_SIZE 1000 

// Node 
struct Node {
    int key;
    struct Node* next;
};


struct HashMap {
    struct Node* buckets[HASH_SIZE];
};


void initHashMap(struct HashMap* map) {
    for (int i = 0; i < HASH_SIZE; i++) 
    {
        map->buckets[i] = NULL;
    }
}

int hash(int key) {
    return key % HASH_SIZE;
}


void insert(struct HashMap* map, int key) 
{
    int index = hash(key);
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    newNode->key = key;
    newNode->next = map->buckets[index];
    map->buckets[index] = newNode;
}

    int contains(struct HashMap* map, int key) 
{
    int index = hash(key);
    struct Node* current = map->buckets[index];
    while (current != NULL) 
    {
        if (current->key == key) 
	{
            return 1;
        }
        current = current->next;
    }
    return 0; 
}


void intersection(int output[], int array1[], int lenArr1, int array2[], int lenArr2) {
    struct HashMap map;
    initHashMap(&map);
    
    for (int i = 0; i < lenArr1; i++) {
        insert(&map, array1[i]);
    }
    
   
    int count = 0;
    for (int i = 0; i < lenArr2; i++) {
        if (contains(&map, array2[i])) {
            output[count++] = array2[i];
        }
    }
}

int main() {

    int lenArr1, lenArr2;
    printf("Enter the number of points in array 1: ");
    scanf("%d", &lenArr1);
    
    int array1[lenArr1];
    printf("Enter the points in array 1: ");
    for (int i = 0; i < lenArr1; i++) 
    {
        scanf("%d", &array1[i]);
    }
    
    printf("Enter the number of points in array 2: ");
    scanf("%d", &lenArr2);
    
    int array2[lenArr2];
    printf("Enter the points in array 2: ");
    for (int i = 0; i < lenArr2; i++) 
    {
        scanf("%d", &array2[i]);
    }
    
    int output[HASH_SIZE] = {0};
    intersection(output, array1, lenArr1, array2, lenArr2);
    
    printf("Intersection: ");
    int printed = 0;
    for (int i = 0; i < HASH_SIZE; i++) 
    {
        if (output[i] != 0) 
	{
            if (printed > 0) 
	    {
                printf(" ");
            }
            printf("%d", output[i]);
            printed++;
        }
    }
    printf("\n");
    
    return 0;
}

