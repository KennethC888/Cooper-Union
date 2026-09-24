//////////////////////////////////////////////////////////////////////////////
//
// Module: Register
//
// Register
//
// module: Register
// hdl: SystemVerilog
// modeling: Behavior Level Modeling
//
// author: Kenneth Chan <kenc0278@gmail.com>
//
///////////////////////////////////////////////////////////////////////////////
`ifndef REGISTER
`define REGISTER
`include "Dff.sv"

module REGISTER #(
  parameter WIDTH = 8 // Default width of 8 bits
) (
  input logic clock,
  input logic reset,
  input logic enable,
  input logic [WIDTH-1:0] d, // Data input, parameterized width
  output logic [WIDTH-1:0] q // Data output, parameterized width
);

  // Array of D flip-flops to form the register
  wire [WIDTH-1:0] q_internal; // Internal storage for the register

  genvar i;
  generate
    for (i = 0; i < WIDTH; i++) begin : flip_flops
      DFF flip_flop_inst (
        .clock(clock),
        .reset(reset),
        .enable(enable),
        .d(d),      // Connecting individual bits of d
        .q(q_internal) // Connecting individual bits of q_internal
      );
    end
  endgenerate

  assign q = q_internal; // Assign the internal storage to the output

endmodule
`endif