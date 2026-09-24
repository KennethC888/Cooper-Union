#include <stdio.h>

int main() {

	// Note: This is how you can declare and initialize an array
	int monthDays[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
      // &monthDays[0] = cbf0 
 
	int *mPtr1, *mPtr2;

	mPtr1 = monthDays;
	mPtr2 = &monthDays[6];

	printf("%ls", mPtr1); 
	printf("%ls", mPtr2); 

	return 0;
}
