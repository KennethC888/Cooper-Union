#include <stdio.h>

int main() {
	char letter = 'X';
	(letter >= 'A' && letter <= 'Z') ? printf("%c\n", letter + 32) : printf("not an uppercase letter\n");
	//32 is distance btwn an uppercase letter and its lowercase in ascii
	return 0;
}
