#include "rcc_stdlib.h" //includes all libraries​

using namespace std; //use standard library​


int main()
{ 
    stdio_init_all(); //setup pico hardware​

    sleep_ms(100); //wait for setup to finish​

    cyw43_arch_init(); //setup wifi chip​

    cyw43_arch_gpio_put(0,1); //turn on led​


    while(true){}
}
