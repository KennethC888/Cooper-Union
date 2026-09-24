#include <stdio.h>

static char daytab[2][13] = { 
 	{0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}, 
	{0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31} 
}; 
void month_day(int year, int yearday, int *pmonth, int *pday){ 
 	int i, leap; 
	leap = year%4 == 0 && year%100 != 0 || year%400 == 0; 
	if (leap){
		if (year > 1 && yearday <= 366 && !(yearday < 1)){
			for (i = 1; yearday > daytab[leap][i]; i++){
        	        	yearday -= daytab[leap][i];
        		}
		} else {
			printf("Invalid input.\n");
		}
	} else {
		if (year > 1 && yearday <= 365 && !(yearday < 1)){
                        for (i = 1; yearday > daytab[leap][i]; i++){
                                yearday -= daytab[leap][i];
                        }
                } else {
                        printf("Invalid input.\n");
                }
	}
 	*pmonth = i; 
 	*pday = yearday;
} 
int main() {
	int year, yearday;
	int pmonth, pday;
        printf("Enter year:\n");
        scanf("%d", &year);
        printf("Enter day of year:\n");
        scanf("%d", &yearday);
        month_day(year, yearday, &pmonth, &pday);
        if (pmonth <= 12 && !(pmonth < 1) && !(pday < 1) && pday <= 31){

		printf("Day %d of %d is %d/%d/%d", yearday, year, pmonth, pday, year);
	}
	return 0;
}
