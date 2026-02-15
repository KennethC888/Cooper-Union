#include "rcc_stdlib.h"
using namespace std;



typedef enum{    //STRUCTS
LEFT,          // State 0
MIDDLE,        // State 1
RIGHT          // State 2

}sm1_t; 


typedef enum {
    DWELL,
    EXEC
}sm2_t;



int main()
{   
    stdio_init_all();
    sleep_ms(100);
    cyw43_arch_init(); //setup 
    cyw43_arch_gpio_put(0, 1); //turns on led


sm1_t state1 = LEFT; //State machine 1
sm2_t state2 = DWELL; //State machine 2 
int val; 
uint32_t current_time, previous_time; //cur, prev
uint32_t duration = 1000000; // 1 second in US  

    while(true)
    {   // Get current time into ms

    //Update sensor readings and timing vars
        current_time = time_us_32; 
        val = adc_read(); 

        //----------------------------------------------------------------------------------------------------------------------
       // State 0 (Dwell state)
        if (state1 == DWELL)
        {
            //DO THE THING FOR THE STATE 0
            // DO NOTHING

            // Transition conditions
            if (current_time - previous_time >= duration)
            {
                    state1 = EXEC; 
            }
        }

       // State 1 
        if (state1 == EXEC)
        {
            // DO THE THING FOR STATE 1

            cout << "In state 1\n"; 
            cyw43_arch_gpio_put(0, !cyw43_arch_gpio_get(0));     
            // Transition condition
            if (true)
            {      
                state1 = DWELL; 
                previous_time = current_time; 
            }
        }



//---------------------------------------------------------------------------------------------------------------------------------


    if (state2 == LEFT)
    {
    // Task 
    cout << "s0\n"; // in state 0 


    if (val >= 1301 && val <= 2600) // Go from state 0 to state 1
    {
        state2 == MIDDLE; 
    }

    if (val >= 2601) // Go from state 0 to state 2, although the potentiometer always has to go to state 1 before state 2 because of how it works
    {
        state2 == RIGHT; 
    }

    }


// State 1, 1301 <= val <= 2600 

    if (state2 == MIDDLE )

    {
    // Task 
    cout << "s1\n"; 

    //Transition condition
    if (val <= 1300 && val>= 0) // Go from state 1 to state 0
    {
        state2 == LEFT; 
    }

    if (val >= 2601) // Go from state 1 to state 2, 
    {
        state2 == RIGHT; 
    }
        
    
    }


// State 2, val >2600 

    if (state2 == RIGHT)
    {
    cout << "s2\n"; 


    if (val >= 1301 && val <= 2600) // Go from state 2 to state 1
    {
        state2 == MIDDLE; 
    }

    if (val >= 0 && val <= 1300) // Go from state 2 to state 0
    {
        state2 == LEFT; 
    }

    }

    
    
    


    }
}