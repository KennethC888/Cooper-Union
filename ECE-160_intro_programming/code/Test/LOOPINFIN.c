#include <stdio.h>

int main()
{
    int i = 2147483647;
    
    while (i >= 0)
    {
        printf("This is an infinite loop! (or is it?) i=%d\n", i);
        i++;
    }
    return 0;
}
