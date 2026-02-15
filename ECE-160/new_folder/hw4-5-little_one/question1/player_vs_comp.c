#include <stdio.h>
#include <player.h>
#include <play_game.h>
#include <board.h>


char user, comp, p12;

int user_first();
void play_game();
void player_vs_computer();
void player_move();
void comp_move();

int user_first()
{
        char response;
        printf("Do you want to go first? (y/n) ");
        do
        {
                response = getchar();
        } while (response != 'y' && response != 'n');

        if (response == 'y')
        {
		p12 = 1;
		turn1 = 'u';
		comp = 'O';
                return 1;
        }
        else
        {
		p12 = 2;
		turn1 = 'c';
		comp = 'O';
                return 0;
        }
}

void play_game()
{
        for (turn = 1; turn <= row_len * col_len; turn++)
        {
                if(turn % 2 == 1)
                {
                        if (turn1 == 'c')
                        {
                                comp_move();
				printf("Turn %d\n", turn);
				symbol_won(square,comp,turn1);
                        }
                        else
                        {	
                                player_move();
				printf("Turn %d\n", turn);
				symbol_won(square,user,turn1);
                        }
                }
                else
                {
                        if (turn1 == 'u')
                        {
                                comp_move();
				printf("Turn %d\n", turn);
				symbol_won(square,comp,turn1);
                        }
                        else
                        {
                                player_move();
				printf("Turn %d\n", turn);

				symbol_won(square,user,turn1);
                        }
                }
		
                draw_board();
		if (p12 == 1)
		{
			printf("Player score:%d\n", p1score);
			printf("Computer score:%d\n", p2score);
		}
		else
		{
			printf("Player score: %d\n", p2score);
			printf("Computer score:%d\n", p1score);
		}
	}
	if (p12 == 1)
	{
		if (p1score > p2score)
		{
			printf("Player won!\n");
		}
		else if (p1score == p2score)
		{
			printf("Tie game.\n");
		}
		else 
		{
			printf("Computer won! \n");
		}
	}
	else 
	{
		if (p1score > p2score)
		{
			printf("Computer won!\n");
		}
		else if (p1score== p2score)
		{
			printf("Tie game.\n");
		}
		else
		{
			printf("Player won!\n");
		}
	}
		
}

void player_vs_computer()
{
	if(user_first())
	{
		printf("Start game, player moves first\n");
		play_game();
	}
	else 
	{
		comp = 'O';
		printf("Start game, computer moves first\n");
		play_game();
	}

}


void player_move()
{
	printf("Player ");
	s_or_o();

        do {
        printf("Player (%c) enter a square (1-25): ", user);
        scanf("%d", &square);
        } while (!square_valid(square));

        int row = (square - 1) / row_len;
        int col = (square- 1) % col_len;

        board[row][col] = user;
}

void comp_move()
{
	for (int i = 0; i < row_len; i++)
	{
		for (int j = 0; j < col_len; j++)
		{
			if (board[i][j] == '_')
			{
				board[i][j] = comp;
				square = (i * row_len) + j + 1;
				return;
			}
		}
	}
}