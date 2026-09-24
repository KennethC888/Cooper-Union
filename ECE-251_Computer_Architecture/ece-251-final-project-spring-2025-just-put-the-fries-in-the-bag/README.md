# 32-Bit CPU 
Implemented a 32-Bit Mips based, single cycle CPU <br/>
The CPU reads instructions from an input file, computes and exectues them <br/>

# CPU Diagram 
Designed CPU based on "Computer Organization and Design MIPS Edition" 6th edition by David A. Patterson and John L. Hennessy
![image](https://github.com/user-attachments/assets/57fa6306-8808-46ae-b08a-9d2d53a3b9cb)

# ISA 
| ISA Specs | Implementation |
| --- | --- |
| Address Bus Size | 32 bits |
| Instruction Length  | 32 bits |
| PC Increment | 4 bytes |
| Full Word Size | 32 bits |

# CPU design <br/> 
We implemented the CPU using the following components: <br/>
## Adder <br/>
Adds inputs and returns the output 
## ALU <br/>
Performs several operations between inputs such as add, subtract, multiply, divide, or, and 
## ALU Decoder <br/>
Decodes instructions to determine what ALU operation to perform, for R-type, increments by PC + 4, for J-type, it would jump in relative to PC (no exact value), for branch, it would theoretically jump to the label (but no labels in MIPS coding) 
## Clock <br/>
Changes from high to low every "picosecond" 
## Computer <br/>
Connects the CPU, IMEM, DMEM together to execute instructions 
## Controller <br/>
Manages and directs the flow of data between two entities
## CPU <br/>
Computes and exectues instructions 
## Datapath <br/>
Allows communication between the input and output of instructions 
## D Flip-Flop <br/>
Stores data every edge triggered clock stage 
## DMEM <br/>
Data Memory, reads and writes memory where data is stored and changed through the execution of instructions
## IMEM <br/>
Instruction Memory, read-only memory containing the set of instructions to be executed
## Main Decoder <br/>
Looks through the opcode to determine the instruction type (R, I, J)
## 2:1 MUX <br/>
Chooses one signal from two inputs and transmits it to the output
## Register File <br/>
Contains registers that stores data during computations 
## Sign Extender <br/>
If the first bit is 0, then all 0's will be placed in front of the first bit unitl desired number of bits (in this case 32) <br/>
If the first bit is 1, then all 1's will be placed in front of the first bit until desired number of bits (in this case 32) <br/>
## Shift Left Logical 2 bits <br/>
Places two 0's behind the last bit, effectively multiplying the value by 4

# Steps to compile and simulate CPU <br/>
1. Go to the computer directory
2. Make a file called program_exe (hex code) and a program.asm (MIPS code)
3. Enter this command: make COMPONENT=computer
4. Enter this command: make simulate COMPONENT=computer
5. If you have QTspim, enter this command: make display COMPONENT=computer




# Link to video: <br/>


