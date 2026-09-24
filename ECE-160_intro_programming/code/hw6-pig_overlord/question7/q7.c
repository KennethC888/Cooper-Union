#include <stdio.h>

int strcomp(char *cs, char *ct, int n) { 
	while (--n > 0 && *cs++ == *ct++ && *cs != '\0'){
		;
	}
	if (*cs == *ct){
		return 0;
	}
 	return *cs - *ct; 
} 

int main() {
	char cs[100], ct[100];
	int n;
	printf("Enter string cs:\n");
	scanf("%s", cs);
	printf("Enter string ct:\n");
	scanf("%s", ct);
	printf("Enter n:\n");
	scanf("%d", &n);
	printf("%d", strcomp(cs, ct, n));
	return 0;
}
