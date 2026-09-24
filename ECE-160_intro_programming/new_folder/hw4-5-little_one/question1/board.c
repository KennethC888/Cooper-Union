#include <stdio.h>
#include <globals.h>
#include <board.h>

char board[9][9]; 
int row_len, col_len, size; 

void init_board(int n, int m){
        row_len = n;
        col_len = m; 
      //  size = row_len *col_len; 
        int row, col;
        for(row=0;row<=(n-1);row++){
                for(col=0;col<=(m-1);col++){
                        board[row][col] = '-';
                }
        }
}

void print_board(int n, int m){
        int row, col;
        for(row=0;row<=(n-1);row++){
                for(col=0;col<=(m-1);col++){
                        printf("%c", board[row][col]);
                }
                printf("\n");
        }
}
