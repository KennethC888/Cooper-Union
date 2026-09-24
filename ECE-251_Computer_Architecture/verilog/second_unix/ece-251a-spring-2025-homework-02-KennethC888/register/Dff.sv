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
// DO NOT FORGET TO RENAME MODULE_NAME to match your module_name

module DFF #(
    parameter WIDTH = 8
)
(
    input logic clock,      // Clock signal
    input logic reset,      // Asynchronous reset (active high)
    input logic enable,     // Enable signal
    input logic [WIDTH-1:0] d,    // 8-bit data input
    output logic [WIDTH-1:0] q     // 8-bit data output
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