//////////////////////////////////////////////////////////////////////////////
//
// Module: 2 to 1 mux
//
// 2 to 1 mux
//
// module: 2 to 1 mux
// hdl: SystemVerilog
// modeling: Behavior Level Modeling
//
// author: Kenneth Chan <kenc0728@gmail.com>
//
///////////////////////////////////////////////////////////////////////////////
`ifndef Shift_Left_2
`define Shift_Left_2

module Shift_Left_2 #(parameter WIDTH=32)(
    input logic [WIDTH-1:0] in,
    output logic [WIDTH-1:0] out
);
    assign out = {in[WIDTH-3:0], 2'b00}; // More reliable than <<
endmodule

`endif
