///////////////////////////////////////////////////////////////////////////////
//
// Module: FullAdder
//
// n-bit Full Adder using Behavioral Modeling
//
// module: FullAdder
// hdl: SystemVerilog
// modeling: Behavioral Modeling
//
// author: Kenneth Chan <kenc0728@gmail.com
//
///////////////////////////////////////////////////////////////////////////////
`ifndef FULL_ADDER
`define FULL_ADDER

module FULL_ADDER #(
  parameter WIDTH = 32 // Default width of 32 bits
) (
  input logic [WIDTH-1:0] A, // Input A
  input logic [WIDTH-1:0] B, // Input B
  input logic Cin,           // Carry input
  output logic [WIDTH-1:0] Sum, // Sum output
  output logic Cout          // Carry output
);

  // Behavioral modeling for the n-bit full adder
  always_comb begin
    {Cout, Sum} = A + B + Cin; // Perform addition with carry
  end

endmodule
`endif