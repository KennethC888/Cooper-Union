#include <stdio.h>
#include <string.h>


struct Final_Fantasy
{
	char* name; 
	int age; 
	int height; 
};


void print_Average_Age(struct Final_Fantasy protag[], int num_People)
{
	int total_Age = 0;
	int av_age = 0; 

	for(int i = 0; i< num_People; i++)
	{
		total_Age += protag[i].age;
	}
	av_age = (total_Age)/(num_People); 

	printf("The average age of the protagonists is %d", av_age); 
	printf("\n");
}


void print_Tallest(struct Final_Fantasy protagonist[], int num_people)
{
	int max = 0;
	int position = 0;

	for (int h = 0; h<num_people; h++)
		if (protagonist[h].height > max)
		{
			max = protagonist[h].height;
		        position = h; 	
		}

	printf("The tallest protagonist is %s", protagonist[position].name);
	printf(".This protagonist is %d", max);
        printf(" inches tall."); 	
}


int main()
{
	struct Final_Fantasy Protagonist[7] = 
	{
		{"Cloud Strife", 21, 68}, 
		{"Terra Branford", 18, 63},
		{"Cecil Harvey", 20, 70},
		{"Lightning Faron", 21, 67},
		{"Squall Leonhart", 17, 70},
		{"Zidane Tribal", 16, 68},
		{"Bartz Kaluser", 20, 69}

	};
	
	printf("Here are the 7 most popular protagonists in the Final Fantasy franchise!\n");
	printf("\n");

	for (int j = 0; j < 7; j++)
	{
		printf("%s", Protagonist[j].name);
		printf("\n"); 
	}
	
	printf("\n");
	print_Average_Age(Protagonist, 7);
	printf("\n");
	print_Tallest(Protagonist, 7);

	return 0; 
}
