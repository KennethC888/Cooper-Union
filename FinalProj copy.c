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


//Method to add pet to be added to the pet_array
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

//Lore for the user to get context of the game
void Lore1()
{
	system("clear");
	char x;
	printf("NOTE: The content in this game is just a joke, no harm or insults are intended. Enjoy the game!\n");
	printf("Rules:\n");
	printf("1.Before each battle, you will select pets into a team of three pets to fight an enemy boss.\n"); 
	printf("2.Press a number (1,2,3) to select a pet for your team \n");
	printf("3.Press enter to continue the storyline and each turn in the battles.\n");
	x = getchar();
	system("clear");
	printf("Summer of 2023: It was a good day in the open land. You were enjoying a day with your pets at your farm.\n");	
	printf("The fresh air and cool breezes were a nice complement to the hard work you did on the farm.\n");
	printf("The trees would sway as if in a slow trance, keeping you calm and happy all day as you spent time with your pets.\n");
	x = getchar(); // Used as a way for the user to press enter to continue reading the lore without it all showing up at once
	printf("But the worst has yet to come: you did not experience a semester of Cooper Union yet.\n");
	printf("For the unlucky students who were enrolled into section C, they were about to face the worst few months of their lives.\n");
	x = getchar();
	printf("This game is dedicated to the survivors of section C, those poor minds and hearts broken by the 'Holy Trinity'...\n");
        printf("The Holy Trinity is composed of Ohm Aggy-Poo, Robin SaRIZZky, and Finchev.\n");
	x = getchar();
        printf("These people were known for their rigorous homework assignments and exams.\n");
	printf("Many have fallen victim to the Holy Trinity.\n"); 
	x = getchar(); 
	printf("And now, it is time to unite with your pets and defeat the Holy Trinity to avenge your friends!\n");
	printf("But first, let's do some practice by going up against us!");
	x = getchar();
	system("clear");
}

void Lore2()
{
	system("clear");
	char x; 
	printf("You defeated Pikachu. Good luck against the Dinh Army!");
	x = getchar();
	system("clear");
}

void Lore3()
{
	system("clear");
	char x; 
	printf("Now that your training is complete, it is time to fight against the holy trinity!\n");
	x = getchar();
	system("clear");
}

void Lore4() 
{
	system("clear");
	char x; 
	printf("Great job! One down, two to go!");
	x = getchar(); 
	system("clear");
}

void Lore5()
{
	system("clear");
	char x;
	printf("Amazing! Two down, one to go!");
	x = getchar(); 
	system("clear");
}

void Lore6(struct Pet_Array *pa)
{
	system("clear");
	char x; 
	printf("Upon defeat, you retreat to safety. As you think of a way to defeat Finchev, you hear a voice.\n");
	x = getchar();
	printf("\e[1mHello there.\e[m\n");
	x = getchar();
	printf("Shocked, you look around but do not see anyone who could have spoken to you.\n");
	x = getchar(); 
	printf("\e[1mYou can't see me, but I am a spirit, sent by the one and only,\e[m");
	x = getchar();
	printf("\e[33mHOLY HONG.\e\n[m");
	x = getchar(); 
	printf("Confused, you were about to ask who Holy Hong is but then voice of the spirit continued.\n");
	x = getchar();
	printf("\e[1mHoly Hong was a student who graduated from the institution you are familiar with, the Cooper Union.\e[m\n"); 
	printf("\e[1mHe has experience against arduous work and difficult professors and succeeded in Cooper Union.\e[m\n");
	printf("\e[1mSeeing as you are stuggling now, the Holy Hong will help you.\e[m\n");
	x = getchar(); 
	printf("\e[1mThe Holy Hong has bestowed upon you the ability, MENTAL FORTITUDE!\e[m\n");
	x = getchar(); 
	printf("\e[1mWith this ability, you should be immune to Finchev's insults and be able to defeat him.\e[m\n");
	printf("\e[1mOh, the Holy Hong has also strengthened all of your pets.\e[m\n");
	printf("\e[1mThat is all, don't forget to thank the Holy Hong though. Thank him for his generous CS.\e[m\n");
	x = getchar();
	printf("You mean his computer science?\n");
	x = getchar();
	printf("\e[1mNo, his Community Service as an adjunct for the Cooper Union. They pay him peanuts for his job.\e[m\n");
	x = getchar(); 
	printf("Then, a gentle breeze blew the leaves and the spirit seemed to disappear.\n");
	printf("You thank the Holy Hong for his help and begin to ready your rematch against Finchev.\n");
	x = getchar(); 
	system("clear");
}

void Lore7()
{
	system("clear");
	printf("Congratulations!\n");
	printf("You avenged your friends in section C.\n");
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

	for (int j = 0; j < sizeof(pa->pets); j++)
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
		printf("\n%s%s", pl->squad[fighter_pos].pet_name," has dealt ");
		printf("%d%s%s\n", pl->squad[fighter_pos].strength, " damage to ", pa->pets[boss_loc].pet_name);
		
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
                	printf("%s%s", pa->pets[boss_loc].pet_name," has dealt ");
                	printf("%d%s%s\n", pa->pets[boss_loc].strength, " damage to ", pl->squad[fighter_pos].pet_name);
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
		printf("\n%s%s", pl->squad[fighter_pos].pet_name," has dealt ");
		printf("%d%s%s\n", pl->squad[fighter_pos].strength, " damage to ",da->Pig_Army[enemy_pos].pet_name); // "Pig");
		
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
       	 		printf("%s%s", da->Pig_Army[enemy_pos].pet_name," has dealt ");
        		printf("%d%s%s\n\n", da->Pig_Army[enemy_pos].strength, " damage to ", pl->squad[fighter_pos].pet_name);
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
		if (pa->pets[j].pet_name == "Ohm Aggy-Poo")
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
		printf("\n%s%s", pl->squad[fighter_pos].pet_name," has dealt ");
		printf("%d%s%s\n", pl->squad[fighter_pos].strength, " damage to ", pa->pets[boss_loc].pet_name);
		
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
			printf("%s%d%s%s\n", "This attack deals ", pl->squad[fighter_pos].strength, " damage to ",pl->squad[fighter_pos].pet_name);	
		} 

		else
		{
			pl->squad[fighter_pos].health = pl->squad[fighter_pos].health - pa->pets[boss_loc].strength; //Enemy deals damage to pet
			//Displays how much damage the pet did to the enemy
                	//The print statments are split into two lines for visual appeal when reviewing code
                	printf("%s%s", pa->pets[boss_loc].pet_name," has dealt ");
                	printf("%d%s%s\n", pa->pets[boss_loc].strength, " damage to ", pl->squad[fighter_pos].pet_name);
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
		printf("\n%s%s", pl->squad[fighter_pos].pet_name," has dealt ");
		printf("%d%s%s\n", pl->squad[fighter_pos].strength, " damage to ", pa->pets[boss_loc].pet_name);
		
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
                	printf("%s%s", pa->pets[boss_loc].pet_name," has dealt ");
                	printf("%d%s%s\n", pa->pets[boss_loc].strength, " damage to ", pl->squad[fighter_pos].pet_name);
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
		printf("\n%s%s", pl->squad[fighter_pos].pet_name," has dealt ");
		printf("%d%s%s\n", pl->squad[fighter_pos].strength, " damage to ", pa->pets[boss_loc].pet_name);
		
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
                	printf("%s%s", pa->pets[boss_loc].pet_name," has dealt ");
                	printf("%d%s%s\n", pa->pets[boss_loc].strength, " damage to ", pl->squad[fighter_pos].pet_name);
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
		printf("\n%s%s", pl->squad[fighter_pos].pet_name," has dealt ");
		printf("%d%s%s\n", pl->squad[fighter_pos].strength, " damage to ", pa->pets[boss_loc].pet_name);
		
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
		} 

		else
		{
			pl->squad[fighter_pos].health = pl->squad[fighter_pos].health - pa->pets[boss_loc].strength; //Enemy deals damage to pet
			//Displays how much damage the pet did to the enemy
                	//The print statments are split into two lines for visual appeal when reviewing code
                	printf("%s%s", pa->pets[boss_loc].pet_name," has dealt ");
                	printf("%d%s%s\n", pa->pets[boss_loc].strength, " damage to ", pl->squad[fighter_pos].pet_name);
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
	printf("%s%s%s%s%s\n",pa->pets[a].sprite, "\t", pa->pets[b].sprite, "\t", pa->pets[c].sprite); 	
	printf("%s%d%s%d%s%d\n","🪙",pa->pets[a].cost, "\t🪙",pa->pets[b].cost, "\t🪙", pa->pets[c].cost);
}

void prompt (int total_coins)
{
	printf("Select a pet! Press 1 for the first pet, 2 for the second, and 3 for the third!\n");
	printf("Or pay a coin by pressing 4 for a reroll!\n\n");
	printf("%s%d%s\n","Total Coins: 🪙", total_coins, "\n");
}

void Choose_Pet(struct Pet_Array *pa, struct Pet_Lineup *pl)
{
	bool Too_poor = false; 
	int total_coins = 20; 
	pl->numPets = 0; //Start at 0, works for future battles
	int r1 = 1000;
	int r2 = 1000;
	int r3 = 1000;
    int input = 0;	
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
		scanf("%d", &input); //Get user input
		printf("\n");

		while (input != 1 && input != 2 && input != 3 && input != 4)
		{
			prompt(total_coins);
			print_Selection(pa, r1, r2, r3);
			scanf("%d", &input); //Get user input
			printf("\n");
		}

		while (input == 1 && total_coins < pa->pets[r1].cost)
		{
			printf("Not enough coins!\n");
			prompt(total_coins);
			print_Selection(pa, r1, r2, r3);
			scanf("%d", &input); //Get user input
			printf("\n");
		}

		while (input == 2 && total_coins < pa->pets[r2].cost)
		{
			printf("Not enough coins!\n");
			prompt(total_coins);
			print_Selection(pa, r1, r2, r3);
			scanf("%d", &input); //Get user input
			printf("\n");
		}

		while (input == 3 && total_coins < pa->pets[r3].cost)
		{
			printf("Not enough coins!\n");
			prompt(total_coins);
			print_Selection(pa, r1, r2, r3);
			scanf("%d", &input); //Get user input
			printf("\n"); 
		}

		if (input == 1)
		{	
			// Load all selected pet's info into the array of pets that will be used to battle
			pl->squad[pl->numPets].pet_name = pa->pets[r1].pet_name;
			pl->squad[pl->numPets].sprite = pa->pets[r1].sprite;
			pl->squad[pl->numPets].special = pa->pets[r1].special;
			pl->squad[pl->numPets].strength = pa->pets[r1].strength;
			pl->squad[pl->numPets].health = pa->pets[r1].health;
			pl->squad[pl->numPets].cost = pa->pets[r1].cost;
			total_coins = total_coins - pa->pets[r1].cost; 
			pl->numPets ++;
		}

		else if (input == 2)
		{
			pl->squad[pl->numPets].pet_name = pa->pets[r2].pet_name;
			pl->squad[pl->numPets].sprite = pa->pets[r2].sprite;
			pl->squad[pl->numPets].special = pa->pets[r2].special;
			pl->squad[pl->numPets].strength = pa->pets[r2].strength;
			pl->squad[pl->numPets].health = pa->pets[r2].health;
			pl->squad[pl->numPets].cost = pa->pets[r2].cost;
			total_coins = total_coins - pa->pets[r2].cost; 
			pl->numPets ++;
		}

		else if (input == 3)
		{
			pl->squad[pl->numPets].pet_name = pa->pets[r3].pet_name;
			pl->squad[pl->numPets].sprite = pa->pets[r3].sprite;
			pl->squad[pl->numPets].special = pa->pets[r3].special;
			pl->squad[pl->numPets].strength = pa->pets[r3].strength;
			pl->squad[pl->numPets].health = pa->pets[r3].health;
			pl->squad[pl->numPets].cost = pa->pets[r3].cost;
			total_coins = total_coins - pa->pets[r3].cost; 
			pl->numPets ++;
		}

		while (input == 4 && total_coins > 0) //Reroll 
		{
			total_coins = total_coins - 1; 

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
			scanf("%d", &input); //Get user input
			printf("\n");

			while (input != 1 && input != 2 && input != 3 && input != 4)
			{
				prompt(total_coins);
				print_Selection(pa, r1, r2, r3);
				scanf("%d", &input); //Get user input
				printf("\n");
			}

			while ((input == 1 && total_coins < pa->pets[r1].cost) || (input == 2 && total_coins <pa->pets[r2].cost) || (input == 3 && total_coins < pa-> pets[r3].cost))
			{
				printf("Not enough coins!\n");
				prompt(total_coins);
				print_Selection(pa, r1, r2, r3);
				scanf("%d", &input); //Get user input
				printf("\n");
			}

			if (input == 1)
			{	
				// Load all selected pet's info into the array of pets that will be used to battle
				pl->squad[pl->numPets].pet_name = pa->pets[r1].pet_name;
				pl->squad[pl->numPets].sprite = pa->pets[r1].sprite;
				pl->squad[pl->numPets].special = pa->pets[r1].special;
				pl->squad[pl->numPets].strength = pa->pets[r1].strength;
				pl->squad[pl->numPets].health = pa->pets[r1].health;
				pl->squad[pl->numPets].cost = pa->pets[r1].cost;
				total_coins = total_coins - pa->pets[r1].cost; 
				pl->numPets ++;
			}

			else if (input == 2)
			{
				pl->squad[pl->numPets].pet_name = pa->pets[r2].pet_name;
				pl->squad[pl->numPets].sprite = pa->pets[r2].sprite;
				pl->squad[pl->numPets].special = pa->pets[r2].special;
				pl->squad[pl->numPets].strength = pa->pets[r2].strength;
				pl->squad[pl->numPets].health = pa->pets[r2].health;
				pl->squad[pl->numPets].cost = pa->pets[r2].cost;
				total_coins = total_coins - pa->pets[r2].cost; 
				pl->numPets ++;
			}

			else if (input == 3)
			{
				pl->squad[pl->numPets].pet_name = pa->pets[r3].pet_name;
				pl->squad[pl->numPets].sprite = pa->pets[r3].sprite;
				pl->squad[pl->numPets].special = pa->pets[r3].special;
				pl->squad[pl->numPets].strength = pa->pets[r3].strength;
				pl->squad[pl->numPets].health = pa->pets[r3].health;
				pl->squad[pl->numPets].cost = pa->pets[r3].cost;
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
	Lore6(&select); 
	buff_Pets(&select);
	Choose_Pet(&select, &lineup);
	Rematch(&select, &lineup);
	Lore7();
	return 0;	
}