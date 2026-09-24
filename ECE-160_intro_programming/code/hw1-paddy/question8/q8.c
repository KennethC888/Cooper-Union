#include <stdio.h>

int main ()

        {
         float PI = 3.1415;
         float RADIUS = 6371.0;

	 float s_area = 4.0 * PI * RADIUS * RADIUS; 
	 float vol = (4.0/3.0) * PI * RADIUS * RADIUS * RADIUS;  
         printf("%f", s_area);
	 printf("\n"); 
	 printf("%f", vol); 

         return 0;
        }
