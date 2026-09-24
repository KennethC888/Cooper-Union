/* 


// 5 parts of comp arch: Input, Output, CPU, Memory, and Data Paths

// RISC has fixed instruction size, COMP ARCH is based on RISC 

// 32 bit processor can do arithimetic with 32 bits 

//

// CISC is 


// 128 instructions needs 7 bits (log base 2 of 128 is 7)

// Kernel has access to CPU 
// Userspace, where you run your programs 

// Input --> Memory --> Data Path to CPU --> Data Path to Memory --> Output 

// Types of compact 

// von Neuman (Princeton Architecture) v.s. Harvard Architecture
// Princeton is general purpose vs Harvard which is application specific (GPU) or (Digital Signal Processor, vector processor)
// 
//Can store up to 2^32 -1 in memory, 4GB of memory 
// WOrd addressable --> unity of +1, 4 Giga words, 4 GB  
// Byte addressable --> unity of +4 

// 2^30 -1 

//Constant is called immediate 



// Use Mips green card 
// Big Endian vs Little Endian 

// Simplicity favors regularity, smaller is faster, make the common case fast, good design demands good compromises  


// 2/18/2025 
// 32 bit processor/CPU, size of operands in bits 
// int a = (null) 
// -(2^(n-1)) < x < 2^(n-1) -1 

// 

/*
int a = null; 
int b = 3; 
int c = null; 
c = a +b; 
we can add, subtract, modulus, bitting, divide, multiply... 

Input and Output are memory mapped functions 

Stored program concept --> programs and Data can be represetned as binary in memory, contains data or code 
memory is based on bytes, each "row" is a byte, so 4 groups of 2 per row, 

Simplicity favors regularity --> register files in CPU, 
instructions are fixed size (size is based on n bit processor)
m bits times m bits gives you 2m bits Example: 15 (4 bits) times 15 (4 bits) is 225 (8 bits)


addi $s2, $s1, -1
^^ There are 3 arguments and 1 constant 

op takes 6 bits, so 2^6 = 64 bits of instruction 
shamt --> shift logical left or right; sll will multiply by base of 2, rsl will divide by base of 2 (shift sll 5 bits will multiply value by 32)
op code goes before function 

R type, op rs rt rd shamt funct (6 bits, 5, 5, 5, 5, 6 respectively), has 3 registers
I type, op rs rt constant or address (6 bits, 5, 5, 16 respectively)

Scenario, let's say you are at 1024, then the range up and down you can go from 1024 is plus or minus 2^15 
Signed numbers don't have as much range as unsigned numbers, so you got to do something about that. 
Need 32 bit range, 

branches --> test, then go
j --> GO 

Heap grows up, stack grows down 


2/25

FOR THE EXAM:
Lots of chapter 2, some verilog here and there, c code and making assembly languague and vice versa 
Design principles, 5 parts of Comp Arch 
Von neuman, harvard architecture


32 bit, length of operand 
Recall: Big ENdian is msb goes to lowest address, little endian is lsb goes to lowest address 
MIPS is usually big endian 

LOL 4087 (decimal) to hex is FF7 

label is like a memory address/relative address
linking makes absolute address 
extern makes address available to the program, becomes staticdata, $gp --> 1000 8000  

data section 

text section 
.globl main (making a main)
sign extension, 2's complement for addi? 

16'b0 is upper 16 bits and putting all 0's behind them. 
Example: 40001 --> 40001 (and then 16 zeros behind it)

3/4/2025 STUDY THESE TOPICS 


Definition of computer architecture
Princeton vs Harvard
Store program concept 
5 parts of a modern computer
types of computers (CISC and RISC) (Complex instruction set computer vs reduced instruction set)



Verilog 
Signed v.s. unsigned numbers 
catalog of modules
register (Cascaded D flip flops)
register file 
clock
ALU
DFF 
Adder 
carry 
... 


ISA design
4 design principles
Simplicity favors regularity, smaller is faster, make the common case fast, good design demands good compromises  


MIPS ISA
bit width (32 bit CPU)
 - operand width 
Memory layout
 byte addressable 
 each instruction is 32 bits (1 word) wide
Big Endian v.s. Little Endian
Registers (fast memory, closest to ALU) 
Instructions 
types: R, I, J
opcodes
operands 
32 bit



Memory Addresses
Reading Mips (byte addressable) (RISC) instructions 



Assembly Language Programming 
syscall (kernal call for a simple OS on MIPS (QtSPIM, Mars))
Purpose of an assembler --> takes assembly code and converts to machine code, 
Each line of assembly code represents an instruction, 32-bits in our MIPS case
instructions 
data types (word, half word, byte)
add r1, r2, r3, they are all signed, based on MIPS sheet 
addi the immediate is 16 bits wide, signed, says signextimm (range is -2^15 to 2^15-1 to account for 0)
procedures 
 leaf 
 nested 
  recursive 




Reserved --> The program, 
Text --> Contains code 
static data --> global variables
Stack --> Running the program
Dynamic Data -->
2^32 bytes in memory allocation, there is more memory above stack and dynamic data, 



Exam Review over! 

Other notes: 


3/11/2025 NOTES (not on Mid term)

This will create an overflow 

Recall that immediates can only take 16 bits. 




3/18/2025 WEEK 9 
Floating point: 
1.xyz 
x is 2^-1, y is 2^-2, z is 2^-3 
single precision, use 127 for bias, double, bias is 1203 or is it 1023?

Smallest value for single precision is 

Largest 

Other 

Single precision: 6 decimal points of precision, double precision, 16 decimal digits of precision 

Represent -0.75 
S = 1 (negative means S is 1)
-0.75 = (-1)^1 * 1.1 (base2) * 2^-1. 
Fraction = 10000...00 base 2
Single: -1 + 127 = 126 = 01111110 base 2 

1 10000001 0100...00 
S = 1
Fraction = 0100...00
Exponent = 10000001 base 2 = 129 
x = (-1)^1 * (1 + .01) base 2 * (2^(129-127)) 
x = (-1) * (1.25) * 4 
Note that 0.01 is 2^-2 = 0.25
= -5 

01000000011000000000000000000000
S = 0; positive number
exponent: 10000000 which is 128 
fraction: 11000000000000000000000 which is 
1 * (1 + 1/2 + 1/4) * 2^(128-127)
14/4 = 3.5

FP Adder Hardware
Compare exponents, shift smaller number right, add, normalize, round, normalize again if needed

Notes from readings: 
For every instruction, 
Send the program counter (PC) to the memory that contains the code
and fetch the instruction from that memory.
2. Read one or two registers, using fields of the instruction to select the
registers to read. For the load word instruction, we need to read
only one register, but most other instructions require reading two
registers.

State Element is memory element (like memory or register)
Combinatorial Element is an operational element (like AND or ALU)

Asserted is like high/true
deasserted is like low/false

program counter (PC)
The register containing the address of the instruction in the program
being executed. 

Two state elements are needed to
store and access instructions, and an adder is
needed to compute the next instruction
address.

Instruction memory only reads, so it is combinatinal logic

register file
A state element that consists of a set of registers that can be read and
written by supplying a register number to be accessed.

1. The instruction is fetched, and the PC is incremented.
2. Two registers, $t2 and $t3, are read from the register file; also, the
main control unit computes the setting of the control lines during
this step.
3. The ALU operates on the data read from the register file, using the
function code (bits 5:0, which is the funct field, of the instruction)
to generate the ALU function.
4. The result from the ALU is written into the register file using bits
15:11 of the instruction to select the destination register ($t1)

Single cycle bad: 
However, if we tried to implement the floating point unit or an instruction set with more complex instructions, this single cycle
design wouldn’t work well at all.
Violates make common case fast. 
Also, some instructions take like 5 cycles, that's way too long to process, so single cycle implementation bad.



3/25/2025
CPU --> computations, memory stores 

abc = b mod m all are integers
General purpose computer vs application specific computer (dishwasher,)

CPU: Control unit, there are registers, ALU and GPR's in there
program comes in from input (compiles and links to OS), goes to memory and goes to cpu, goes in gpr (general purpose register) 
PC = PC + 4 (byte addressable), PC is a register (32 bits)

Mealy (output based on current input and state) vs Moore (output based on current state)

imem --> instruction memory 
dmem --> data memory

4/1/25
Instructions come from memory 
Address to get instruction --> the program counter 
Single cycle would be the longest instruction possible 
Read on positive edge, write on negative edge (pipelining)


Notes on 4/29/2025 
CHAPTER 5 presentation 

What's on the homework is pretty much on the exam (not cumulative) take home exam! LETS GOOO 
Memory --> RAM (fastest) --> Virtual Memory (Disc)
Internet has a data center which has racks which has computers

Memory hierachy, as you go up closer to CPU, it goes faster (CPU is fast)
Cache levels is closest to CPU, then RAM, then VMEM, then HDD 
Temporal (close in time) vs Spatial Locality (close in memory) --> Likely to be accessed again soon (instructions in a loop) vs likely to be accessed soon
(instructions in sequential, array)

copy and paste and move up the hierachy
For 32 bit CPU, need the disk to be at least 2^32 (4 GB about ish) disc space, need at least 4GB of RAM
Always looks 1 level down if you don't have my memory address at this level 

The hierachy 
Cache
DRAM 
HDD 
.
. 
. 
Disc 

Not in cache, go to DRAM, if not in DRAM, then it must be in HDD (if it isn't in any of them, BSOD --> Blue Screen of Death)
BSOD --> You tried to access illegal memory 
Viruses --> intercept running programs, inject their instructions to run instead of what the program is supposed to do,
needs user to click on something to get their instructions to run... 

Memory Hierachy is not controlled by the CPU 

Cache hit --> found it! Hit ratio: hit/ number of processes
Miss --> Did not find it, had to go 1 level lower, time taken is a miss penalty, miss ratio: misses/accesses = 1 - hit ratio


Hierchy 
SRAM 
DRAM 
Virtual Memory = Magnetic Disc = Solid State Disc 

DRAM --> Must have same specs as Motherboard 
Row Buffer 
Synchronous DRAM --> 
DRAM banking 


Flash Storage --> 

Cache Memory has L1, L2, L3 (L1 is closest to CPU, fastest one) 

Direct Mapped Cache 
Based on last 3 bits of address (cache block)

Dirty block, uploaded stuff to a block, CPU did nothing to it, now it's dirty

Write miss 
3 potential responses to a write miss: 
Write through --> fetch the block or 
Write around: don't fetch the block
Write-back --> usually fetch the block 

Notes from reading chapter 4.6 -4.8 
Forwarding --> 
This means that when an instruction
tries to use a register in its EX stage that an earlier instruction
intends to write in its WB stage, we actually need the values as
inputs to the ALU.

Hazard detection, 

structural hazard
When a planned instruction cannot execute in the proper clock cycle
because the hardware does not support the combination of
instructions that are set to execute






FLOATING POINT (BIT PATTERN as hex), design single cycle or pipeline using controller values, 
Pipelining with fowards and hazards (examples, solutions, etc:), caching (direct map, fully associative ,or n-way associative)
 






*/