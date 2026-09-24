#include <stdio.h> 


int main() 

{
	printf("What is the meaning of life? \n"); 
	printf("A: To be successful \n"); 
	printf("B: To find true love \n");
	printf("C: To establish a legacy \n"); 
	printf("D: 42\n"); 	
			
	char choice = getchar(); 
 	 	
	if (choice == 'D')
	{
	printf("Correct!!!\n"); 	   
	}

	else if (choice == 'A' || choice == 'B' || choice == 'C') 
	{
	printf("Wrong.\n"); 
	}

	else 
	{
        printf("Invalid choice.\n"); 
	}


	return 0;


}
