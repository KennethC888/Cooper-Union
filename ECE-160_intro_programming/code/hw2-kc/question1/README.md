## Question 1
Write a program to determine the ranges of char, short, int, and long variables, both signed and unsigned, by printing appropriate values from standard headers. Also, determine the ranges of the various floating-point types. (K&R Exercise 2-1)

Be sure to use the appropriate printf % letter to print the correct values out.

Compilation Steps:  
```
gcc q1.c
./a.out
```
Output:
```
CHAR_MIN: -128
CHAR_MAX: 127
SIGNED CHAR_MIN: -128
SIGNED CHAR_MAX: 127
UNSIGNED CHAR_MAX: 255
SHRT_MIN: -32768
SHRT_MAX: 32767
UNSIGNED SHRT_MAX: 65535
INT_MIN: -2147483648
INT_MAX: 2147483647
UINT_MAX: -1
LONG_INT_MIN: -9223372036854775808
LONG_INT_MAX: 9223372036854775807
ULONG_INT_MAX: -1
ULONG_LONG_INT_MAX: 18446744073709551615
```
