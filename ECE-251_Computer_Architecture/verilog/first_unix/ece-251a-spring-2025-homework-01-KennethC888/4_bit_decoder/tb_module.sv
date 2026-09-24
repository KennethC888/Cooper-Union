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

module tb_FOUR_BIT_DECODER;
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
        $dumpfile("tb_FOUR_BIT_DECODER.vcd"); // for Makefile, make dump file same as module name
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
   
   logic a, b, c, d; 
   wire q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15;

   initial begin
         $monitor("a = %b, b = %b, c = %b, d = %b, q15 = %b, q14 = %b, q13 = %b, q12 = %b, q11 = %b, q10 = %b, q9 = %b, q8 = %b, q7 = %b, q6 = %b, q5 = %b, q4 = %b, q3 = %b,  q2= %b, q1 = %b, q0 = %b", a, b, c, d, q15, q14, q13, q12, q11, q10, q9, q8, q7, q6, q5, q4, q3, q2, q1, q0); 
    end 

   initial begin


       for (int i = 0; i<2; i++) begin
            for(int j = 0; j <2; j++) begin
                for (int k = 0; k < 2; k++) begin
                    for (int l = 0; l < 2; l++) begin
                                      a = i; 
                                      b = j; 
                                      c = k;
                                      d = l;                                      
                                        #5; 
                                    end 
                                end 
                            end 
                        end 
   end 

    FOUR_BIT_DECODER dut(
         .a(a), .b(b), .c(c), .d(d), .q15(q15), .q14(q14), .q13(q13), .q12(q12), .q11(q11), .q10(q10), .q9(q9), .q8(q8), .q7(q7), .q6(q6), .q5(q5), .q4(q4), .q3(q3), .q2(q2), .q1(q1), .q0(q0)
        );

endmodule