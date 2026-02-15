#include <stdio.h>

extern int p1score;
extern int p2score;
extern int turn;
extern char turn1;
void pvp(void);
int play_again(void);
int porc(void);
void symbol_won(int square, char symbol, char wturn);