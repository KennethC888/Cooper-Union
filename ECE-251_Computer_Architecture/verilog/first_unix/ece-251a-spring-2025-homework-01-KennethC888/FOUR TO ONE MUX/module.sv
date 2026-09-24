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
`ifndef  FOUR_TO_ONE_MUX
`define  FOUR_TO_ONE_MUX
// DO NOT FORGET TO RENAME MODULE_NAME to match your module_name

module FOUR_TO_ONE_MUX(s0, s1, x0, x1, x2, x3, outp); 
    //
    // ---------------- DECLARATIONS OF PORT IN/OUT & DATA TYPES ----------------
    //
    input  s0, s1, x0, x1, x2, x3;  
    output outp; 

    wire s1bar, s0bar; 
    wire a, b, c, d; 

    not (s1bar,s1);
    not (s0bar,s0); 

    and (a, x0, s1bar, s0bar); 
    and (b, x1, s1bar, s0); 
    and (c, x2, s1, s0bar); 
    and (d, x3, s1, s0); 

     or (outp, a, b, c, d); 
   // assign outp = (a | b) | (c | d);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
endmodule

`endif // MODULE_NAME
