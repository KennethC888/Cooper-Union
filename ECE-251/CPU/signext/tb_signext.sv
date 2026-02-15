///////////////////////////////////////////////////////////////////////////////
//
// tb_signext.sv
//
// module: tb_signext
// hdl: Verilog
//
// author: Berry Xu <berry.xu@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps
// ensure you note the scale (ns) below in $monitor

module tb_signext;
    //
    // ---------------- DECLARATIONS OF DATA TYPES ----------------
    //

    //inputs are reg for test bench - or use logic
    parameter IN = 16;
    parameter OUT = 32;
    reg [IN-1:0] a; 
    
    //outputs are wire for test bench - or use logic
    wire [OUT-1:0] y;
    
    //
    // ---------------- INSTANTIATE UNIT UNDER TEST (DUT) ----------------
    //

    signext dut(.A(a), .Y(y));
    //
    // ---------------- INITIALIZE TEST BENCH ----------------
    //
    initial begin : initialize_variables
        {a} <= 0;
    end

    initial begin : dump_variables
      $dumpfile("tb_signext.vcd"); // for Makefile, make dump file same as module name
      $dumpvars(0, dut);
    end

    /*
    * display variables
    */
    initial begin: display_variables
        $monitor ($time, "ns\ta=%b,\ty=%b", a, y);
    end

    //
    // ---------------- APPLY INPUT VECTORS ----------------
    //
    // note: following the keyword begin is the name of the block: apply_stimulus

    initial begin : apply_stimuli
        #15 a = 16'h8A01;
	      #100;
	      $finish;
    end

endmodule

// `endif // tb_signext