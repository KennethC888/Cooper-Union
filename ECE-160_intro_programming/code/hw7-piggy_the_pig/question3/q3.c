#include <stdio.h>
#include <ctype.h>
struct point {
    	int x;
    	int y;
};

int ptratoi(char *s);

int main(int argc, char* argv[])
{	
	int ptnum = 11;
	struct point line[ptnum-1];
	if (argc != 4){
		printf("Usage: a b c");
	} else {
		int a = ptratoi(argv[1]);
		int b = ptratoi(argv[2]);
		int c = ptratoi(argv[3]);
		for(int i=0, j=-5;i<ptnum;i++, j++){
			line[i].x = j;
			line[i].y = (a*(j*j))+ (b*j) + c;
		}
		for(int i=0; i<ptnum; i++){
			printf("point %d on the curve is (%d, %d)\n", i+1, line[i].x, line[i].y);
		}
	}
    	

    	return 0;
}

int ptratoi(char *s){ // modified to use ptrs instead of indices
 	int n, sign;
        while(isspace(*s)){
                s++;
        }
 	sign = (*s == '-') ? -1 : 1;
 	if (*s == '+' || *s == '-'){ /* skip sign */
        	s++;
	}
 	for (n = 0; isdigit(*s); s++)
        	n = 10 * n + (*s - '0');
 	return sign * n;
}
