#include <stdio.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>
#include <stdbool.h>
#include <lore.h>

// Initializing Pet, Pet_Array struct, Dinh_Army and Pet_Lineup structs
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

//Method to add pet to be added to the pet_array
void add_Pet(struct Pet_Array *ps, struct Pet *p)
{
	ps->pets[ps->numPets] = *p; 
	ps->numPets ++; 
}

void add_Pig_to_Dinh(struct Dinh_Army *da, struct Pet *p)
{
	da->Pig_Army[da->numPets] = *p; 
	da->numPets ++; 
}

void print_Battle (struct Pet_Array *pa, struct Pet_Lineup *pl, int boss_loc)
{
	char next; 
	for (int i = 0; i < 3; i++)
	{
		for (int k = 0; k < 3; k++)
		{
			if (pl->squad[k].health == 0)
			{
				pl->squad[k].sprite = "💀"; 
			}
		}	
		printf("%s\t\t", pl->squad[i].sprite); //Prints the sprites of the selected pets
	}
	
	printf("|%s\t\t\t\t\t", pa->pets[boss_loc].sprite); //PIKACHU boss sprite
	printf("\n");

	for (int i = 0; i < 3; i++)
	{
		printf("❤️ %d", pl->squad[i].health); //Displays health of the pet in user's army
		printf(" 🗡️%d", pl->squad[i].strength); //Displays strength of the pet in user's army
		printf("\t");
	}

	printf("❤ %d", pa->pets[boss_loc].health); //Displays Pikachu's health
	printf(" 🗡️%d\n",pa->pets[boss_loc].strength); //Displays Pikachu's strength
	next = getchar();
}

void buff_Pets(struct Pet_Array *pa)
{
	for (int j = 0; j < pa->numPets - 5; j++)
	{
		pa->pets[j].health = pa->pets[j].health + 10; 
		pa->pets[j].strength = pa->pets[j].strength + 5; 
	}
}

//Simulates the battle against Pikachu
void Battle1 (struct Pet_Array *pa, struct Pet_Lineup *pl)
{
	int battle = 1; //like a boolean, when this is 1, the battle ensues, if it is 0, then the battle is over
	int turn = 1; //counts number of turns in the battle
	int fighter_pos = 2; // the pet at this index is the pet that is fighting
	char next; // user presses enter to see the next turn of the battle
	int boss_loc = 0;

	for (int j = 0; j < sizeof(pa->pets); j++) //Searches for Pikachu in boss
	{
		if (pa->pets[j].pet_name == "Pikachu")
		{
			boss_loc = j;
			j = 10000;  
		}
	}

	print_Battle(pa, pl, boss_loc);
	printf("\nCommence the battle!\n\n");

	while (battle != 0)
	{
		while (pl->squad[fighter_pos].health <= 0) //Pet Defeat condition
		{
			fighter_pos = fighter_pos - 1; // The next pet to the left of the dead pet is the next fighter

			if (fighter_pos == -1) //If all pets are dead, you lose the battle
			{
				printf("\nYOU LOSE!\n");
				print_Battle(pa, pl, boss_loc);
				battle = 0;
				exit(0); //exits the program
			}
		}

		pa->pets[boss_loc].health = pa->pets[boss_loc].health - pl->squad[fighter_pos].strength; //Pet goes first and deals damage to opponent
		//Displays how much damage the pet did to the enemy
		//The print statments are split into two lines for visual appeal when reviewing code
		printf("\n%s has dealt ", pl->squad[fighter_pos].pet_name);
		printf("%d damage to %s\n", pl->squad[fighter_pos].strength, pa->pets[boss_loc].pet_name);
		
		if (pa->pets[boss_loc].health <= 0) //Win condition
		{
			pa->pets[boss_loc].sprite = "☠️ "; //Dead enemy
			pa->pets[boss_loc].health = 0; 
			pa->pets[boss_loc].strength = 0;
			printf("\nYOU WIN!\n"); 
			battle = 0; //Ends the battle
		}

		else
		{
			pl->squad[fighter_pos].health = pl->squad[fighter_pos].health - pa->pets[boss_loc].strength; //Enemy deals damage to pet
			//Displays how much damage the pet did to the enemy
                	//The print statments are split into two lines for visual appeal when reviewing code
                	printf("%s has dealt ", pa->pets[boss_loc].pet_name);
                	printf("%d damage to %s\n", pa->pets[boss_loc].strength, pl->squad[fighter_pos].pet_name);
		}
		
		if (pl->squad[fighter_pos].health <= 0) //Pet Defeat condition
		{
			pl->squad[fighter_pos].sprite = "💀"; //Dead pet
			pl->squad[fighter_pos].health = 0;
			pl->squad[fighter_pos].strength = 0;
			fighter_pos = fighter_pos - 1; // The next pet to the left of the dead pet is the next fighter

			if (fighter_pos == -1) //If all pets are dead, you lose the battle
			{
				printf("\nYOU LOSE!\n");
				print_Battle(pa, pl, boss_loc);
				battle = 0;
				exit(0); //exits the program
			}
		}

		turn ++; //Keeps track of how many turns occured in the battle
		printf("\n");
		print_Battle(pa, pl, boss_loc);
	}	
}

void Battle2(struct Pet_Array *pa, struct Pet_Lineup *pl, struct Dinh_Army *da)
{
	int battle = 1; //like a boolean, when this is 1, the battle ensues, if it is 0, then the battle is over
	int turn = 1; //counts number of turns in the battle
	int fighter_pos = 2; // the pet at this index is the pet that is fighting
	int enemy_pos = 0; //the pig at this index is the pig that is fighting
	char next; // user presses enter to see the next turn of the battle
	
	for (int i = 0; i < 3; i++)
	{
		printf("%s\t\t", pl->squad[i].sprite); //Prints the sprites of the selected pets
	}
	
	printf("|");
	
	for (int i = 0; i < 5; i++)
	{
		printf("%s\t",da->Pig_Army[i].sprite); // "🐖"
	}
		
	printf("\n");
		
	for (int i = 0; i < 3; i++)
	{
		printf("❤️ %d", pl->squad[i].health); //Displays health of the pet in user's army
		printf(" 🗡️%d", pl->squad[i].strength); //Displays strength of the pet in user's army
		printf("\t");
	}

	for (int i = 0; i < 5; i++)
	{
		printf("❤ %d", da->Pig_Army[i].health); //Displays Pig's health
		printf(" 🗡️%d",da->Pig_Army[i].strength); //Displays Pig's strength
		printf("\t");
	}
	
	printf("\n\nCommence the battle!\n"); 
	next = getchar();

	while (battle != 0)
	{
		while (pl->squad[fighter_pos].health <= 0) //Pet Defeat condition
		{
			fighter_pos = fighter_pos - 1; // The next pet to the left of the dead pet is the next fighter

			if (fighter_pos == -1) //If all pets are dead, you lose the battle
			{
				printf("YOU LOSE!\n");

				for (int i = 0; i < 3; i++)
				{
					printf("%s\t\t", pl->squad[i].sprite); //Prints the sprites of the selected pets
				}
		
				printf("|");
	
				for (int i = 0; i < 5; i++)
				{
					printf("%s\t", da->Pig_Army[i].sprite); //pig sprite
				}
		
				printf("\n");

				for (int i = 0; i < 3; i++)
				{
					printf("❤️ %d", pl->squad[i].health); //Displays health of the pet in user's army
					printf(" 🗡️%d", pl->squad[i].strength); //Displays strength of the pet in user's army
					printf("\t");
				}

				for (int i = 0; i < 5; i++)
				{
					printf("❤ %d", da->Pig_Army[i].health); //Displays Pig's health
					printf(" 🗡️%d",da->Pig_Army[i].strength); //Displays Pig's strength
					printf("\t");
				}
				
				printf("\n");
				battle = 0;
				exit(0);
			}
		}

		da->Pig_Army[enemy_pos].health = da->Pig_Army[enemy_pos].health - pl->squad[fighter_pos].strength; //Pet attacks first
		//Displays how much damage the pet did to the enemy
		//The print statments are split into two lines for visual appeal when reviewing code
		printf("\n%s has dealt ", pl->squad[fighter_pos].pet_name);
		printf("%d damage to %s\n", pl->squad[fighter_pos].strength, da->Pig_Army[enemy_pos].pet_name); // "Pig");
		
		if (da->Pig_Army[enemy_pos].health <= 0) //Pig Defeat condition
		{
			da->Pig_Army[enemy_pos].sprite = "☠️"; //Dead pig
			da->Pig_Army[enemy_pos].health = 0;
			da->Pig_Army[enemy_pos].strength = 0;
			enemy_pos = enemy_pos + 1; // The next pig on the right of the dead pet is the next fighter
		}

		if (enemy_pos == 5) //If all pigs are dead, you win the battle
		{
			printf("\nYOU WIN!\n\n");
			battle = 0;
		}

		else 
		{
			pl->squad[fighter_pos].health = pl->squad[fighter_pos].health - da->Pig_Army[enemy_pos].strength; //Enemy deals damage to pet
			//Displays how much damage the pet did to the enemy
	        	//The print statments are split into two lines for visual appeal when reviewing code
       	 		printf("%s has dealt ", da->Pig_Army[enemy_pos].pet_name);
        		printf("%d damage to %s\n\n", da->Pig_Army[enemy_pos].strength, pl->squad[fighter_pos].pet_name);
		}
		
		if (pl->squad[fighter_pos].health <= 0) //Pet Defeat condition
		{
			pl->squad[fighter_pos].sprite = "💀"; //Dead pet
			pl->squad[fighter_pos].health = 0;
			pl->squad[fighter_pos].strength = 0;
			fighter_pos = fighter_pos - 1; // The next pet to the left of the dead pet is the next fighter

		if (fighter_pos == -1) //If all pets are dead, you lose the battle
			{
				printf("YOU LOSE!\n");

				for (int i = 0; i < 3; i++)
				{
					printf("%s\t\t", pl->squad[i].sprite); //Prints the sprites of the selected pets
				}
		
				printf("|");
	
				for (int i = 0; i < 5; i++)
				{
					printf("%s\t", da->Pig_Army[i].sprite); //pig sprite
				}
		
				printf("\n");

				for (int i = 0; i < 3; i++)
				{
					printf("❤️ %d", pl->squad[i].health); //Displays health of the pet in user's army
					printf(" 🗡️%d", pl->squad[i].strength); //Displays strength of the pet in user's army
					printf("\t");
				}

				for (int i = 0; i < 5; i++)
				{
					printf("❤ %d", da->Pig_Army[i].health); //Displays Pig's health
					printf(" 🗡️%d",da->Pig_Army[i].strength); //Displays Pig's strength
					printf("\t");
				}	

				printf("\n");
				battle = 0;
				exit(0);
			}
		} 
		
		turn ++; //Keeps track of how many turns occured in the battle
		
		for (int i = 0; i < 3; i++)
		{
			printf("%s\t\t", pl->squad[i].sprite); //Prints the sprites of the selected pets
		}
		
		printf("|");
	
		for (int i = 0; i < 5; i++)
		{
			printf("%s\t", da->Pig_Army[i].sprite); //pig sprite
		}
		
		printf("\n");

		for (int i = 0; i < 3; i++)
		{
			printf("❤️ %d", pl->squad[i].health); //Displays health of the pet in user's army
			printf(" 🗡️%d", pl->squad[i].strength); //Displays strength of the pet in user's army
			printf("\t");
		}

		for (int i = 0; i < 5; i++)
		{
			printf("❤ %d", da->Pig_Army[i].health); //Displays Pig's health
			printf(" 🗡️%d",da->Pig_Army[i].strength); //Displays Pig's strength
			printf("\t");
		}
		
		printf("\n");
		next = getchar(); //User presses enter to go to the next turn of the battle
	}
}

void Battle3 (struct Pet_Array *pa, struct Pet_Lineup *pl)
{
	int battle = 1; //like a boolean, when this is 1, the battle ensues, if it is 0, then the battle is over
	int turn = 1; //counts number of turns in the battle
	int fighter_pos = 2; // the pet at this index is the pet that is fighting
	char next; // user presses enter to see the next turn of the battle
	int boss_loc = 0;

	for (int j = 0; j < sizeof(pa->pets); j++)
	{
		if (pa->pets[j].pet_name == "Ohm Aggy-Poo") //Searches for Boss Ohm Aggy-Poo
		{
			boss_loc = j;
			j = 10000;  
		}
	}

	print_Battle(pa, pl, boss_loc); 
	printf("\nCommence the battle!\n\n");

	while (battle != 0)
	{
		while (pl->squad[fighter_pos].health <= 0) //Pet Defeat condition
		{
			fighter_pos = fighter_pos - 1; // The next pet to the left of the dead pet is the next fighter

			if (fighter_pos == -1) //If all pets are dead, you lose the battle
			{
				printf("\nYOU LOSE!\n");
				print_Battle(pa, pl, boss_loc);
				battle = 0;
				exit(0); //exits the program
			}
		}

		pa->pets[boss_loc].health = pa->pets[boss_loc].health - pl->squad[fighter_pos].strength; //Pet goes first and deals damage to opponent
		//Displays how much damage the pet did to the enemy
		//The print statments are split into two lines for visual appeal when reviewing code
		printf("\n%s has dealt ", pl->squad[fighter_pos].pet_name);
		printf("%d damage to %s\n", pl->squad[fighter_pos].strength, pa->pets[boss_loc].pet_name);
		
		if (pa->pets[boss_loc].health <= 0) //Win condition
		{
			pa->pets[boss_loc].sprite = "☠️ "; //Dead enemy
			pa->pets[boss_loc].health = 0; 
			pa->pets[boss_loc].strength = 0;
			printf("\nYOU WIN!\n"); 
			battle = 0; //Ends the battle
		}

		else if (turn % 4 == 0)
		{
			pl->squad[fighter_pos].health = pl->squad[fighter_pos].health - pl->squad[fighter_pos].strength;
			printf("%s\n", "Ohm Aggy-Poo used 'What you mean is'!"); 
			printf("This attack deals%ddamage to%s\n", pl->squad[fighter_pos].strength, pl->squad[fighter_pos].pet_name);	
		} 

		else
		{
			pl->squad[fighter_pos].health = pl->squad[fighter_pos].health - pa->pets[boss_loc].strength; //Enemy deals damage to pet
			//Displays how much damage the pet did to the enemy
                	//The print statments are split into two lines for visual appeal when reviewing code
                	printf("%s has dealt ", pa->pets[boss_loc].pet_name);
                	printf("%d damage to %s\n", pa->pets[boss_loc].strength, pl->squad[fighter_pos].pet_name);
		}
		
		if (pl->squad[fighter_pos].health <= 0) //Pet Defeat condition
		{
			pl->squad[fighter_pos].sprite = "💀"; //Dead pet
			pl->squad[fighter_pos].health = 0;
			pl->squad[fighter_pos].strength = 0;
			fighter_pos = fighter_pos - 1; // The next pet to the left of the dead pet is the next fighter

			if (fighter_pos == -1) //If all pets are dead, you lose the battle
			{
				printf("\nYOU LOSE!\n");
				print_Battle(pa, pl, boss_loc);
				battle = 0;
				exit(0);
			}
		}

		turn ++; //Keeps track of how many turns occured in the battle
		printf("\n");
		print_Battle(pa, pl, boss_loc); 
	}	

}

void Battle4 (struct Pet_Array *pa, struct Pet_Lineup *pl)
{
	int battle = 1; //like a boolean, when this is 1, the battle ensues, if it is 0, then the battle is over
	int turn = 1; //counts number of turns in the battle
	int fighter_pos = 2; // the pet at this index is the pet that is fighting
	char next; // user presses enter to see the next turn of the battle
	int boss_loc = 0;

	for (int j = 0; j < sizeof(pa->pets); j++)
	{
		if (pa->pets[j].pet_name == "Robin SaRIZZky")
		{
			boss_loc = j;
			j = 10000;  
		}
	}

	print_Battle(pa, pl, boss_loc); 
	printf("\nCommence the battle!\n\n");

	while (battle != 0)
	{
		while (pl->squad[fighter_pos].health <= 0) //Pet Defeat condition
		{
			fighter_pos = fighter_pos - 1; // The next pet to the left of the dead pet is the next fighter

			if (fighter_pos == -1) //If all pets are dead, you lose the battle
			{
				printf("\nYOU LOSE!\n");
				print_Battle(pa, pl, boss_loc);
				battle = 0;
				exit(0); //exits the program
			}
		}

		pa->pets[boss_loc].health = pa->pets[boss_loc].health - pl->squad[fighter_pos].strength; //Pet goes first and deals damage to opponent
		//Displays how much damage the pet did to the enemy
		//The print statments are split into two lines for visual appeal when reviewing code
		printf("\n%s has dealt ", pl->squad[fighter_pos].pet_name);
		printf("%d damage to %s\n", pl->squad[fighter_pos].strength, pa->pets[boss_loc].pet_name);
		
		if (pa->pets[boss_loc].health <= 0) //Win condition
		{
			pa->pets[boss_loc].sprite = "☠️ "; //Dead enemy
			pa->pets[boss_loc].health = 0; 
			pa->pets[boss_loc].strength = 0;
			printf("\nYOU WIN!\n"); 
			battle = 0; //Ends the battle
		}

		else if (turn % 4 == 0)
		{
			pl->squad[fighter_pos].health = pl->squad[fighter_pos].health - 5;
			pa->pets[boss_loc].health = pa->pets[boss_loc].health + 3; 
			printf("%s\n", "Robin SaRIZZky used RIZZ!"); 
			printf("%s", "This attack deals 5 damage to ");
            		printf("%s%s\n", pl->squad[fighter_pos].pet_name, " and heals Robin SaRIZZky 3 health!");	
		} 

		else
		{
			pl->squad[fighter_pos].health = pl->squad[fighter_pos].health - pa->pets[boss_loc].strength; //Enemy deals damage to pet
			//Displays how much damage the pet did to the enemy
                	//The print statments are split into two lines for visual appeal when reviewing code
                	printf("%s has dealt ", pa->pets[boss_loc].pet_name);
                	printf("%d damage to %s\n", pa->pets[boss_loc].strength, pl->squad[fighter_pos].pet_name);
		}
		
		if (pl->squad[fighter_pos].health <= 0) //Pet Defeat condition
		{
			pl->squad[fighter_pos].sprite = "💀"; //Dead pet
			pl->squad[fighter_pos].health = 0;
			pl->squad[fighter_pos].strength = 0;
			fighter_pos = fighter_pos - 1; // The next pet to the left of the dead pet is the next fighter

			if (fighter_pos == -1) //If all pets are dead, you lose the battle
			{
				printf("\nYOU LOSE!\n");
				print_Battle(pa, pl, boss_loc);
				battle = 0;
				exit(0);
			}
		}

		turn ++; //Keeps track of how many turns occured in the battle
		printf("\n");
		print_Battle(pa, pl, boss_loc); 
	}	
}

void condescend()
{ 
	int pickInsult = 0; 
	pickInsult = rand() % 5; //Picks random number between 0 and 4

	if (pickInsult == 0)
	{
		printf("\e[31mYour generation has this bad habit of saying 'Good morning' when it is the afternoon.\e[m\n");
	}

	else if(pickInsult == 1)
	{
		printf("\e[31mYour funadamentals are lacking.\e[m\n");
	}

	else if(pickInsult == 2)
	{
		printf("\e[31mStop writing this nonsense on your work.\e[m\n");
	}

	else if (pickInsult == 3)
	{
		printf("\e[31mYour K-12 education has failed you.\e[m\n");
	}

	else 
	{
		printf("\e[31mYou clearly do not understand this concept.\e[m\n");
	}
}

void Battle5 (struct Pet_Array *pa, struct Pet_Lineup *pl)
{
	int battle = 1; //like a boolean, when this is 1, the battle ensues, if it is 0, then the battle is over
	int turn = 1; //counts number of turns in the battle
	int fighter_pos = 2; // the pet at this index is the pet that is fighting
	char next; // user presses enter to see the next turn of the battle
	int boss_loc = 0;
	
	for (int j = 0; j < sizeof(pa->pets); j++)
	{
		if (pa->pets[j].pet_name == "Finchev")
		{
			boss_loc = j;
			j = 10000;  
		}
	}
	
	print_Battle(pa, pl, boss_loc); 
	printf("\nCommence the battle!\n\n");
	next = getchar();
	
	while (battle != 0)
	{
		while (pl->squad[fighter_pos].health <= 0) //Pet Defeat condition
		{
			fighter_pos = fighter_pos - 1; // The next pet to the left of the dead pet is the next fighter

			if (fighter_pos == -1) //If all pets are dead, you lose the battle
			{
				printf("\nYOU LOSE!\n");
				print_Battle(pa, pl, boss_loc);
				battle = 0;
				exit(0); //exits the program
			}
		}

		pa->pets[boss_loc].health = pa->pets[boss_loc].health - pl->squad[fighter_pos].strength; //Pet goes first and deals damage to opponent
		//Displays how much damage the pet did to the enemy
		//The print statments are split into two lines for visual appeal when reviewing code
		printf("\n%s has dealt ", pl->squad[fighter_pos].pet_name);
		printf("%d damage to %s\n", pl->squad[fighter_pos].strength, pa->pets[boss_loc].pet_name);
		
		if (pa->pets[boss_loc].health <= 0) //Win condition
		{
			pa->pets[boss_loc].sprite = "☠️ "; //Dead enemy
			pa->pets[boss_loc].health = 0; 
			pa->pets[boss_loc].strength = 0;
			printf("\nYOU WIN!\n"); 
			battle = 0; //Ends the battle
		}

		else if (turn % 2 == 0)
		{
			pl->squad[fighter_pos].health = pl->squad[fighter_pos].health - (10 + pa->pets[boss_loc].strength);
			pa->pets[boss_loc].health = pa->pets[boss_loc].health + 2; 
			printf("%s\n", "Finchev used Condescend!"); 
			condescend(); 
			printf("%s", "This attack deals an additional 10 damage to ");
            		printf("%s%s\n", pl->squad[fighter_pos].pet_name, " and heals Finchev 2 health!");
		} 

		else
		{
			pl->squad[fighter_pos].health = pl->squad[fighter_pos].health - pa->pets[boss_loc].strength; //Enemy deals damage to pet
			//Displays how much damage the pet did to the enemy
                	//The print statments are split into two lines for visual appeal when reviewing code
                	printf("%s has dealt ", pa->pets[boss_loc].pet_name);
                	printf("%d damage to %s\n", pa->pets[boss_loc].strength, pl->squad[fighter_pos].pet_name);
		}
		
		if (pl->squad[fighter_pos].health <= 0) //Pet Defeat condition
		{
			pl->squad[fighter_pos].sprite = "💀"; //Dead pet
			pl->squad[fighter_pos].health = 0;
			pl->squad[fighter_pos].strength = 0;
			fighter_pos = fighter_pos - 1; // The next pet to the left of the dead pet is the next fighter

			if (fighter_pos == -1) //If all pets are dead, you lose the battle
			{
				printf("\nYOU LOSE!\n");
				battle = 0;
			}
		}

		turn ++; //Keeps track of how many turns occured in the battle
		printf("\n");
		print_Battle(pa, pl, boss_loc); 
	}	
}

void Rematch (struct Pet_Array *pa, struct Pet_Lineup *pl)
{
	int battle = 1; //like a boolean, when this is 1, the battle ensues, if it is 0, then the battle is over
	int turn = 1; //counts number of turns in the battle
	int fighter_pos = 2; // the pet at this index is the pet that is fighting
	char next; // user presses enter to see the next turn of the battle
	int boss_loc = 0;

	for (int j = 0; j < sizeof(pa->pets); j++)
	{
		if (pa->pets[j].pet_name == "Finchev")
		{
			boss_loc = j;
			j = 10000;  
		}
	}
	
	pa->pets[boss_loc].health = 50; 
	print_Battle(pa, pl, boss_loc); 
	printf("\nCommence the battle!\n");
	next = getchar();
	
	while (battle != 0)
	{
		while (pl->squad[fighter_pos].health <= 0) //Pet Defeat condition
		{
			fighter_pos = fighter_pos - 1; // The next pet to the left of the dead pet is the next fighter

			if (fighter_pos == -1) //If all pets are dead, you lose the battle
			{
				printf("\nYOU LOSE!\n");
				print_Battle(pa, pl, boss_loc);
				battle = 0;
				exit(0); //exits the program	
			}
		}

		pa->pets[boss_loc].health = pa->pets[boss_loc].health - pl->squad[fighter_pos].strength; //Pet goes first and deals damage to opponent
		//Displays how much damage the pet did to the enemy
		//The print statments are split into two lines for visual appeal when reviewing code
		printf("\n%s has dealt ", pl->squad[fighter_pos].pet_name);
		printf("%d damage to %s\n", pl->squad[fighter_pos].strength, pa->pets[boss_loc].pet_name);
		
		if (pa->pets[boss_loc].health <= 0) //Win condition
		{
			pa->pets[boss_loc].sprite = "☠️ "; //Dead enemy
			pa->pets[boss_loc].health = 0; 
			pa->pets[boss_loc].strength = 0;
			printf("\nYOU WIN!\n"); 
			battle = 0; //Ends the battle 
		}

		else if (turn % 2 == 0)
		{
			pl->squad[fighter_pos].health = pl->squad[fighter_pos].health - pa->pets[boss_loc].strength;
			pa->pets[boss_loc].health = pa->pets[boss_loc].health + 2; 
			printf("%s\n", "Finchev used Condescend!"); 
			condescend(); 
			printf("%s", "This attack deals an additional 10 damage to ");
            		printf("%s%s\n", pl->squad[fighter_pos].pet_name, " and heals Finchev 2 health!");
			printf("%s\n", "But with MENTAL FORTITUDE, Condescend deals 0 damage!");
		   	printf("%s%d%s\n", "This attack dealt ", pa->pets[boss_loc].strength, " damage");
		} 

		else
		{
			pl->squad[fighter_pos].health = pl->squad[fighter_pos].health - pa->pets[boss_loc].strength; //Enemy deals damage to pet
			//Displays how much damage the pet did to the enemy
                	//The print statments are split into two lines for visual appeal when reviewing code
                	printf("%s has dealt ", pa->pets[boss_loc].pet_name);
                	printf("%d damage to %s\n", pa->pets[boss_loc].strength, pl->squad[fighter_pos].pet_name);
		}
		
		if (pl->squad[fighter_pos].health <= 0) //Pet Defeat condition
		{
			pl->squad[fighter_pos].sprite = "💀"; //Dead pet
			pl->squad[fighter_pos].health = 0;
			pl->squad[fighter_pos].strength = 0;
			fighter_pos = fighter_pos - 1; // The next pet to the left of the dead pet is the next fighter

			if (fighter_pos == -1) //If all pets are dead, you lose the battle
			{
				printf("\nYOU LOSE!\n");
				battle = 0;
				exit(0);
			}
		}

		turn ++; //Keeps track of how many turns occured in the battle
		printf("\n");
		print_Battle(pa, pl, boss_loc); 
	}	
}

void print_Selection (struct Pet_Array *pa, int a, int b, int c)
{
	printf("%s\t%s\t%s\n",pa->pets[a].sprite, pa->pets[b].sprite, pa->pets[c].sprite); 	
	printf("🪙%d\t🪙%d\t🪙%d\n",pa->pets[a].cost, pa->pets[b].cost, pa->pets[c].cost);
	printf("❤️%d\t❤️%d\t❤️%d\n",pa->pets[a].health, pa->pets[b].health, pa->pets[c].health);
	printf("🗡️%d\t🗡️%d\t🗡️%d\n",pa->pets[a].strength, pa->pets[b].strength, pa->pets[c].strength);
}

void prompt (int total_coins)
{
	printf("Select a pet! Press 1 for the first pet, 2 for the second, and 3 for the third!\n");
	printf("Or pay a coin by pressing 4 for a reroll!\n\n");
	printf("Total Coins: 🪙%d\n\n", total_coins);
}

void Choose_Pet(struct Pet_Array *pa, struct Pet_Lineup *pl)
{
	bool Too_poor = false; 
	int total_coins = 20; 
	pl->numPets = 0; //Start at 0, works for future battles
	int r1 = 1000;
	int r2 = 1000;
	int r3 = 1000;
	char input = '0';	
	srand(time(NULL)); //Used for the random generator

	for (int i = 0; i < 3; i++)
	{
		if (total_coins <= 0)
		{
			break;
		}
		
		prompt(total_coins);
		r1 = rand()%(pa->numPets - 5);
		r2 = rand()%(pa->numPets - 5);
		r3 = rand()%(pa->numPets - 5);

		while (r1 == r2 || r2 == r3)
		{
			r2 = rand()%(pa->numPets - 5);
		}

		while (r3 == r1 || r3 == r2)
		{
			r3 = rand()%(pa ->numPets - 5);
		}
	
		print_Selection(pa, r1, r2, r3); 
		scanf("%c", &input); //Get user input
		printf("\n");
		
		while (input != '1' && input != '2' && input != '3' && input != '4')
		{
			scanf("%c", &input); //Get user input
		}
	
		while (input == '1' && (total_coins < pa->pets[r1].cost))
		{
			printf("Not enough coins!\n");
			prompt(total_coins);
			print_Selection(pa, r1, r2, r3);
			scanf("%c", &input); //Get user input
			printf("\n");
		}

		while (input == '2' && (total_coins < pa->pets[r2].cost))
		{
			printf("Not enough coins!\n");
			prompt(total_coins);
			print_Selection(pa, r1, r2, r3);
			scanf("%c", &input); //Get user input
			printf("\n");
		}

		while (input == '3' && (total_coins < pa->pets[r3].cost))
		{
			printf("Not enough coins!\n");
			prompt(total_coins);
			print_Selection(pa, r1, r2, r3);
			scanf("%c", &input); //Get user input
			printf("\n"); 
		}

		if (input == '1')
		{	
			// Load all selected pet's info into the array of pets that will be used to battle
			pl->squad[pl->numPets] = pa->pets[r1];
			total_coins = total_coins - pa->pets[r1].cost; 
			pl->numPets ++;
		}

		else if (input == '2')
		{
			pl->squad[pl->numPets] = pa->pets[r2];
			total_coins = total_coins - pa->pets[r2].cost; 
			pl->numPets ++;
		}

		else if (input == '3')
		{
			pl->squad[pl->numPets] = pa->pets[r3];
			total_coins = total_coins - pa->pets[r3].cost; 
			pl->numPets ++;
		}

		while (input == '4' && total_coins > 0) //Reroll 
		{
			total_coins = total_coins - 1; 
			printf("\nRerolling!\n");
			if (total_coins <= 0)
			{
				Too_poor = true;
				break; 
			}

			prompt(total_coins);
			r1 = rand()%(pa->numPets - 5); //Picks a random number between 0 and 13
			r2 = rand()%(pa->numPets - 5);
			r3 = rand()%(pa->numPets - 5);

			while (r1 == r2 || r2 == r3)
			{
				r2 = rand()%(pa->numPets - 5);
			}

			while (r3 == r1 || r3 == r2)
			{
				r3 = rand()%(pa->numPets - 5);
			}

			print_Selection(pa, r1, r2, r3);
			scanf("%s", &input); //Get user input
			printf("\n");

			while (input != '1' && input != '2' && input != '3' && input != '4')
			{
				scanf("%s", &input); //Get user input
			}

			while ((input == '1' && (total_coins < pa->pets[r1].cost)) || (input == '2' && (total_coins <pa->pets[r2].cost)) || (input == '3' && (total_coins < pa-> pets[r3].cost)))
			{
				printf("Not enough coins!\n");
				prompt(total_coins);
				print_Selection(pa, r1, r2, r3);
				scanf("%s", &input); //Get user input
				while (input != '1' && input != '2' && input != '3' && input != '4')
				{
					scanf("%s", &input); //Get user input
				}
				printf("\n");
			}

			if (input == '1')
			{	
				// Load all selected pet's info into the array of pets that will be used to battle
				pl->squad[pl->numPets] = pa->pets[r1];
				total_coins = total_coins - pa->pets[r1].cost; 
				pl->numPets ++;
			}

			else if (input == '2')
			{
				pl->squad[pl->numPets] = pa->pets[r2];
				total_coins = total_coins - pa->pets[r2].cost; 
				pl->numPets ++;
			}

			else if (input == '3')
			{
				pl->squad[pl->numPets] = pa->pets[r3];
				total_coins = total_coins - pa->pets[r3].cost; 
				pl->numPets ++;
			}
		}		
	}
	system("clear");
}

int main()
{
	//Instantiating pets and their stats along with their bosses
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
	struct Pet_Array select = {0};
	struct Pet_Lineup lineup = {0};
	struct Dinh_Army Piggies = {0};

	//Adds 5 pigs to Dinh's Army which will be used in Battle 2
	for (int i = 0; i < 5; i++)
	{
		add_Pig_to_Dinh(&Piggies, &Pig);
	}

	//Adding pets to array
	add_Pet(&select, &Rabbit);
	add_Pet(&select, &Mouse);
	add_Pet(&select, &Turtle);
	add_Pet(&select, &Snake);
	add_Pet(&select, &Fish);
	add_Pet(&select, &Dog);
	add_Pet(&select, &Cat);
	add_Pet(&select, &Horse);
	add_Pet(&select, &Dragon);
	add_Pet(&select, &Whale);
	add_Pet(&select, &Rooster);
	add_Pet(&select, &Elephant);
	add_Pet(&select, &Shark);
	add_Pet(&select, &Bison);
	add_Pet(&select, &Gorilla);
	add_Pet(&select, &Snail);
	add_Pet(&select, &Chick);
	add_Pet(&select, &Dolphin);
	add_Pet(&select, &Eagle);
	add_Pet(&select, &Pig);
	add_Pet(&select, &Pikachu);
	add_Pet(&select, &Robin_SaRIZZky);
	add_Pet(&select, &Ohm_Aggy_Poo);
	add_Pet(&select, &Finchev);  

	Lore1(); //Prints Lore
	Choose_Pet(&select, &lineup); //User chooses the pets to fight the battle
	Battle1(&select, &lineup); //User fights first boss Pikachu
	Lore2(); 
	Choose_Pet(&select, &lineup); 
	Battle2(&select, &lineup, &Piggies); //User fights second boss Dinh's Pig Army
	Lore3();
	Choose_Pet(&select, &lineup);
	Battle3(&select, &lineup); //User fights third boss Ohm
	Lore4();
	Choose_Pet(&select, &lineup);
	Battle4(&select, &lineup); // User fights fourth boss Robin
	Lore5();
	Choose_Pet(&select, &lineup);
	Battle5(&select, &lineup); //User fights fifth boss Finchev
	Lore6(); 
	buff_Pets(&select);
	Choose_Pet(&select, &lineup);
	Rematch(&select, &lineup);
	Lore7();
	return 0;	
}
