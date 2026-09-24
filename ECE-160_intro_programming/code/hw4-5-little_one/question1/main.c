#include <stdio.h>
#include <board.h>
#include <globals.h>
#include <play_game.h>
#include <player.h>
#include <player_vs_comp.h>

int main(){
	int row_len, col_len; 
        printf("Let's play SOS!\n");
        printf("How many rows will the board have?\n");
        scanf("%d", &row_len);
	while(getchar()!='\n');
	//clear buffer. without this, entering a char instead of an int will infinitely print "that is not a valid value"
        while(row_len <= 0 || row_len > 50) {
                printf("That is not a valid value. n ranges from 1-50\n");
                scanf("%d",&row_len);
		while(getchar()!='\n');
		//clear buffer again to avoid infinite loop
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
        do{
		if(begin()){
			printf("2 player game\n");
			pvp();
		} else {
			pve();
		}
	} while (play_again());
	printf("Thank you for playing SOS\n");
	return 0;
}

