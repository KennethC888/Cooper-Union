///////////////////////////////////////////////////////////////////////////////
//
// Module: Counter
//
// 8-bit Counter with Load, Reset, and Enable
//
// module: COUNTER
// hdl: SystemVerilog
// Behavioral Level Modeling
//
// author: Kenneth Chan <kenc0728@gmail.com>
//
///////////////////////////////////////////////////////////////////////////////
`ifndef COUNTER
`define COUNTER

module COUNTER #(
  parameter WIDTH = 8 // Default width of 8 bits
) (
  input  logic clk,
  input  logic rst,          // Reset signal (Active High)
  input  logic enable,       // Enable counting
  input  logic load,         // Load a new value
  input  logic [WIDTH-1:0] load_value, // Value to load
  output logic [WIDTH-1:0] pc  // Program counter output
);

  // Internal counter register (explicitly initialized)
  logic [WIDTH-1:0] pc_internal = '0;  

  // Sequential Logic: Counter Operation
  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      pc_internal <= '0;  // Reset counter to 0
    end else if (load) begin
      pc_internal <= load_value;  // Load new value
    end else if (enable) begin
      pc_internal <= pc_internal + 1;  // Increment counter
    end
  end

  // Assign internal counter to output
  assign pc = pc_internal;

endmodule

`endif
