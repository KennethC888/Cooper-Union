## Question 4

(K&R Exercise 3-5) Write the function itob(n,s,b) that converts the integer n into a base b character representation in the string s. In particular, itob(n,s,16) formats n as a hexadecimal integer in s. Use capital characters for numbers greater than 9 (e.g. 10 = A).  

Write a main function that accepts inputs using either getchar or scanf. These inputs should be n and b, which will then be passed into your itob function. Print out the resulting value of s.    

Compile Steps:
```
gcc q4.c
./a.out
```
Output:
```
(For input 200 base 16)
C8
```
