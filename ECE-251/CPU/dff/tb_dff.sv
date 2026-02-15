///////////////////////////////////////////////////////////////////////////////
// Testbench for dff (D Flip-Flop)
//
// Author: Berry Xu <berry.xu@cooper.edu>
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps
`include "dff.sv"  // Ensure correct path to your dff.sv file

module tb_dff;
    //
    // ---------------- DECLARATIONS OF DATA TYPES ----------------
    //

    // Inputs for testbench - logic type is fine for this use case
    logic [31:0] D;    // 32-bit input data
    logic CLK, ENABLE, RST;  // 1-bit control signals
    
    // Outputs are wire types in the testbench
    wire [31:0] Q;     // 32-bit output data
    
    //
    // ---------------- INSTANTIATE UNIT UNDER TEST (DUT) ----------------
    //
    dff dut (
        .d(D),         // Connect the 32-bit data input
        .clk(CLK),     // Connect the clock signal
        .rst(RST),     // Connect the reset signal
        .enable(ENABLE), // Connect the enable signal
        .q(Q)          // Connect the 32-bit output
    );

    //
    // ---------------- INITIALIZE TEST BENCH ----------------
    //
    initial begin
        {D, CLK, ENABLE, RST} <= 0;
    end

    // Initialize waveform dumping for waveform viewing
    initial begin
        $dumpfile("tb_dff.vcd");
        $dumpvars(0, dut);
    end

    // Display variables for monitoring
    initial begin
        $monitor ($time, "ns\tClock=%b, Reset=%b, Enable=%b, D=%h, Q=%h", CLK, RST, ENABLE, D, Q);
    end

    //
    // ---------------- APPLY INPUT VECTORS ----------------
    //
    // Clock signal generation
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;  // Clock period is 10ns
    end

    // Apply stimuli (test cases)
    initial begin
        // Apply reset and input values to test the DFF behavior
        #10 RST = 1;  // Apply reset
        #10 RST = 0;  // Release reset
        
        // Test with ENABLE = 1
        ENABLE = 1;
        D = 32'hAAAAAAAA;  // Set D to a 32-bit value
        #10;               // Wait for 10ns
        D = 32'h55555555;  // Change D to a different 32-bit value
        #10;

        // Test with ENABLE = 0 (DFF should retain value)
        ENABLE = 0;
        D = 32'h12345678;  // Set D again, but since ENABLE is 0, Q should not change
        #10;

        // Test again with ENABLE = 1
        ENABLE = 1;
        D = 32'h87654321;  // Set D to another value
        #10;

        $finish;
    end

endmodule
