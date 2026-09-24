## Question 7

Write a pointer version of strncmp(). The following is the documentation from K&R pg. 249:

```int strncmp(cs, ct, n)``` - compare at most n characters of string ```cs``` to string ```ct```; return <0 if cs<ct, 0 if cs==ct, or >0 if cs>ct.  

This is the function prototype:  
```
int strncmp(char *cs, char *ct, int n);
```

Write a main that accepts input strings cs, ct, and the number of characters to compare, s.  

For example:  
```strncmp("ABCF", "ABCDEF", 3)``` returns 0  
```strncmp("ABAC", "ABCDEF", 3)``` returns -2  
```strncmp("ABDC", "ABCDEF", 3)``` returns 1  
  

Compile Steps:
```
gcc q7.c
./a.out
```
Output:
```
Enter string cs:
Enter string ct:
Enter n:
```
