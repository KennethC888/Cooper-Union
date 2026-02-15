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

module mux2 #(parameter WIDTH=32)(
    input logic [WIDTH-1:0] d0, d1,
    input logic s,
    output logic [WIDTH-1:0] y
);
    assign y = s ? d1 : d0;
endmodule

`endif

