///////////////////////////////////////////////////////////////////////////////
//
// tb_register_file.sv
//
// module: tb_register_file
// hdl: Verilog
//
// author: Berry Xu <berry.xu@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/10ps
// ensure you note the scale (ns) below in $monitor

`include "./register_file.sv"
`include "../clock/clock.sv"

module tb_register_file;
    //
    // ---------------- DECLARATIONS OF DATA TYPES ----------------
    //

    //inputs are reg for test bench - or use logic

    parameter WIDTH = 32;
    parameter ADDR_WIDTH = 5;
    logic enable;
    logic clk, rst, we;
    logic [ADDR_WIDTH-1:0] wa, ra1, ra2;
    logic [WIDTH-1:0] wd;
    
    //outputs are wire for test bench - or use logic
    wire [WIDTH-1:0] rd1, rd2;
    
    //
    // ---------------- INSTANTIATE UNIT UNDER TEST (DUT) ----------------
    //
    clock uut1(.enable(enable), .clk(clk));
    register_file dut(.clk(clk), .rst(rst), .we(we), .ra1(ra1), .ra2(ra2), .wa(wa), .wd(wd), .rd1(rd1), .rd2(rd2));
    //
    // ---------------- INITIALIZE TEST BENCH ----------------
    //
    initial begin : initialize_variables
        {enable, rst, wa, ra1, ra2, we, wd} <= 0;
    end

    initial begin : dump_variables
      $dumpfile("tb_register_file.vcd"); // for Makefile, make dump file same as module name
      $dumpvars(0, dut);
    end

    /*
    * display variables
    */
    initial begin: display_variables
        $monitor ($time, "ns\tclk=%b,rst=%b,enable=%b,wa=%h,wd=%h,we=%b,ra1=%h,rd1=%h,ra2=%h,rd2=%h", clk, rst, enable, wa, wd, we, ra1, rd1, ra2, rd2);
    end

    //
    // ---------------- APPLY INPUT VECTORS ----------------
    //
    // note: following the keyword begin is the name of the block: apply_stimulus

    initial begin : apply_stimuli
        #5 rst = 1;
        #5 enable = 1;
        #10;
        #5 rst = 0;
        #5 we = 1;
        #5 wa = 2;
        #5 wd = $random;
        #20 we = 0;

        #5 ra1 = 2;
        #20;

        #5 we = 1;
        #5 wa = 3;
        #5 wd = $random;
        #20 we = 0;

        #5 ra2 = 3;
        #20;

        #5 rst = 1;
        #20;
        #5 rst = 0;
        #5 enable = 0;
        #50;

        $finish;
    end

endmodule

// `endif // tb_register_file
