///////////////////////////////////////////////////////////////////////////////
//
// Module: Testbench for Clock
//
// Testbench for Clock
//
// module: Clock
// hdl: SystemVerilog
//
// author: Kenneth Chan <kenc0728@gmail.com>
//
///////////////////////////////////////////////////////////////////////////////
`ifndef TB_CLOCK
`define TB_CLOCK

`timescale 1ns/100ps
`include "Clock.sv"

module tb_clock;
    wire clk;
    logic enable;

   initial begin
        $dumpfile("clock.vcd");
        $dumpvars(0, uut);
        //$monitor("enable = %b clk = %b", enable, clk);
        $monitor("time=%0t \t enable=%b clk=%b",$realtime, enable, clk);
    end

    initial begin
        enable <= 0;
        #10 enable <= 1;
        #100 enable <= 0;
        $finish;
    end

   CLOCK uut(
        .ENABLE(enable),
        .CLOCK(clk)
    );
endmodule

`endif // TB_CLOCK