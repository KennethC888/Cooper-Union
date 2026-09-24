#include <stdio.h>
#include <ctype.h>
#include <math.h>
#include <string.h>


void itob (int num, char s[], int base)
{

	int remainder = 0;
	int counter = 0;
	int c, i, j; 

	while (num > 0)
	{
		remainder = num % base;

		if (remainder > 9)
		{
			s[counter] = remainder -10 + 'A'; 
		}

		else 
		{
			s[counter] = remainder + '0';
		} 
		
		counter ++;
                num = num/base;
	}

		s[counter] = '\0'; 

    		for (i = 0, j = strlen(s) - 1; i < j; i++, j--)
    		{
        		c = s[i];
        		s[i] = s[j];
        		s[j] = c;
    		}
  

}



int main()
{

        int n = 0; 
	int b = 0; 
	char answer[1000]; 

        printf("Enter a number\n");
        scanf("%d", &n);
	printf("Enter a base for the number to be converted into\n");
        scanf("%d", &b);
	itob(n,answer, b); 
	printf("%s", answer); 

        return 0;

}

