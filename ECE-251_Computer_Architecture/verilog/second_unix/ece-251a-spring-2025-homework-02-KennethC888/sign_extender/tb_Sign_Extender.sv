
///////////////////////////////////////////////////////////////////////////////
//
// Module: Testbench for Sign Extender
//
// Testbench for Sign Extender 
//
// module: Sign Extender
// hdl: SystemVerilog
//
// author: Kenneth Chan <kenc0728@gmail.com>
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps
`include "Sign_Extender.sv"

module tb_SIGN_EXTENDER;

  // Test signals
  logic [7:0] in;   // 8-bit input
  logic [31:0] out; // 32-bit output
  parameter input_width = 8; 
  parameter output_width = 32;


  initial begin : dump_variables
    $dumpfile("tb_Sign_Extender.vcd"); // for Makefile, make dump file same as module name
    $dumpvars(0, dut);
  end

  // Instantiate the sign extender for 8-bit to 32-bit
  SIGN_EXTENDER #(
    .IN_WIDTH(input_width),   // Input width = 8 bits
    .OUT_WIDTH(output_width)  // Output width = 32 bits
  ) dut (
    .in(in),
    .out(out)
  );

  initial begin
    // Test cases for 8-bit to 32-bit sign extension
    in = 8'h7F; // Positive number (MSB = 0)
    #10;
    $display("8-bit input: %h, 32-bit output: %h", in, out); // Expected: 0000007F

    in = 8'h80; // Negative number (MSB = 1)
    #10;
    $display("8-bit input: %h, 32-bit output: %h", in, out); // Expected: FFFFFF80

    in = 8'h00; // Zero
    #10;
    $display("8-bit input: %h, 32-bit output: %h", in, out); // Expected: 00000000

    in = 8'hFF; // -1
    #10;
    $display("8-bit input: %h, 32-bit output: %h", in, out); // Expected: FFFFFFFF

    $finish;
  end

endmodule