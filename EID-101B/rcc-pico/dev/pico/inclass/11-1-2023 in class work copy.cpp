#include "rcc_stdlib.h"
using namespace std;

int main()
{   
    stdio_init_all();
    sleep_ms(100);
    cyw43_arch_init(); //setup 
    cyw43_arch_gpio_put(0, 1); //turns on led
    rcc_init_potentiometer(); // Initializes the potentiometer 
    
// MAYBE LINE SENSORS COULD BE USED FOR THIS
 
int state = 0; 
int val; 

    while(true)
    { 

    val = adc_read(); 

// State 0, 0 <= val <= 1300 

    if (state ==0)
    {
    // Task 
    cout << "s0\n"; // in state 0 


    if (val >= 1301 && val <= 2600) // Go from state 0 to state 1
    {
        state ==1; 
    }

    if (val >= 2601) // Go from state 0 to state 2, although the potentiometer always has to go to state 1 before state 2 because of how it works
    {
        state == 2; 
    }

    }


// State 1, 1301 <= val <= 2600 

    if (state ==1 )

    {
    // Task 
    cout << "s1\n"; 

    //Transition condition
    if (val <= 1300 && val>= 0) // Go from state 1 to state 0
    {
        state == 0; 
    }

    if (val >= 2601) // Go from state 1 to state 2, 
    {
        state == 2; 
    }
        
    
    }


// State 2, val >2600 

    if (state ==2)
    {
    cout << "s2\n"; 


    if (val >= 1301 && val <= 2600) // Go from state 2 to state 1
    {
        state == 1; 
    }

    if (val >= 0 && val <= 1300) // Go from state 2 to state 0
    {
        state == 0; 
    }

    }

    
    
    
    
    }

}