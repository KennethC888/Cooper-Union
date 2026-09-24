#include <stdio.h>
#include <board.h>
#include <globals.h>
#include <play_game.h>

char board[9][9];
char computer, user;

int main(){
	char n, m;
	int row_len, col_len; 
        printf("Let's play SOS!\n");
        printf("How many rows will the board have?\n");
        do {
                n = getchar();
        } while (!(n > '0' && n <= '9'));
        printf("How many columns will the board have?\n");
        do {
                m = getchar();
        } while (!(m > '0' && m <= '9'));
        row_len = n -'0'; 
	col_len = m - '0'; 
        n = n - '0';
        m = m - '0';
       
        init_board(n,m);
        print_board(n,m);
	return 0;
}
