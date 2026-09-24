#include <stdio.h>

int main()

{

	int NUM_BITS = 32; 
	int num = 36;
	int rotate = 2;

	printf("%d", num >> rotate|num << (NUM_BITS - rotate));

	return 0; 	


}
