#include <stdio.h>
static char daytab[2][13] = { 
	{0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}, 
	{0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31} 
}; 
int day_of_year(int year, int month, int day){ 
 	int i, leap;
 	leap = year%4 == 0 && year%100 != 0 || year%400 == 0; 
	if(year > 1 && month <= 12 && !(month < 1) && !(day < 1) && day <= daytab[leap][month]){
		for (i = 1; i < month; i++){
                	day += daytab[leap][i];
       	 	}
		return day;
	} else {
		printf("Invalid input.\n");
		return 0;
	}
} 

int main(){
	int year, month, day, dayyear;
	printf("Enter year:\n");
	scanf("%d", &year);
	printf("Enter month:\n");
	scanf("%d", &month);
	printf("Enter day:\n");
	scanf("%d", &day);
	dayyear = day_of_year(year, month, day);
	if(dayyear != 0){
		printf("That is day %d of %d", dayyear, year);
	}
	return 0;
}
