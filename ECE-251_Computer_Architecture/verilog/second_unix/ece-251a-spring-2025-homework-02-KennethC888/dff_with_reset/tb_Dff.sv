///////////////////////////////////////////////////////////////////////////////
//
// Module: Testbench for D Flip-Flop module
//
// Testbench for D Flip-Flop
//
// module: D Flip-FLop
// hdl: SystemVerilog
//
// author: Kenneth Chan <kenc0728@gmail.com>
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`include "Dff.sv"

module tb_DFF;
    // Define the bit length for the testbench (default is 8 bits)
    parameter n = 8; // Can be changed to any value

    reg clock;
    reg reset;
    reg enable;
    reg [n -1:0] d;

    // Output
    wire [n -1:0] q;

    // Instantiate the n-bit full adder with the parameterized bit length
     DFF #(n) dut (
       .clock(clock),
       .reset(reset),
       .enable(enable),
       .d(d),
       .q(q)
    );

    // Inputs
   

      initial begin : dump_variables
        $dumpfile("tb_DFF.vcd"); // for Makefile, make dump file same as module name
       $dumpvars(0, dut);
   end

    // Clock generation
    initial begin
        clock = 0;
        forever #5 clock = ~clock; // Toggle clock every 5 time units
    end

    // Test procedure
    initial begin
        // Initialize inputs
        reset = 1;
        enable = 0;
        d = 8'b0;
        #10; // Wait for 10 nanoseconds 

        // Release reset
        reset = 0;
        #10;

        // Test case 1: Enable = 0, D = 8'b10101010 (output should not change)
        enable = 0;
        d = 8'b10101010;
        #10;
        $display("Test 1: Enable = %b, D = %b, Q = %b", enable, d, q);

        // Test case 2: Enable = 1, D = 8'b10101010 (output should change to 8'b10101010)
        enable = 1;
        d = 8'b10101010;
        #10;
        $display("Test 2: Enable = %b, D = %b, Q = %b", enable, d, q);

        // Test case 3: Enable = 1, D = 8'b11110000 (output should change to 8'b11110000)
        enable = 1;
        d = 8'b11110000;
        #10;
        $display("Test 3: Enable = %b, D = %b, Q = %b", enable, d, q);

        // Test case 4: Reset = 1 (output should reset to 8'b00000000)
        reset = 1;
        #10;
        $display("Test 4: Reset = %b, Q = %b", reset, q);

        // Test case 5: Reset = 0, Enable = 1, D = 8'b01010101 (output should change to 8'b01010101)
        reset = 0;
        enable = 1;
        d = 8'b01010101;
        #10;
        $display("Test 5: Enable = %b, D = %b, Q = %b", enable, d, q);

        // End simulation
        $finish;   
    end


endmodule

