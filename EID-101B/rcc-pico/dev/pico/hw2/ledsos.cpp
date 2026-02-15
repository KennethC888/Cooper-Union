#include "rcc_stdlib.h" //includes all libraries​

using namespace std; //use standard library​


int main()
{ 
    stdio_init_all(); //setup pico hardware​

    sleep_ms(100); //wait for setup to finish​

    cyw43_arch_init(); //setup wifi chip​
    
    cyw43_arch_gpio_put(0,1); //turn on led​


    while(true){
        for (int i = 0; i<3; i++)
        {
            cyw43_arch_gpio_put(0,1); 
            sleep_ms(100); 
            cyw43_arch_gpio_put(0,0);
            sleep_ms(100); 
        }

    
        for (int i = 0; i<3; i++)
                {
                    cyw43_arch_gpio_put(0,1); 
                    sleep_ms(1000); 
                    cyw43_arch_gpio_put(0,0);
                    sleep_ms(1000); 
                  
                }

        for (int i = 0; i<3; i++)
                {
                    cyw43_arch_gpio_put(0,1); 
                    sleep_ms(100); 
                    cyw43_arch_gpio_put(0,0);
                    sleep_ms(100); 
                }
    }
}
