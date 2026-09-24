//////////////////////////////////////////////////////////////////////////////
//
// Module: D FLip-Flop
//
// D FLip-Flop
//
// module: D FLip-Flop
// hdl: SystemVerilog
// modeling: Behavioral Level Modeling
//
// author: Kenneth Chan <kenc0728@gmail.com>
//
///////////////////////////////////////////////////////////////////////////////
`ifndef DFF
`define DFF

module DFF #(
    parameter WIDTH = 8
)
(
    input wire clock,      // Clock signal
    input wire reset,      // Asynchronous reset (active high)
    input wire enable,     // Enable signal
    input wire [WIDTH-1:0] d,    // 8-bit data input
    output reg [WIDTH-1:0] q     // 8-bit data output
);

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            q <= 8'b0;      // Reset the output to 0
        end else if (enable) begin
            q <= d;         // Update the output with the input data
        end
    end

endmodule
`endif // CLOCK