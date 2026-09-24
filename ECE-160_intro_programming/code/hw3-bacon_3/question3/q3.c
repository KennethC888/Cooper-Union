#include <stdio.h>
#include <ctype.h>
#include <math.h>
#include <string.h>


void squeeze (char s1[], char s2[])
{
	int new = 0; 
	char result[5000];
       	int count; 

	for (int i =0; i<strlen(s1); i++)
	{
		for (int j = 0; j<strlen(s2); j++)
		{
			if (s2[j] == s1[i])
			{
				count ++; 				
			}
		}
			if (count > 0)
			{
				count = 0; 
			}

			else 
			{
				result[new] = s1[i];
			       	new ++; 
				count = 0; 	
			}
		
	}
	
	result[new] = '\0'; 	

	printf("%s", result); 
	
}


int main()
{

	char s1[500];
	char s2[500]; 

	printf("Enter the first string\n");
	scanf("%s", s1);

	printf("Enter the second string\n");
        scanf("%s", s2);

	squeeze(s1, s2);
 	//printf("%s",s1); 

	return 0;

}
