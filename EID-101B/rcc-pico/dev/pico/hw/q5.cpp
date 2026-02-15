#include <iostream>
#include <unistd.h>


   int Fibonacci( int num1, int num2)
  {

       int next_Term = num1 + num2;

       if (next_Term == 55 )
       {

std:: cout << "The 10th term of the Fibonacci sequence is " << next_Term; 
return next_Term;
       }

       else
       {

          Fibonacci(num2, next_Term);

       }

  }




int main(void)
{

Fibonacci(1,1);

return 0;
}

