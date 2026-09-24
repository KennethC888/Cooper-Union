#include <Pet_Struct.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>
#include <stdbool.h>

//Instantiating pets and their stats along with their bosses
struct Pet p; 
struct Pet_Array ps; 
struct Pet_Lineup pl; 
struct Dinh_Army da;

void add_Pet(struct Pet_Array *ps, struct Pet p)
{
	ps->pets[ps->numPets].pet_name = p.pet_name; 
	ps->pets[ps->numPets].sprite = p.sprite;
	ps->pets[ps->numPets].special = p.special;
	ps->pets[ps->numPets].strength = p.strength;
	ps->pets[ps->numPets].health = p.health;
	ps->pets[ps->numPets].cost = p.cost;
	ps->numPets ++; 
}

void add_Pig_to_Dinh(struct Dinh_Army *da, struct Pet p)
{
	da->Pig_Army[da->numPets].pet_name = p.pet_name; 
	da->Pig_Army[da->numPets].sprite = p.sprite;
	da->Pig_Army[da->numPets].special = p.special;
	da->Pig_Army[da->numPets].strength = p.strength;
	da->Pig_Army[da->numPets].health = p.health;
	da->Pig_Army[da->numPets].cost = p.cost;
	da->numPets ++; 
}
	struct Pet Rabbit = {"Rabbit", "🐇", "Evasive Dodge", 2, 4, 3}; 
    struct Pet Mouse = {"Mouse", "🐁", "Squeak Squeak", 1, 5, 2}; 
	struct Pet Turtle = {"Turtle", "🐢","Shell Protection", 1, 7, 3};
	struct Pet Snake = {"Snake", "🐍", "Poison Fang", 2, 6, 3}; 
	struct Pet Fish = {"Fish", "🐟", "Flop", 1, 1, 1}; 
	struct Pet Dog = {"Dog", "🐕", "Bark", 4, 4, 4};
	struct Pet Cat = {"Cat", "🐈", "Scratch", 3, 4, 3};
	struct Pet Horse = {"Horse", "🐎", "Speedy Agility", 5, 5, 6};
	struct Pet Dragon = {"Dragon", "🐉", "Fire Breath", 8, 8, 8}; 
	struct Pet Whale = {"Whale", "🐋", "Wave Splash", 3, 12, 7};
	struct Pet Rooster = {"Rooster", "🐓", "COCK-A-DOODLE-DOO", 3, 5, 5};
	struct Pet Elephant = {"Elephant", "🐘", "Stomp", 2, 15, 7}; 
	struct Pet Shark = {"Shark", "🦈", "Bite", 7, 2, 5};
	struct Pet Bison = {"Bison", "🦬", "Wild Charge", 4, 5, 4};
	struct Pet Gorilla = {"Gorilla", "🦍", "Pound", 5, 6, 6}; 
	struct Pet Snail = {"Snail", "🐌", "", 1, 1, 1};
	struct Pet Chick = {"Chick", "🐤", "", 5, 2, 1};
	struct Pet Cow = {"Cow", "🐄", "Moo", 3, 9, 5};
	struct Pet Dolphin = {"Dolphin", "🐬", "Tail Whip", 5, 7, 6};
	struct Pet Eagle = {"Eagle", "🦅", "Gust", 5, 9, 7};
	struct Pet Pig = {"Pig", "🐖", "Oink", 3, 3, 0};
	struct Pet Pikachu = {"Pikachu", "🐭⚡️", "Thunderbolt", 2, 10, 0}; 
	struct Pet Robin_SaRIZZky = {"Robin SaRIZZky","🐦", "RIZZ", 6, 15, 0};
	struct Pet Ohm_Aggy_Poo = {"Ohm Aggy-Poo", "Ω💩", "What you mean is", 4, 20, 0};
	struct Pet Finchev = {"Finchev", "⋋(•࿉•)⋌", "Condescend", 5, 50, 0};
       	 	
	//Instantiating the Pet_Array and Pet_Lineup structs
	struct Pet_Array pa = {0};
	struct Pet_Lineup lineup = {0};
	struct Dinh_Army Piggies = {0};

	//Adds 5 pigs to Dinh's Army which will be used in Battle 2
	for (int i = 0; i < 5; i++)
	{
		add_Pig_to_Dinh(&Piggies, Pig);
	}

	//Adding pets to array
	add_Pet(&select, Rabbit);
	add_Pet(&select, Mouse);
	add_Pet(&select, Turtle);
	add_Pet(&select, Snake);
	add_Pet(&select, Fish);
	add_Pet(&select, Dog);
	add_Pet(&select, Cat);
	add_Pet(&select, Horse);
	add_Pet(&select, Dragon);
	add_Pet(&select, Whale);
	add_Pet(&select, Rooster);
	add_Pet(&select, Elephant);
	add_Pet(&select, Shark);
	add_Pet(&select, Bison);
	add_Pet(&select, Gorilla);
	add_Pet(&select, Snail);
	add_Pet(&select, Chick);
	add_Pet(&select, Dolphin);
	add_Pet(&select, Eagle);
	add_Pet(&select, Pig);
	add_Pet(&select, Pikachu);
	add_Pet(&select, Robin_SaRIZZky);
	add_Pet(&select, Ohm_Aggy_Poo);
	add_Pet(&select, Finchev);  