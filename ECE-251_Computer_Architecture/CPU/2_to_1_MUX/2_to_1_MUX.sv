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
`ifndef MUX_2TO1
`define MUX_2TO1

module 2_to_1_mux #(
    parameter WIDTH = 1  // Default width of 1 bit (can be parameterized)
)(
    input wire selector,      // Select signal
    input wire [WIDTH-1:0] in0,  // Input 0
    input wire [WIDTH-1:0] in1,  // Input 1
    output wire [WIDTH-1:0] out  // Output
);

    // The multiplexer logic
    assign out = selector ? in1 : in0;

endmodule

`endif 