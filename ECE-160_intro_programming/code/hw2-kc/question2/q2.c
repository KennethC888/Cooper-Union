#include <stdio.h> 

int main () {
	int x = 25;
	int p = 1;
	int n = 3;
	int y = 6;
	// x = 0001 1001
	// y = 0110
	// end result should be 0001 1101?
	int bitmask = ~((~0) << n);
	// bitmask keeps or removes specific bits. in this case, bitmask = 0111 to operate on n=3 bits
	int answer = ((bitmask & y) << p) | (~(bitmask << p) & x);
	//bitmask & y = 110, the three bits of y are kept then shifted by p so 1100 
	// bitmask << p = 1110, ~(bitmask << p) = 1111, & x = 0001 0001
	// = 0001 1101 
	printf("%i\n", answer);

}
