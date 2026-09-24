#include <stdio.h>

char fun(int n);

int main () {
	printf("%c",fun(100));
	return 0;
}
char fun(int n) {
	int i;
	for(i=0;i<n; ++i) {
		printf("Functions are fun!!!\n");
	}
	return 0;
}

