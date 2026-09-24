#include <stdio.h>
#include <string.h>

int str_cmp(char *s, char *t)
{
 for(; *s == *t; s++, t++)
 {
	if (*s =='\0')
	{
		return 0;
	}	
 } 
 		return *s - *t;
}


int strend(char *s, char *t)
{

    int slen = strlen(s); 
    int tlen = strlen(t);    
    int diff = slen - tlen; 

    s+= slen - tlen;

   if(0 == str_cmp(s, t))
   {
	printf("1");
   	return 1;
        	
   }
   	printf("0");
  	return 0; 
}


int main()
{
    char s[1000];
    char t[1000];

    printf("Enter a string\n");
    scanf("%s", s);
    printf("Enter a string\n");
    scanf("%s", t); 

    strend(s,t);

    return 0;
}
