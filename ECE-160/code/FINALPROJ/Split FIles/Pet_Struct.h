#include <stdio.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>
#include <stdbool.h>

// Initializing Pet, Pet_Array struct, and Pet_Lineup structs
struct Pet 
{
	char* pet_name; 
	char* sprite;
	char* special;
	int strength;
	int health;
	int cost;
};

struct Pet_Array
{
	int numPets;
	struct Pet pets[30];
};

struct Pet_Lineup
{
	int numPets;
	struct Pet squad[3];
};

struct Dinh_Army
{
	int numPets;
	struct Pet Pig_Army[5];
};

extern struct Pet p; 
extern struct Pet_Array ps; 
extern struct Pet_Lineup pl; 
extern struct Dinh_Army da;

void add_Pet(struct Pet_Array *ps, struct Pet p);
void add_Pig_to_Dinh(struct Dinh_Army *da, struct Pet p);
