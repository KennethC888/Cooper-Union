#include <stdio.h>
#include <string.h>


struct Student {

	char* fname; 
	char* lname;
	char* fit_level;


};

struct GymClass {
	char* className;
	char* instructor_name;
	char* start_time;
	char* end_time;
	int curr_numStudents;
	struct Student students[20];
	
};	


void addStudentToGymClass (struct GymClass *c, struct Student s)
{
	c->students[c->curr_numStudents].fname = s.fname;
	c->students[c->curr_numStudents].lname = s.lname;
	c->students[c->curr_numStudents].fit_level = s.fit_level;
	c->curr_numStudents++; 
}


void printGymClass (struct GymClass *c)
{

		printf("%s\n", c->instructor_name);
                printf("%s\n", c->start_time);
                printf("%s\n", c->end_time);

        
	for (int i =0; i< c->curr_numStudents; i++)
	{

		printf("%s\n", c->students[i].fname);
		printf("%s\n", c->students[i].lname);
		printf("%s\n", c->students[i].fit_level);
	
	}
}

int main()
{
	struct Student jane = {"Jane", "Doe", "Beginner"};
	struct Student john = {"John", "Smith", "Beginner"};
	struct Student eva = {"Eva", "Ava", "Expert"};
	struct GymClass FITNESS ={"Weight Training", "Tony", "6:15 p.m.", "7:00 p.m.", 0};


	addStudentToGymClass (&FITNESS, jane);
        addStudentToGymClass (&FITNESS, john);
	addStudentToGymClass (&FITNESS, eva);	

	printGymClass (&FITNESS); 


	return 0; 
}
