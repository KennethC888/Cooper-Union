#include <stdio.h>

int main ()

        {
         float PI = 3.1415;
         float radius = 2.0;
	 float height = 5.0;
	
	 float s_area = (2 * PI * radius * height) + (2 * PI * radius * radius); 
         float vol = (PI * radius * radius * height); 
	 printf("%f", s_area);
	 printf("\n"); 
	 printf("%f", vol); 

         return 0;
        }
