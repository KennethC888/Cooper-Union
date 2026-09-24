# Question 3

Using the point struct that we used in class, write a program that will compute 11 points of a quadratic curve in the form of ax^2+bx+c from -5 to 5. Prompt the user to input values for a, b, and c. Store these points in a struct array and print the points.

Have the main accept a, b, and c (which are whole numbers to make things easier) using argc and argv.

Compile Steps:
```
gcc q3.c
./a.out 1 2 3
```
Output:
```
point 1 on the curve is (-5, 18)
point 2 on the curve is (-4, 11)
point 3 on the curve is (-3, 6)
point 4 on the curve is (-2, 3)
point 5 on the curve is (-1, 2)
point 6 on the curve is (0, 3)
point 7 on the curve is (1, 6)
point 8 on the curve is (2, 11)
point 9 on the curve is (3, 18)
point 10 on the curve is (4, 27)
point 11 on the curve is (5, 38)
```
