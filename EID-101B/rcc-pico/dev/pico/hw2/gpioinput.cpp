#include "rcc_stdlib.h" //includes all libraries​

using namespace std; //use standard library​


int main() {



#define GPIO_IN 3
gpio_init(GPIO_IN); gpio_set_dir(GPIO_IN, false); 


    stdio_init_all(); //setup pico hardware​

    sleep_ms(100); //wait for setup to finish​

    cyw43_arch_init(); //setup wifi chip​

    cyw43_arch_gpio_put(0,1); //turn on led​


    while(true)
    {


    if (gpio_get(GPIO_IN))
    {
        cout<< "gpio on\n";
    }

    else 
     {
        cout << "gpio off\n";
     }

    } 

     return 0; 
}
 


    

