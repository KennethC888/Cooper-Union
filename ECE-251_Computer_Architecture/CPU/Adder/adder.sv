///////////////////////////////////////////////////////////////////////////////
//
// Module: Adder
//
// n-bit Full Adder using Behavioral Modeling
//
// module: FullAdder
// hdl: SystemVerilog
// modeling: Behavioral Modeling
///////////////////////////////////////////////////////////////////////////////
`ifndef ADDER
`define ADDER

module adder #(
  parameter WIDTH = 32 // Default width of 32 bits
) (
  input logic [WIDTH-1:0] A, // Input A
  input logic [WIDTH-1:0] B, // Input B
  output logic [WIDTH-1:0] Sum // Sum output
);
  
  // Perform addition 
  assign Sum = A + B;

endmodule
`endif