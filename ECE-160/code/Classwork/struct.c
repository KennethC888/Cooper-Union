#include <stdio.h>

struct Classroom {
	char* students[20]; 
	char* prof;
	int numStudents; 
	int numChairs;
	int numDesks;
};


void insertStudent(struct Classroom *classroom, char *student); 
void printClassroom(student Classroom *classroom); 


int main() 
{
	struct Classroom ece160;
        ece160.numChairs = 25;
	ece160.numDesks = 20; 	
	ece160.numStudents = 0; 

	char* charles = "Charles";
	char* prof = "Hong";
	ece160.prof = prof; 
	insertStudent(&ece160, charles);
	printClassroom(&ece160); 

}

void insertStudent(struct Classroom *classroom, char *student)
{
	(*classroom).students[classroom->numStudents] = student; 
	numStudents ++; 
}

void printClassroom (struct Classroom *classroom)
{
	printf("Students:\n");
	for (int i=0; i< classroom -> numStudents; i++)
	{
		printf("%s\n", classroom ->students[i]);
	}

	printf("Prof Name %s\n", classroom -> prof); 
	printf("Chairs: %d\n", classroom ->numChairs); 
	printf("Desks: %d\n", classroom ->numDesks); 

}
