///////////////////////////////////////////////////////////////////////////////
//
// Module: Testbench for module module
//
// Testbench for MODULE_NAME
//
// module: tb_module
// hdl: SystemVerilog
//
// author: Prof. Rob Marano <rob@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`include "module.sv"

module tb_FOUR_TO_ONE_MUX;
    //
    // ---------------- DECLARATIONS OF DATA TYPES ----------------
    //
    //inputs are reg for test bench - or use logic

    //outputs are wire for test bench - or use logic

    //
    // ---------------- INITIALIZE TEST BENCH ----------------
    //
    initial begin : initialize_variables
    end

    initial begin
        //$monitor ($time,"ns, select:s=%b, inputs:d=%b, output:z1=%b", S, D, Z1);
    end

    initial begin : dump_variables
        $dumpfile("tb_FOUR_TO_ONE_MUX.vcd"); // for Makefile, make dump file same as module name
        $dumpvars(0, dut);
    end

    /*
    * display variables
    */
//    initial begin: display_variables
        // note: currently only simple signals or constant expressions may be passed to $monitor.
//        $monitor ("X1-X2-X4-X4 = %b, Z1 = %b", {X1,X2,X3,X4}, Z1);
//    end

    //
    // ---------------- APPLY INPUT VECTORS ----------------
    //
    // note: following the keyword begin is the name of the block: apply_stimulus
    // initial begin : apply_stimuli
    // #0  S = 2'b00; // S[0]=1'b0; S[1]=1'b0;
    //     D = 4'b1010; // D[0]=1'b0; D[1]=1'b1; D[2]=1'b0; D[3]=1'b1;
    //     EN = 1'b1; // EN=1'b1;
    // #10 S = 2'b00; // S[0]=1'b0; S[1]=1'b0;
    //     D = 4'b1011; // D[0]=1'b1; D[1]=1'b1; D[2]=1'b0; D[3]=1'b1;
    //     EN = 1'b1; // EN=1'b1;
    // #10 S = 2'b01; // S[0]=1'b1; S[1]=1'b0;
    //     D = 4'b1011; // D[0]=1'b1; D[1]=1'b1; D[2]=1'b0; D[3]=1'b1;
    //     EN = 1'b1; // EN=1'b1;
    // #10 S = 2'b10; // S[0]=1'b0; S[1]=1'b0;
    //     D = 4'b1011; // D[0]=1'b1; D[1]=1'b1; D[2]=1'b0; D[3]=1'b1;
    //     EN = 1'b1; // EN=1'b1;
    // #10 S = 2'b01; // S[0]=1'b1; S[1]=1'b0;
    //     D = 4'b1001; // D[0]=1'b1; D[1]=1'b1; D[2]=1'b0; D[3]=1'b1;
    //     EN = 1'b1; // EN=1'b1;
    // #10 S = 2'b11; // S[0]=1'b1; S[1]=1'b0;
    //     D = 4'b1011; // D[0]=1'b1; D[1]=1'b1; D[2]=1'b0; D[3]=1'b1;
    //     EN = 1'b1; // EN=1'b1;
    // #10 S = 2'b11; // S[0]=1'b1; S[1]=1'b0;
    //     D = 4'b0011; // D[0]=1'b1; D[1]=1'b1; D[2]=1'b0; D[3]=1'b1;
    //     EN = 1'b1; // EN=1'b1;
    // #10 S = 2'b11; // S[0]=1'b1; S[1]=1'b0;
    //     D = 4'b0011; // D[0]=1'b1; D[1]=1'b1; D[2]=1'b0; D[3]=1'b1;
    //     EN = 1'b0; // EN=1'b1;
    // #10 $finish;
    // end
    //$finish;
    // note: do not need $finish, since the simulation runs for the set increments and ends.

    //
    // ---------------- INSTANTIATE UNIT UNDER TEST (UUT) ----------------
    //


    logic  s0, s1, x0, x1, x2, x3; 
    wire outp; 

    initial begin
        $monitor("s0 = %b, s1 = %b, x0 = %b, x1 = %b, x2 = %b, x3 = %b, outp = %b", s0, s1, x0, x1, x2, x3, outp); 
    end 

    initial begin
        s0 = 0; 
        s1 = 0; 
        x0 = 0; 
        x1 = 0; 
        x2 = 0; 
        x3 = 0; 
        for (int i = 0; i<2; i++) begin
            for(int j = 0; j <2; j++) begin
                for (int k = 0; k<2; k++) begin
                    for (int l = 0; l<2; l++) begin
                        for(int m = 0; m<2; m++) begin
                            for(int n = 0; n<2; n++) begin
                                s0 = i; s1 = j; x0 = k; x1 = l; x2 = m; x3 = n; #5; 
                            end 
                        end 
                    end 
                end 
            end
        end
    end 

    // module FOUR_TO_ONE_MUX; 
    FOUR_TO_ONE_MUX dut(
        .s0(s0), .s1(s1), .x0(x0), .x1(x1), .x2(x2), .x3(x3), .outp(outp)
        );

endmodule