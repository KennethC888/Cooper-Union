#include <stdio.h>
//#include <lore.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>
#include <stdbool.h>

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

void Lore6()
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