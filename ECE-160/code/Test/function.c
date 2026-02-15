#include <stdio.h>

int isanum(char c); 

int main ()
{

	char c = getchar(); 

	printf("%d", isanum(c)); 



}

int isanum(char c) {

	if (c <= '9'&& c>= '0')
	{
		return 1; 
	
	}

	return 0; 

}
