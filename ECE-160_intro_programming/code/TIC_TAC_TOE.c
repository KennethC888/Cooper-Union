#include <stdio.h> 


char board [3][3]; 
char computer, user; 



int main () {
	
if (user_first()) 
{
	user = 'X'; 
	computer = 'O'; 
}	


else 
{
	user = 'O';
	computer ='X'; 

}

	init_board();
	print_board();
	play_game(); 
	user_move(); 


	return 0; 


}

void user_move()
{
	int x, y; 
	do {
		printf("Where would you like to place your letter?\n");
	scanf("%d %d", &x, %y);
	}while (x >=0 && x<=2 && y>=0 && y<=2 && board[x][y] !='-'); 
	board[x][y] = user;
}


void play_game()
{

	
	int turn =1; 
	for (; turn <=9; turn ++)
	{
		if (turn%2==1);
		{
			user_move(); 
		}
	}

	else
	{
		if (user =='O')
			computer_move(); 
	}

	print_board(); 
}

void computer_move()
{

	//win
	 
	//block
	
	//center
	if (board[1][1] == '-') 
	{
		board[1][1] = computer; 
	}	
	
	else if (board[0][0] == '-')
	{
		board[0][0] = computer; 
	}

  else if (board[0][2] == '-')
        {
                board[0][2] = computer;
        }
  else if (board[2][0] == '-')
        {
                board[2][0] = computer;
        }
    else if (board[2][2] == '-')
        {
                board[2][2] = computer;
        }
	//corner
	
	//side
	
  else if (board[0][1] == '-')
        {
                board[0][1] = computer;
        }
    else if (board[1][0] == '-')
        {
                board[1][0] = computer;
        }
  else if (board[1][2] == '-')
        {
                board[1][2] = computer;
        }

    else if (board[2][1] == '-')
        {
                board[2][1] = computer;
        }
}


int symbol_won(char c)
{
	for(int col =0; col <=2; col++)
	{
		int a, b, c; 
			a = board[0][col];
			b = board[1][col];
			c = board[2][col]; 
		if (a ==b && b ==c && a == letter)
		{
			return 1; 
		}

	}


		if (board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0] == letter)
		{
			return 1; 
		}

		   if (board[0][2] == board[1][1] && board[1][1] == board[2][o] && board[0][2] == letter)
                {
                        return 1;
                }
	return 0; 

}



void init_board() 
{
	int row, col;

	for (row =0; row <= 2; row ++)
	{
		for (col = 0; col<=2; col ++)

		{
			board[row][col] = '-'; 		
		}
	}
	

}



void print_board()
{
        int row, col;

        for (row =0; row <= 2; row ++)
        {
                for (col = 0; col<=2; col ++)

                {
                        printf("%c", board[row][col]);
                }
		printf("\n"); 
        }


}


   int user_first()
{
   printf("Would you like to go first? (Y/N) \n");

        char choice;
        int stupdityCount =0;
        do{
                if(stupidityCount++ ==0 )

                {
                        printf("Would you like to go first (Y/N)\n");

                }

                else
                {
                        printf("You stupid x %d. Enter Y/N\n", stupidityCount ++ -1);
                }
        }

        scanf("%c", &choice);
        getchar();
        }while (choice !='Y' && choice !='N');
}
