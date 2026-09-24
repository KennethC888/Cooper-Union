//////////////////////////////////////////////////////////////////////////////
//
// Module: module_name
//
// 4:1 Multiplexer
//
// module: module_name
// hdl: SystemVerilog
// modeling: Gate Level Modeling
//
// author: Prof. Rob Marano <rob@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////
`ifndef  FOUR_BIT_ADDER
`define  FOUR_BIT_ADDER
// DO NOT FORGET TO RENAME MODULE_NAME to match your module_name

module FOUR_BIT_ADDER(x0, x1, x2, x3, x4, x5, x6, x7, o1, o2, o3, o4, carry); 
    
 //   ---------------- DECLARATIONS OF PORT IN/OUT & DATA TYPES ----------------

    input  x0, x1, x2, x3, x4, x5, x6, x7;  
    output o1, o2, o3, o4, carry; 

    wire a, b, c, d, e, f, g, h, i, j, k, l; 

    xor (o1, x0, x1); 
    and (a, x0, x1);
    xor (b, x2, x3);
    and (c, a, b); 
    and (d, x2, x3); 
    xor (o2, a, b); 
    or (e, c, d); 
    xor (f, x4, x5);
    xor (o3, e, f);
    and (h, x4, x5);
    and (g, f, e);  
    or (i, g, h); 
    xor (j, x6, x7); 
    and (l, x6, x7); 
    xor (o4, i, j);
    and (k, i, j); 
    or (carry, k, l);
    
    //---------------- MODULE DESIGN IMPLEMENTATION ----------------
    
endmodule

`endif // MODULE_NAME