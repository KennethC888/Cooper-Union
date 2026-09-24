#include <stdio.h>
#include <board.h>
#include <play_game.h>
#include <player_vs_comp.h>
#include <globals.h>
#include <player.h>
#include <time.h>
void pve();
void comp_move();
char user, comp;
int comp_row, comp_col;

void pve(){
	for (turn = 1; turn <= (row_len*col_len); turn++)
  	{
    	//Who goes first? 
    	if (turn % 2 == 1)
		{
			turn1 = 'p';
      		player1_move();
			printf("square: %d %d \nuser: %c \nturn1: %c\n", row, col, user, turn1);
			printf("square: %d %d\ncomputer: %c \nturn1: %c\n", comp_row, comp_col, comp, turn1);
			symbol_won(user, turn1);
		}
    		else
		{
			turn1 = 'c';
			comp_move();
			printf("square: %d %d \nuser: %c \nturn1: %c\n", row, col, user, turn1);
			printf("square: %d %d \ncomputer: %c \nturn1: %c\n", comp_row, comp_col, comp, turn1);
			symbol_won(comp, turn1);
		}

		    print_board(row_len, col_len);
		    printf("User has %d points\n", p1score);
		    printf("Computer has %d points\n", p2score);
		    printf("\n");
	}
	if(p1score > p2score){
		printf("user win\n");
	} else if (p2score > p1score){
		printf("computer win\n");
	} else {
		printf("draw\n");
	}	
}

void comp_move(){
	srand(time(NULL));
	if((rand() % 2) == 0){
		comp = 'S';
	}else {
		comp = 'O';
	}
	do{
		comp_row = rand() % row_len;
		comp_col = rand() % col_len;
	}while (!(board[comp_row][comp_col] == '-'));
	board[comp_row][comp_col] = comp;
}
