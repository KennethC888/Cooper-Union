#include <stdio.h>

int main() 
{
    char character;
  
    printf("Enter a character \n");
    character = getchar();
    
    printf("ASCII Decimal: %d\n", character);
    printf("Octal: %o\n", character);
    printf("Hexadecimal: %x\n", character);

    return 0;
}

