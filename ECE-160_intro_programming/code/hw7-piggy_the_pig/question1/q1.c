#include <stdio.h>
#include <string.h>


void ranges(int x[10], int npts, int *max_ptr, int *min_ptr)                                                                                                  {
	
	*max_ptr = x[0];
  	*min_ptr = x[0]; 

	for (int j = 1; j < npts; j++)
	{
		if(x[j] < *min_ptr)
		{
			*min_ptr = x[j]; 
		}

		else if (x[j] > *max_ptr)
		{
			*max_ptr = x[j];
		}	

	}

} 

int main()
{
	int npts = 0;
	int max_ptr = 0;
	int min_ptr = 0; 
	printf("Enter length of array, must be no more than 10\n"); 
	scanf("%d", &npts);
        getchar();	
	char c; 

	int x[10]; 

	printf("Enter your array of numbers\n");
	for(int i =0; i< npts; i++)
        {
                scanf("%d",&x[i]);
        }	

	ranges(x, npts, &max_ptr, &min_ptr); 

	printf("Max value is ");
        printf("%d", max_ptr);	
	printf("\n");
        printf("Min value is ");
        printf("%d", min_ptr);	
	
	return 0;

}

