#include <iostream>
#include <unistd.h>

int main(void) 
{


for (float i = 10.0; i <=1000.0; i+=10.0) 

{

std:: cout << "Hi there. The rate is " << i << " ms.\n" ; 
sleep (i/1000); 

}




return 0; 
}

