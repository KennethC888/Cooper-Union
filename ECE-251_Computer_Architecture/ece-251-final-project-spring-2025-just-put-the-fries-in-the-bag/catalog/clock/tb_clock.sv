///////////////////////////////////////////////////////////////////////////////
//
// tb_clock.sv
//
// module: tb_clock
// hdl: Verilog
//
// author: Berry Xu <berry.xu@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps
// ensure you note the scale (ns) below in $monitor

`include "./clock.sv"

module tb_clock;
    //
    // ---------------- DECLARATIONS OF DATA TYPES ----------------
    //

    //inputs are reg for test bench - or use logic
    logic ENABLE;

    //outputs are wire for test bench - or use logic
    wire CLK0, CLK1, CLK2, CLK3, CLK4, CLK5, CLK6, CLK7, CLK8, CLK9;
    //
    // ---------------- INSTANTIATE UNIT UNDER TEST (DUT) ----------------
    //
    clock dut(.enable(ENABLE), .clk(CLK0)); //Period=10ns, Phase=0 deg, Duty Cycle=50%

    //Comments are the changes to the clock signal
    clock #(.FREQ(200000)) u1(.enable(ENABLE), .clk(CLK1)); //Period = 5ns
    clock #(.FREQ(400000)) u2(.enable(ENABLE), .clk(CLK2)); //Period = 2.5ns
    clock #(.FREQ(800000)) u3(.enable(ENABLE), .clk(CLK3)); //Period = 1.25ns

    clock #(.PHASE(90)) u4(.enable(ENABLE), .clk(CLK4)); //Phase shift = +90 deg
    clock #(.PHASE(180)) u5(.enable(ENABLE), .clk(CLK5)); //Phase shift = +180 deg
    clock #(.PHASE(360)) u6(.enable(ENABLE), .clk(CLK6)); //Phase shift = +360 deg

    clock #(.DUTY(30)) u7(.enable(ENABLE), .clk(CLK7)); //Duty Cycle = 30%
    clock #(.DUTY(70)) u8(.enable(ENABLE), .clk(CLK8)); //Duty Cycle = 70%
    clock #(.DUTY(90)) u9(.enable(ENABLE), .clk(CLK9)); //Duty Cycle = 90%
   
    //
    // ---------------- INITIALIZE TEST BENCH ----------------
    //
    initial begin : initialize_variables
        ENABLE <= 0;
    end

    initial begin : dump_variables
      $dumpfile("tb_clock.vcd"); // for Makefile, make dump file same as module name
      $dumpvars(0, tb_clock, dut, u1, u2, u3, u4, u5, u6, u7, u8, u9);
    end

    /*
    * display variables
    */
    initial begin: display_variables
        $monitor ($time, "ns\tCLK0=%b,\tCLK1=%b\tCLK2=%b,\tCLK3=%b,\tCLK4=%b\tCLK5=%b,\tCLK6=%b,\tCLK7=%b\tCLK8=%b,\tCLK9=%b", CLK0, CLK1, CLK2, CLK3, CLK4, CLK5, CLK6, CLK7, CLK8, CLK9);
    end

    //
    // ---------------- APPLY INPUT VECTORS ----------------
    //
    // note: following the keyword begin is the name of the block: apply_stimulus
    initial begin : apply_stimuli
            #(50) ENABLE <= ~ENABLE;
            #(100) ENABLE <= ~ENABLE;
            #50;
        $finish;
    end

endmodule

// `endif // tb_clock
