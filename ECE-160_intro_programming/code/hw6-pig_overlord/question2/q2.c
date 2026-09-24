#include <stdio.h>
#include <string.h>

void str_combine(char *s, char *t)
{
	
	while (*s !='\0')
	{
		++s; 
	}
		
	while ((*s = *t) != '\0')
	{
		++s;
		++t; 
	}

}

int main()
{

    char s[1000]; 
    char t[1000];
    printf("Enter a string\n");
    scanf("%s", s);
    printf("Enter a string\n");
    scanf("%s", t); 

    str_combine(s, t);
    printf("%s", s); 
    return 0;
}
