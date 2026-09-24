#include <stdio.h>
#include <limits.h>

int main()
{
    printf("CHAR_MIN: %d\n", CHAR_MIN);
    printf("CHAR_MAX: %d\n", CHAR_MAX);
    printf("SIGNED CHAR_MIN: %d\n", SCHAR_MIN);
    printf("SIGNED CHAR_MAX: %d\n", SCHAR_MAX);
    printf("UNSIGNED CHAR_MAX: %d\n", UCHAR_MAX);
    printf("SHRT_MIN: %d\n", SHRT_MIN);
    printf("SHRT_MAX: %d\n", SHRT_MAX);
    printf("UNSIGNED SHRT_MAX: %d\n", USHRT_MAX);
    printf("INT_MIN: %d\n", INT_MIN);
    printf("INT_MAX: %d\n", INT_MAX);
    printf("UINT_MAX: %d\n", UINT_MAX);
    printf("LONG_INT_MIN: %ld\n", LONG_MIN);
    printf("LONG_INT_MAX: %ld\n", LONG_MAX);
    printf("ULONG_INT_MAX: %ld\n", ULONG_MAX);
    printf("ULONG_LONG_INT_MAX: %llu\n", ULLONG_MAX);

    return 0;
}
