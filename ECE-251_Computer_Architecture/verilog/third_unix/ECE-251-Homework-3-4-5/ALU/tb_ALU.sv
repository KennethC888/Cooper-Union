///////////////////////////////////////////////////////////////////////////////
//
// Module: Testbench for ALU
//
// Testbench for ALU
//
// module: ALU
// hdl: SystemVerilog
//
// author: Kenneth Chan <kenc0728@gmail.com>
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps
`include "ALU.sv"

module tb_ALU;
    // ---------------- DECLARATIONS OF DATA TYPES ----------------
    parameter WIDTH = 32;
    reg [WIDTH-1:0] a; // Input operand A
    reg [WIDTH-1:0] b; // Input operand B
    reg [3:0] operation; // Operation selection
    wire [WIDTH-1:0] result;   // Output result
    wire carry_out;      // Output carry_out

    // ---------------- INSTANTIATE THE ALU MODULE ----------------
    ALU dut (
        .result(result),
        .carry_out(carry_out),
        .a(a),
        .b(b),
        .operation(operation)
    );

    // ---------------- INITIALIZE TEST BENCH ----------------
    initial begin : initialize_variables
        a = 32'b00110011; // Initialize operand A
        b = 32'b11001100; // Initialize operand B
        operation = 4'b0000;     // Initialize operation (addition)
    end

    // ---------------- DUMP VARIABLES FOR WAVEFORM VIEWING ----------------
    initial begin : dump_variables
        $dumpfile("tb_ALU.vcd"); // Create a VCD file for waveform viewing
        $dumpvars(0, tb_ALU);    // Dump all variables in the testbench
    end

    // ---------------- MONITOR OUTPUTS ----------------
    initial begin
        $monitor("Time: %0t | operand_a=%b | operand_b=%b | operation=%b | result=%b | carry_out=%b",
                 $time, a, b, operation, result, carry_out);
    end

    // ---------------- APPLY RANDOM STIMULUS ----------------
    initial begin : apply_stimulus
        #1000; // Run the simulation for 1000 time units
        $finish; // End the simulation
    end

    // Generate random inputs every 10 time units
    always begin
        #10; // Wait for 10 time units
        a = $random; // Randomize operand A
        b = $random; // Randomize operand B
        operation = $random; // Randomize operation
    end
endmodule

