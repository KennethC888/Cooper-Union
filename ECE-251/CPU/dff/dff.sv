///////////////////////////////////////////////////////////////////////////////
//
// dff.sv
//
// module: d-flip-flop
// hdl: Verilog
// modeling: Behavioral Modeling
//
// author: Berry Xu <berry.xu@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps
`ifndef DFF
`define DFF

module dff #(parameter WIDTH=32) (
    input logic clk,         // Clock
    input logic rst,         // Async reset (active high)
    input logic enable,      // Sync enable
    input logic [WIDTH-1:0] d,
    output logic [WIDTH-1:0] q
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst) q <= 0;
        else if (enable) q <= d;
    end
endmodule

`endif