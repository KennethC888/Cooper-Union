#include <stdio.h>
#include <board.h>
#include <play_game.h>
#include <globals.h>
char player1;
char player2;
int row, col;

void player1_move();
void player2_move();

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

int square_valid()
{
	if (row <= row_len && col <= col_len && row > 0 && col > 0 )
	{
		if (board[row-1][col-1] == '-')
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
	printf("Player one (%c) enter a square (row col)", player1);
	scanf("%d %d", &row, &col);
	printf("\n");
	} while (!square_valid(row, col));
	board[row-1][col-1] = player1;
}
void player2_move()
{
	printf("Player two ");
	s_or_o();
        do 
        {
        printf("Player two (%c) enter a square (row col)", player2);
        scanf("%d %d", &row, &col);
	    printf("\n");
        } while (!square_valid(row, col));
        board[row-1][col-1] = player2;
}
