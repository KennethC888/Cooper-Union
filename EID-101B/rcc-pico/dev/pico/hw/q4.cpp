#include <iostream>
#include <unistd.h>


int main(void)
{

int n = 5; 
int total=1; 

for (int i = n; i >= 1; i--)
{

 total = i * total; 

 

} 

  std:: cout << n << " factorial is " << total; 







	return 0;
}
