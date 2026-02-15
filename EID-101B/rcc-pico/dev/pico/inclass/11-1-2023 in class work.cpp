#include "rcc_stdlib.h"
using namespace std;

int main()
{   
    stdio_init_all();
    sleep_ms(100);
    cyw43_arch_init(); //setup 
    cyw43_arch_gpio_put(0, 1); //turns on led


int state = 0; 
uint32_t current_time, previous_time; //cur, prev
uint32_t duration = 1000000; // 1 second in US  

    while(true)
    {   // Get current time into ms
        current_time = time_us_32; 

       // State 0 (Dwell state)
        if (state == 0)
        {
            //DO THE THING FOR THE STATE 0
            // DO NOTHING

            // Transition conditions
            if (current_time-previous_time >= duration)
            {
                    state = 1; 
            }
        }

       // State 1 
        if (state == 1)
        {
            // DO THE THING FOR STATE 1

            cout << "In state 1\n"; 
                     
            // Transition condition
            if (true)
            {      
                state = 0; 
                previous_time = current_time; 
            }
        }
    }
}