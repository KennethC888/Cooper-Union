//////////////////////////////////////////////////////////////////////////////
//
// Module: two_to_one_mux
//
// 2:1 Multiplexer
//
// module: two_to_one_mux
// hdl: SystemVerilog
// modeling: Behavioral Modeling
//
// author: Berry Xu
//
///////////////////////////////////////////////////////////////////////////////
`ifndef MUX2
`define MUX2

`timescale 1ns/100ps

module mux2 #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [n-1:0] d0, d1,
    input  logic s,
    output logic [n-1:0] y
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    assign y = s ? d1 : d0;
endmodule

`endif // MUX2

