#include <stdio.h>

int main()
{
        int x = 14;
        int p = 2;
        int n = 1;
        int inverted_X =~ (~0 << n) << (p - n + 1);

        printf("%d", x^inverted_X);

	return 0;
}
  
