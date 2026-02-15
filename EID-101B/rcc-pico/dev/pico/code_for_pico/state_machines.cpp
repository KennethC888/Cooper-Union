#include "rcc_stdlib.h" 
using namespace std; 

// NOTE: The pico may have unbalanced motors, so the numbers inside the parentheses from the motors class are arbitrary
// 1 2 3 4 5 order of IR SENSORS from left to right with RCC on the left and wheels facing away from me

typedef enum 
{
    WAIT,       //"0" state
    FORWARD,    // FULL STEAM AHEAD
    ROTATE_CCW, //Rotating counterclockwise on a curve, not like turning left
    ROTATE_CW,
    TURN_LEFT,
    TURN_RIGHT,
    JUNCTION, 
    SHOOT, 
    U_TURN,
    DEAD_END,
    MOVE_ONE_INCH,
    MIGHT_OF_THE_ROTATING_WIZARDS  // State Machine for when the Pico completes the course
   
} state_t; //ALL names of state machines of Pico

typedef enum
{
    DWELL,
    INTEGRATE
} integratorstate_t; //State machines to do integral of angular velocity to get angular distance "theta" 

// INT MAIN HERE
int main() 
{
    stdio_init_all();
    sleep_ms(500); 
    cyw43_arch_init(); 
    cyw43_arch_gpio_put(0,1); // turns on LED 

    rcc_init_i2c(); //setup i2c
    MPU6050 imu; //instantiate class
    imu.begin(i2c1); //adds to i2c1
    imu.calibrate(); //hold robot still

uint32_t current_time, previous_time; //cur, prev
uint32_t duration = 10000; // 1 second in US 

    //LIDAR setup 
    rcc_init_i2c(); //setup pico i2c
    VL53L0X lidar; //class 
    rcc_init_lidar(&lidar); //setup lidar

    Motor motor;
    MotorInit(&motor, RCC_ENB, RCC_ENA, 1000);
    MotorsOn(&motor);

    uint16_t dist = getFastReading(&lidar);

    rcc_init_pushbutton(); //set up button


    Left_Odom left; //class
    Right_Odom right; //class

//INITIALIZE robot's sensors and actuators here ~~~~~~~

// SINCE we have 5 IR sensors, we need to intialize all sensors, section not fully complete. 

int irsensor1 = 0; 
int irsensor2 = 1; // The IR sensor is connected to pin 1 of the PICO, these things can only go on the green pins of PICO
int irsensor3 = 2;
int irsensor4 = 3; 
int irsensor5 = 4; 

gpio_init(irsensor1);
gpio_set_dir(irsensor1, false);
gpio_init(irsensor2);
gpio_set_dir(irsensor2, false);
gpio_init(irsensor3);
gpio_set_dir(irsensor3, false);
gpio_init(irsensor4);
gpio_set_dir(irsensor4, false);
gpio_init(irsensor5);
gpio_set_dir(irsensor5, false);

float theta = 0.0; 
int desired_theta; 
int shoot_pin = 5; // Pin 5 is the shootpin for the PICO, can be changed as needed
gpio_init(shoot_pin); 
gpio_set_dir(shoot_pin, true); 

//renamne state name to something more informative

state_t robot_state = WAIT;
integratorstate_t  integrator_state = DWELL; 

while (true)
{
    imu.update_pico();
    current_time = time_us_32();  //DOES THIS GO HERE????

   /* cout << "Sensor 1: " << gpio_get(irsensor1) << "\n"; 
     cout << "Sensor 2: " << gpio_get(irsensor2) << "\n";
     cout << "Sensor 3: " << gpio_get(irsensor3) << "\n"; 
     cout << "Sensor 4: " << gpio_get(irsensor4) << "\n"; 
     cout << "Sensor 5: " << gpio_get(irsensor5) << "\n \n"; 
     sleep_ms(10);
*/
    switch(robot_state)
    {
        case WAIT:
            // do something
            MotorPower(&motor, 0, 0); // Left and Right motors are turned off

            // check transition conditions
            if (!gpio_get(RCC_PUSHBUTTON)) //BUTTON pressed
            {
                robot_state = FORWARD;
            }
            break;

        case FORWARD: 
            // do something
            cout << "FORWARD\n";
            MotorPower(&motor, -60, -70); //Numbers are arbitrary, depends on motors and battery... remember that First number is left wheel
// LEFT neg and right pos counter 
            //check transitions 

             if (gpio_get(irsensor2) == true && gpio_get(irsensor3) == true && gpio_get(irsensor4) == true && (gpio_get(irsensor1) == true || gpio_get(irsensor5) ==true))
            {
                robot_state = MIGHT_OF_THE_ROTATING_WIZARDS; 
                theta =0; 
            }
           
           
           else if (gpio_get(irsensor3) == true && gpio_get(irsensor4) == true && gpio_get(irsensor2) == true)
            {
                cout << "ENTERING JUNCTION";
                robot_state = JUNCTION; 
                theta =0; 
            }
           

    //       else if (gpio_get(irsensor3) == true && gpio_get(irsensor4) == true && gpio_get(irsensor2) == true  && dist <=100 ) //LIDAR reading is less than 100mm 
    //        {
    //          robot_state = SHOOT; 
    //        }
          
           else if (gpio_get(irsensor4) == true && gpio_get(irsensor3) == false) //Sensor 2 sees a black line
            {
                robot_state = ROTATE_CW; 
                     theta =0; 
            }

           else if (gpio_get(irsensor2) == true && gpio_get(irsensor3) == false)
            {
                robot_state = ROTATE_CCW;
                     theta =0; 
            }

  

    //        else if (gpio_get(irsensor3) == false && gpio_get(irsensor2) == false && gpio_get(irsensor1) == false && gpio_get(irsensor4) == false && gpio_get(irsensor5) == false) //TURN around condition
     //       {
     //        cout << "HIT DEAD END"; 
      //         theta = 0; 
     //        robot_state = U_TURN; 
     //       }
        
 //           else if (gpio_get(irsensor3) == true && gpio_get(irsensor2) == true)
 //           {
  //              theta = 0;
   //             robot_state = TURN_LEFT; 
    //        }

   //         else if (gpio_get(irsensor3) == true && gpio_get(irsensor4) == true)
   //         {
   //             theta = 0; 
    //            robot_state = TURN_RIGHT; 
    //        }

        break; 


        case ROTATE_CCW:   //ROTATE CCW 
        // do something
            cout << "ROTATECCW\n";
        MotorPower(&motor, 60, -60); //values could be swapped, this allows the PICO to rotate
        // check transition
        if (gpio_get(irsensor2) == false && gpio_get(irsensor3) ==true)
        {
            robot_state = FORWARD; 
        }

        break; 

        case ROTATE_CW:   //ROTATE CW 
            cout << "ROTATE CW\n";
        // do something
        MotorPower(&motor, -60, 60); //values could be swapped, this allows the PICO to rotate
        // check transition
        if (gpio_get(irsensor4) == false && gpio_get(irsensor3) == true)
        {
            robot_state = FORWARD; 
        }
        break; 

      case TURN_LEFT:
           cout << "TURNLEFT\n";
           desired_theta = 65; 
           //do something
        MotorPower(&motor, 60, -60);
        
     //   if (gpio_get(irsensor2) == false && gpio_get(irsensor3) ==true && gpio_get(irsensor4) == false)
    //    {
     //       robot_state = FORWARD; 
      //  }
        
        if (theta >= desired_theta)
        {
        robot_state = FORWARD;
   
        }
        break; 

        case TURN_RIGHT:
            cout << "TURNRIGHT\n";
        // do something
        MotorPower(&motor, -60, 60);
        //check transition
        desired_theta = 180; 
        if (theta >= desired_theta)
        {
            robot_state = FORWARD;
        }
        break; 

   /*     case SHOOT:
            cout << "SHOOT\n";
        gpio_put(shoot_pin, true);
        sleep_ms(200); //CHANGE NUMBER AS NEEDED 
        gpio_put(shoot_pin, false);

        theta = 0; //reset theta
        robot_state = U_TURN; 
        break;
  */
        case U_TURN:  //DOES NOT MATTER IF YOU GO CCW OR CW to make a UTURN
        // do something 
           // cout << "UTURN" << " theta: " << theta << "\n";
        MotorPower(&motor, 70, -70); 

        if (gpio_get(irsensor3) == true) // && (gpio_get(irsensor2) == false && gpio_get(irsensor4) == false))
        {
            robot_state = FORWARD; 
        }

        //check transition 
       // desired_theta = 180; 
       // if (theta >= desired_theta) 
       // {
      //      robot_state = FORWARD; 
      //  }
        break; 

       case DEAD_END:
            cout << "DEADEND\n";
        MotorPower(&motor, 0, 0);
        robot_state = U_TURN;
        break;
   
        case JUNCTION: 
        // do something
        MotorPower(&motor, 0, 0);

        cyw43_arch_gpio_put(0,0); 
        sleep_ms(1000); 
        cyw43_arch_gpio_put(0,1);
        sleep_ms(1000); 
        cyw43_arch_gpio_put(0,0); 
        sleep_ms(1000); 
        cyw43_arch_gpio_put(0,1); 

        robot_state = ROTATE_CCW;  //TURN LEFT
        break;

        case MIGHT_OF_THE_ROTATING_WIZARDS: 
            cout << "MIGHT\n";
        MotorPower(&motor, 0, 0);
        cyw43_arch_gpio_put(0,0); 
        sleep_ms(1000); 
        cyw43_arch_gpio_put(0,1);
        sleep_ms(3000); 
        cyw43_arch_gpio_put(0,0); 
        sleep_ms(5000); 
        cyw43_arch_gpio_put(0,1);
        sleep_ms(3000); 
        cyw43_arch_gpio_put(0,0);
        sleep_ms(1000); 
        cyw43_arch_gpio_put(0,1); 
        break;

    case MOVE_ONE_INCH:

        MotorPower(&motor, -50, -50);

        int left_count = left.getCount(); //current left count
        int right_count = right.getCount(); //current right count
    
        if (left_count>=40 && right_count>= 40 && gpio_get(irsensor2) ==true && gpio_get(irsensor3) ==true && gpio_get(irsensor4) ==true )
        
        {
            MotorPower(&motor, 0,0);
            robot_state = MIGHT_OF_THE_ROTATING_WIZARDS; 
        }
        
        else if (left_count>=40 && right_count>= 40 && gpio_get(irsensor2) ==false && gpio_get(irsensor3) ==true && gpio_get(irsensor4) ==false )
        {
            MotorPower(&motor, 0,0);
            robot_state = TURN_LEFT; 
        }
      break; 
    }

    switch(integrator_state)
    {
        case DWELL:
        if (current_time - previous_time >= duration) //THESE variables need to be defined 
        {
            integrator_state = INTEGRATE; 
        }
        break; 

        case INTEGRATE:
        // DO integration utilizing LEFT hand RIEMMAN sum 
        theta = theta + imu.getAngVelZ()*duration/1000000.0;
        //Transition condition
        if (true)
        {
            integrator_state = DWELL;
            previous_time = current_time; //Update time
        } 
        break;

    }
    }
}



