#include <stdio.h>
#include <ctype.h>

int getch(void);
void ungetch(int c);


int getfloat(float *pn) {
    int c, sign;
    float power;

    while (isspace(c = getch()))  
        ;

    if (!isdigit(c) && c != EOF && c != '+' && c != '-' && c != '.') {
        ungetch(c); 
        return 0;
    }

    sign = (c == '-') ? -1 : 1;
    if (c == '+' || c == '-')
        c = getch();
    
    for (*pn = 0.0; isdigit(c); c = getch())
        *pn = 10.0 * *pn + (c - '0');
    
    if (c == '.')
        c = getch();
    
    for (power = 1.0; isdigit(c); c = getch()) {
        *pn = 10.0 * *pn + (c - '0');
        power *= 10.0;
    }

    *pn *= sign / power;

    if (c != EOF)
        ungetch(c);
    
    return c;
}

#define BUFSIZE 100

char buf[BUFSIZE]; 
int bufp = 0;       

int getch(void)  
{
    return (bufp > 0) ? buf[--bufp] : getchar();
}

void ungetch(int c)  
{
    if (bufp >= BUFSIZE)
        printf("Too many characters\n");
    else
        buf[bufp++] = c;
}

int main() {
    float f;

    printf("Enter a number: ");
    getfloat(&f);
    printf("Float is: %f\n", f);
      
    return 0;
}

