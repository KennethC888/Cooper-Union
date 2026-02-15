#include <stdio.h>


void change(int *number)
{
	number += 3; 
	printf("%d", number); 
	change(number); 
}

int main()
{

int num = 5; 
change(

return 0;
}
