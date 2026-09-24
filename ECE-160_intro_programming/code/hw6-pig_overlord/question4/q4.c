#include <stdio.h>

void strcopy(char *s, char *t, int n)
{
    while ((*s++ = *t++) && --n >0)
        ;

}

int main()
{
    char s[1000];
    char t[1000];
    int n = 0;

    printf("Enter a string:\n");
    scanf("%s", s);
    printf("Enter a string:\n");
    scanf("%s", t);
    printf("Enter a number:\n");
    scanf("%d", &n);

    strcopy(s,t,n);

    printf("%s", s);
    return 0;
}
