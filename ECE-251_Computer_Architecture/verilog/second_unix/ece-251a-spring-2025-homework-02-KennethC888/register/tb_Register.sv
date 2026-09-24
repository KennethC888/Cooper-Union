///////////////////////////////////////////////////////////////////////////////
//
// Module: Testbench for Register
//
// Testbench for Register
//
// module: Register
// hdl: SystemVerilog
//
// author: Kenneth Chan <kenc0728@gmail.com>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps
`include "Register.sv"
`include "Dff.sv"

// Testbench for the parameterized register
module tb_REGISTER;
  parameter n = 8; 
  logic clock;
  logic reset;
  logic enable;
  logic [7:0] d; // 8-bit data for default instantiation
  logic [7:0] q;

  // Instantiating the register with the default width (8 bits)
  REGISTER #(n) dut ( //reg8
    .clock(clock),
    .reset(reset),
    .enable(enable),
    .d(d),
    .q(q)
  );


  // // Instantiating the register with a different width (16 bits)
  // logic [15:0] d16;
  // logic [15:0] q16;
  // REGISTER #( .WIDTH(16) ) reg16 ( // Parameter override
  //   .clk(clk),
  //   .rst(rst),
  //   .enable(enable),
  //   .d(d16),
  //   .q(q16)
  // );

      initial begin : dump_variables
        $dumpfile("tb_REGISTER.vcd"); // for Makefile, make dump file same as module name
       $dumpvars(0, dut);
   end

  // Clock generation
  initial begin
    clock = 0;
    forever #5 clock = ~clock;
  end

  // Test sequence
  initial begin
    reset = 1;
    enable = 0;
    d = 8'hAA; // Example data for 8-bit register
   // d16 = 16'hBEEF; // Example data for 16-bit register

    #10 reset = 0;  // Release reset
    enable = 1;

    #10 d = 8'h55; // Change data for 8-bit register
   // #10 d16 = 16'hDEAD; // Change data for 16-bit register

    #10 enable = 0; // Disable

    #10 enable = 1; // Enable again

    #10 $display("8-bit Register q: %h", q); // Should be 55
   // #10 $display("16-bit Register q16: %h", q16); // Should be DEAD

    $finish;
  end

endmodule
