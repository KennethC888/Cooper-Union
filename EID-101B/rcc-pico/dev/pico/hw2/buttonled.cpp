#include "rcc_stdlib.h"
using namespace std;


struct mystruct{
    int val1;
    int val2;
    int anotherval;
    double anotheragainval;
};

void some_func(struct mystruct* s)
{
    s->val1 += 1;
    return;
}

int main()
{

    rcc_init_pushbutton();
    // {
    //         gpio_init(RCC_PUSHBUTTON); 
    //         gpio_pull_up(RCC_PUSHBUTTON); 
    //         gpio_set_dir(RCC_PUSHBUTTON, false); 
    //     }

    stdio_init_all();    
    sleep_ms(1500);
    cyw43_arch_init();
    cyw43_arch_gpio_put(0,1); //turns on LED

    rcc_init_pushbutton(); //set up button

    struct mystruct mystructInstance;
    mystructInstance.val1 = 10;
    // mystructInstance.val2=20;
    struct mystruct anotherStructInstance;

    while(true)
    {   

    cout <<"val1 before func: " <<mystructInstance.val1 << '\n';
    some_func(&mystructInstance);

    cout <<"val1 after func: " <<mystructInstance.val1 << '\n';
    cout <<"val1 after func: " <<mystructInstance.val2 << '\n';



        // if(!gpio_get(RCC_PUSHBUTTON)) //if NOT gpio (if gpio is low)
        // {


            int state = cyw43_arch_gpio_get(0); 
            //do stuff here when button pressed
            // cout << "PUSHBUTTON PRESSED!\n"; 
            cout << "LED is: " << state << '\n';
        // }
    }

 
}