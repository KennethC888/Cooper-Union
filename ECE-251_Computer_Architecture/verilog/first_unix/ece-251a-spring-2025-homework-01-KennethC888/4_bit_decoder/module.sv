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
`ifndef FOUR_BIT_DECODER
`define FOUR_BIT_DECODER
// DO NOT FORGET TO RENAME MODULE_NAME to match your module_name

module FOUR_BIT_DECODER(a, b, c, d, q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15
 );
    //
    // ---------------- DECLARATIONS OF PORT IN/OUT & DATA TYPES ----------------
    //
    input  a, b, c, d; 
    output q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15; 

    assign q0 = ~a & ~b & ~c & ~d; 
    assign q1 = d & ~a & ~b & ~c; 
    assign q2 = c & ~a & ~b & ~d;
    assign q3 = (c & d) & ~a & ~b; 
    assign q4 = b & ~a & ~c & ~d; 
    assign q5 = (b & d) & ~a & ~c; 
    assign q6 = (b & c) & ~a & ~d; 
    assign q7 = (b & c & d) & ~(a); 
    assign q8 = a & ~b & ~c & ~d; 
    assign q9 = (a & d) & ~b & ~c; 
    assign q10 = (a & c) & ~b & ~d; 
    assign q11 = (a & c & d) & ~(b);
    assign q12 = (a & b) & ~c & ~d; 
    assign q13 = (a & b & d) & ~(c);
    assign q14 = (a & c & b) & ~(d);
    assign q15 = (a & b & c & d); 
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //

endmodule

`endif // MODULE_NAME