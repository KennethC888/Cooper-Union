#include <stdio.h>
#include <board.h>
#include <player.h>
#include <globals.h>

char turn1;
int turn;
int p1score;
int p2score;

void symbol_won(char symbol, char wturn);

void pvp()
{

  	for (turn = 1; turn <= (row_len*col_len); turn++)
  	{
    	//Determines who's turn it is/* 
    	if (turn % 2 == 1)
		{
			turn1 = 'p';
      		player1_move();
			printf("square: %d %d \n player1: %c \nturn1: %c\n", row, col, player1, turn1);
			printf("square: %d %d\n player2: %c \nturn1: %c\n", row, col, player2, turn1);
			symbol_won(player1, turn1);
		}
    		else
		{
			turn1 = 'c';
			player2_move();
			printf("square: %d %d \nplayer1: %c \nturn1: %c\n", row, col, player1, turn1);
			printf("square: %d %d \nplayer2: %c \nturn1: %c\n", row, col, player2, turn1);
			symbol_won(player2, turn1);
		}

		    print_board(row_len, col_len);
		    printf("Player one has %d points\n", p1score);
		    printf("Player two has %d points\n", p2score);
		    printf("\n");
	}
	if(p1score > p2score){
		printf("player 1 win\n");
	} else if (p2score > p1score){
		printf("player 2 win\n");
	} else {
		printf("draw\n");
	}	
}

int play_again()
{
        char response;

        printf("Do you want to play again? (y/n) ");
        do
        {
            response = getchar();

        } while (response != 'y' && response != 'n');

        if (response == 'y')
        {
				printf("How many rows will the board have?\n");
				scanf("%d", &row_len);
				while(getchar()!='\n');
				while(!(row_len > 0 && row_len <= 50)) {
					printf("That is not a valid value. n ranges from 1-50\n");
					scanf("%d",&row_len);
					while(getchar()!='\n');
				}
					printf("How many columns will the board have?\n");
					scanf("%d", &col_len);
				while(getchar()!='\n');
				while(col_len <= 0 || col_len > 50) {
							printf("That is not a valid value. m ranges from 1-50\n");
							scanf("%d",&col_len);
					while(getchar()!='\n');
					}
				init_board(row_len,col_len);
				print_board(row_len,col_len);
				
                return 1;
        }
        else
        {
                return 0;
        }
}

int begin()
{
        printf("Welcome to SOS.\n");
        char response;

        printf("Play against (p)layer or (c)omputer: ");

        do
        {
                response = getchar();
        } while (response != 'p' && response != 'c');

        if (response == 'p')
        {
                return 1;
        }
        else
        {
                return 0;
        }
}

void symbol_won (char symbol, char turn)
{
	row = row - 1;
	col = col - 1;

	if (turn1 == 'p')
	{
  		if(symbol == 'S')
  		{
        	if ((board[row][col-1] == 'O') && (board[row][col-2] == 'S'))
        		{
				    if ((col-1 >= 0) && (col-2 >= 0))
				    {
                		p1score++;
				    }
        		}
			if ((board[row][col+1]== 'O') && (board[row][col+2] == 'S'))
			{
				p1score++;
			}
			if((board[row+1][col] == 'O') && (board[row+2][col] == 'S'))
			{
				p1score++;
			}
			if((board[row-1][col] == 'O') && (board[row-2][col] == 'S'))
			{
				if ((row-1 >= 0) && (row-2 >= 0))
				{
					p1score++;
				}
			}
			if((board[row+1][col+1] == 'O') && (board[row+2][col+2] == 'S'))
			{
				p1score++;
			}
			if((board[row-1][col-1] == 'O') && (board[row-2][col-2] == 'S'))
			{
				if ((row-1 >= 0) && (row-2 >= 0) && (col-1>=0) && (col-2>=0))
				{
					p1score++;
				}
			}
			if((board[row+1][col-1] == 'O') && (board[row+2][col-2] == 'S'))
			{
				if ((col-1 >= 0) && (col-2 >= 0))
				{
					p1score++;
				}
			}
			if((board[row-1][col+1] == 'O') && (board[row-2][col+2] == 'S'))
			{
				if ((row-1 >= 0) && (row-2 >= 0))
				{
					p1score++;
				}
			}
  		}
        //NOTE: Formatting like that is terrible, will change it to this now: 
  		else if(symbol == 'O')
  		{
        		if((board[row+1][col] == 'S') && (board[row-1][col] == 'S'))
        		{
				    if (row-1 >= 0)
				    {
					    p1score++;
				    }
        		}
        		if((board[row][col+1] == 'S') && (board[row][col-1] == 'S'))
        		{
				    if (col-1 >= 0)
				    {
					    p1score++;
				    }
        		}
        		if((board[row+1][col+1] == 'S') && (board[row-1][col-1] == 'S'))
        		{
				    if ((row-1 >= 0) && (col-1 >= 0))
				    {
					    p1score++;
				    }
        		}
        		if((board[row+1][col-1] == 'S') && (board[row-1][col+1] == 'S'))
        		{
				    if ((col-1 >= 0) && (row-1 >= 0))
				    {
				        p1score++;
				    }		
        		}
  		}
	}
	else
	{

    if(symbol == 'S')
    {
	    if ((board[row][col-1] == 'O') && (board[row][col-2] == 'S'))
        {
            if ((col-1 >= 0) && (col-2 >= 0))
            {
            p2score++;
            }
        }
        if ((board[row][col+1]== 'O') && (board[row][col+2] == 'S'))
        {
             p2score++;
        }
        if((board[row+1][col] == 'O') && (board[row+2][col] == 'S'))
        {
             p2score++;
        }
        if((board[row-1][col] == 'O') && (board[row-2][col] == 'S'))
        {
            if ((row-1 >= 0) && (row-2 >= 0))
            {
                p2score++;
             }
        }
        if((board[row+1][col+1] == 'O') && (board[row+2][col+2] == 'S'))
        {
            p2score++;
        }
        if((board[row-1][col-1] == 'O') && (board[row-2][col-2] == 'S'))
        {
            if ((row-1 >= 0) && (row-2 >= 0) && (col-1>=0) && (col-2>=0))
            {
                p2score++;                  
            }
        }
        if((board[row+1][col-1] == 'O') && (board[row+2][col-2] == 'S'))
        {
            if ((col-1 >= 0) && (col-2 >= 0))
            {
                p2score++;
            }
        }
        if((board[row-1][col+1] == 'O') && (board[row-2][col+2] == 'S'))
        {
            if ((row-1 >= 0) && (row-2 >= 0))
            {
                p2score++;
            }
        }
    }
		else
		{
        if((board[row+1][col] == 'S') && (board[row-1][col] == 'S'))
        {
            if (row-1 >= 0)
            {
                p2score++;
            }
        }
        if((board[row][col+1] == 'S') && (board[row][col-1] == 'S'))
        {
            if (col-1 >= 0)
            {
                p2score++;                        
            }
        }
        if((board[row+1][col+1] == 'S') && (board[row-1][col-1] == 'S'))
        {
            if ((row-1 >= 0) && (col-1 >= 0))
            {
                p2score++;
                                      
            }
        }
        if((board[row+1][col-1] == 'S') && (board[row-1][col+1] == 'S'))
        {
            if ((col-1 >= 0) && (row-1 >= 0))
                {
                    p2score++;
                }
        }
    }
	}
}
