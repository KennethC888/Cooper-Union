	#include <stdio.h>

	int main()
	{
	
		int x = 3; 
		
		if (x < 4)
		{
			printf("%d", x << 2); 
		}

		else if (x >= 8)
		{
			printf("%d", x >> 2); 
		}

		else 
		{
			printf("%d", x); 
		}

		int y = 6;

                if (y < 4)
                {
                        printf("%d", y << 2);
                }

                else if (y >= 8)
                {
                        printf("%d", y >> 2);
                }

                else
                {
                        printf("%d", y);
                }

		 int z = 9;

                if (z < 4)
                {
                        printf("%d", z << 2);
                }

                else if (x >= 8)
                {
                        printf("%d", z >> 2);
                }

                else
                {
                        printf("%d", z);
                }

              
		return 0; 
	}

