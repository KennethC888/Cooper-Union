## Question 2

(K&R Exercise 2-3) Write the function htoi(s), which converts a string of hexadecimal digits (including an optional 0x or 0X) into its equivalent integer value. The allowable digits are 0 through 9, a through f, and A through F.  

Write a main function that accepts an input using either getchar or scanf. These inputs should be the string s, which will be passed to the htoi(s) function. Print out the resulting integer.

Compile Steps:
```
gcc q2.c -o q2 -lm
./q2
```
Output:
```
(The output is for 0xA4)
164
```
