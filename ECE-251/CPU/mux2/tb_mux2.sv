///////////////////////////////////////////////////////////////////////////////
//
// tb_mux2.sv
//
// module: tb_mux2
// hdl: Verilog
//
// author: Berry Xu <berry.xu@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps
// ensure you note the scale (ns) below in $monitor

`include "./mux2.sv"
`include "../clock/Clock.sv"

module tb_mux2;
    //
    // ---------------- DECLARATIONS OF DATA TYPES ----------------
    //
    parameter n = 32;

    // Inputs
    logic ENABLE;
    logic CLK;
    logic [n-1:0] D0, D1;
    logic S;
    
    // Outputs
    wire [n-1:0] Y;
    
    //
    // ---------------- INSTANTIATE UNIT UNDER TEST (DUT) ----------------
    //
    CLOCK uut1(.ENABLE(ENABLE), .CLOCK(CLK)); // ✅ Correct port names
    mux2 dut(.d0(D0), .d1(D1), .s(S), .y(Y));
    
    //
    // ---------------- INITIALIZE TEST BENCH ----------------
    //
    initial begin : initialize_variables
        {D0, D1, S, ENABLE} <= 0;
    end

    initial begin : dump_variables
        $dumpfile("tb_mux2.vcd"); // for Makefile, make dump file same as module name
        $dumpvars(0, dut);
        $dumpvars(0, uut1); // Also dump clock waveform
    end

    /*
    * display variables
    */
    initial begin: display_variables
        $monitor ("%0t ns\tClock=%b\tD0=%h\tD1=%h\tS=%b\tEnable=%b\tY=%h", 
                   $time, CLK, D0, D1, S, ENABLE, Y);
    end

    //
    // ---------------- APPLY INPUT VECTORS ----------------
    //
    initial begin : apply_stimuli
        #5 ENABLE = 1;                    // Start the clock early
        #5 D0 = 32'h10101010;
        #10 D1 = 32'h00000001;
        #10 D0 = 32'h00110011;
        #10 D1 = 32'h10000001;
        #10 S = 0;                        // Select D0
        #10 S = 1;                        // Select D1
        #100 ENABLE = 0;                  // Stop the clock
        $finish;
    end

endmodule
