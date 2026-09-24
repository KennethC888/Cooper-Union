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
`include "../clock/clock.sv"

module tb_mux2;
    //
    // ---------------- DECLARATIONS OF DATA TYPES ----------------
    //
    parameter n = 32;
    //inputs are reg for test bench - or use logic
    logic ENABLE;
    logic CLK;
    logic [n-1:0] D0, D1;
    logic S;
    
    //outputs are wire for test bench - or use logic
    wire [n-1:0] Y;
    
    //
    // ---------------- INSTANTIATE UNIT UNDER TEST (DUT) ----------------
    //
    clock uut1(.enable(ENABLE), .clk(CLK));
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
    end

    /*
    * display variables
    */
    initial begin: display_variables
        $monitor ($time, "ns\tClock=%b,d0=%h,d1=%h,s=%b,enable=%b,y=%h", CLK, D0, D1, S, ENABLE, Y);
    end

    //
    // ---------------- APPLY INPUT VECTORS ----------------
    //
    // note: following the keyword begin is the name of the block: apply_stimulus

    initial begin : apply_stimuli
        #10 D0 = 32'h10101010;
        #10 D1 = 32'h00000001;
        ENABLE = 1;
        #10 D0 = 32'h00110011;
        #10 D1 = 32'h10000001;
        #10 S = 0;
        #10 S = 1;
        #100 ENABLE = 0;
        $finish;
    end

endmodule

// `endif // tb_mux2
