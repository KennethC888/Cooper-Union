///////////////////////////////////////////////////////////////////////////////
//
// tb_signext.sv
//
// module: tb_signext
// hdl: Verilog
//
// author: Berry Xu <berry.xu@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/10ps

`ifndef SIGNEXT
`define SIGNEXT

module signext #(parameter IN_WIDTH=16, OUT_WIDTH=32)(
    input logic [IN_WIDTH-1:0] A,
    output logic [OUT_WIDTH-1:0] Y
);
    assign Y = {{(OUT_WIDTH-IN_WIDTH){A[IN_WIDTH-1]}}, A};
endmodule

`endif