'include "register_file.sv"
'timescale 1ns/100ps 


// {bit swizzling}
// sign extender: for 1100 to go to 8 bits, it becomes 11111100 
// Basically, if msb is 0, put more 0's in front until desired number of bits, if msb is 1, then put 1's in front until desired number of bits


// shift logical left: 1011 --> 0110, push everthing left and fill lsb with 0 (multiplies by 2^number of shifting places)

// shift logical right: 0110 --> 0011 PUSH everything right and fill the msb with a 0 (multiplies by 2^-number of shifting places)

// shift logical 

// signed number or unsigned number? Got to deal with both

//shift arithmetic need to sign extend for right, for left you dod the same as logical shift left, deals with signed numbers, can add multiples of 2 or subtract multiples of 2 




