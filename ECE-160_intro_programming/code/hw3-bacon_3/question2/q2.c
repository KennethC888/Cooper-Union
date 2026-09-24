#include <stdio.h>
#include <ctype.h>
#include <math.h>
#include <string.h>


int htoi(char * string)
{
	int convert = 0;

	if (string[0] == '0' && (string[1] == 'x' || string[1] == 'X'))
	{
		for (int j = 2; j<strlen(string); j++)
        	{
                if (string[j] >= 'a' && string[j] <='f')
                        {
                        convert += (string[j] - 'a' + 10) *pow(16, strlen(string)-j-1);
                        }

                else if (string[j] >= 'A' && string[j] <='F')
                        {
                        convert += (string[j] - 'A' + 10) *pow(16, strlen(string)-j-1);
                        }

                else if (string[j] >= '0' && string[j] <= '9')
                        {
                        convert += (string[j] - '0') *pow(16, strlen(string)-j-1);
                        }
                else
                        {
                        printf("Invalid");
                        }

		}
			return convert;
	  }
	
	else 
	{
		 for (int i =0; i<strlen(string); i++)
        	{
                if (string[i] >= 'a' && string[i] <='f')
                        {
                        convert += (string[i] - 'a' + 10) *pow(16, strlen(string)-i-1);
                        }

                else if (string[i] >= 'A' && string[i] <='F')
                        {
                        convert += (string[i] - 'A' + 10) *pow(16, strlen(string)-i-1);
                        }

                else if (string[i] >= '0' && string[i] <= '9')
                        {
                        convert += (string[i] - '0') *pow(16, strlen(string)-i-1);
                        }
                else
                        {
                        printf("Invalid");
                        }

        	}
	}               return convert;
}

int main()
{

	char c[100]; 
	printf("Enter a hexadecimal"); 
	scanf("%s", c);

	printf("%d", htoi(c)); 

	return 0; 

}



