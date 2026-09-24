#include <stdio.h>
#include <board.h>
#include <play_game.h>
#include <player_vs_comp.h>

char player1;
char player2;


void player1_move();
void player2_move();

int square;
//int size = (len_row *len_row); 

void s_or_o()
{
	char response;
	printf("place an s or o? (S/O)");
	do
	{
		response = getchar();
	} while (response != 's' && response != 'S' && response != 'o' && response != 'O');
	
	if (response == 's' || response == 'S')
	{
		player1 = 'S';
		player2 = 'S';
		user = 'S';
	}
	else
	{
		player1 = 'O';
		player2 = 'O';
		user = 'O';
	}
}

int square_valid(int square)
{
	int row;
	int col;

	row = (square - 1) / row_len;
	col = (square - 1) % col_len;
	
	if (square >= 1 && square <= (size))
	{
		if (board[row][col] == '_')
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}
	else
	{
		return 0;
	}
}

void player1_move()
{
	printf("Player one ");
	s_or_o();

	    do 
        { 
	    printf("Player one (%c) enter a square (1 through %d", size, player1);
	    scanf("%d", &square);
	    printf("\n");
	    } while (!square_valid(square));

	int row = (square - 1) / row_len;
	int col = (square- 1) % col_len;

	board[row][col] = player1;
}
void player2_move(void)
{
	printf("Player two ");
	s_or_o();
	
        do 
        {
        printf("Player two (%c) enter a square (1 through %d", size, player2);
        scanf("%d", &square);
	    printf("\n");
        } while (!square_valid(square));

        int row = (square - 1) / row_len;
        int col = (square- 1) % col_len;

        board[row][col] = player2;
}