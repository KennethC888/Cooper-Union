#include <stdio.h>
#include <math.h>


int main ()
        {
         double x1 = -3.0;
	 double x2 = 6.0;
	 double y1 = 2.0;
	 double y2 = -5.0; 

         float distance = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
	 distance = sqrt(distance);

         printf("%lf", distance);

         return 0;
        }
