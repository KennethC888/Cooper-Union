//////////////////////////////////////////////////////////////////////////////
//
// Module: Sign Extender
//
// Sign Extender
//
// module: Sign Extender
// hdl: SystemVerilog
// modeling: Behavior Level Modeling
//
// author: Kenneth Chan <kenc0278@gmail.com>
//
///////////////////////////////////////////////////////////////////////////////
`ifndef SIGN_EXTENDER
`define SIGN_EXTENDER

module SIGN_EXTENDER #(
  parameter IN_WIDTH = 8, // Input width (default 16 bits)
  parameter OUT_WIDTH = 32 // Output width (default 32 bits)
) (
  input logic [IN_WIDTH-1:0] in,
  output logic [OUT_WIDTH-1:0] out
);

  assign out = {{(OUT_WIDTH-IN_WIDTH){in[IN_WIDTH-1]}}, in};

endmodule


`endif // Sign Extender