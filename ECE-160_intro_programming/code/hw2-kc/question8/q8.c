#include <stdio.h>

int main()
{
	printf("Let's play Rock, Paper Scissors!\n");
	printf("Enter r for rock, p for paper, or s for scissors\n");
	char rps = getchar(); 

	if (rps == 'r')
	{
		printf("The computer chose rock.\n");
		printf("Tie.");
	}

	else if (rps == 's')
        {
                printf("The computer chose rock.\n");
                printf("You lose.");
        }
   	else if (rps == 'p')
        {
                printf("The computer chose rock.\n");
                printf("You win!");
        }
	else 
	{
		printf("Invalid choice. Please enter r, p, or s.\n"); 
	}

	return 0; 
}
