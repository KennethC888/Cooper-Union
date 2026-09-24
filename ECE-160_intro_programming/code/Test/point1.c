#include <stdio.h>
#include <string.h>

void strendcpy(char *dest, char *src, int num);

int main() {
    char s[] = "HappyHalloween";
    char t[] = "boooooo";
    int n = 4;
    strendcpy(s,t,n);
    printf("%s\n",s);
    return 0;
}

void strendcpy(char *dest, char *src, int num) {

	int b = strlen(dest);
	dest = dest + b - num; 
	for (int i = 0; i< num; i++)
	{
		*dest++ = *src++; 
	}

}


// dest = dest +strlen(dest); 
// for (int i =0; i< strlen(src); i++)
// {
//	*dest++ = *src++; 
// }
