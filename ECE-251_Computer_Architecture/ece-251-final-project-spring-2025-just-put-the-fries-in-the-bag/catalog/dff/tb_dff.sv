`ifndef TB_DFF
`define TB_DFF

`timescale 1ns/1ps
`include "dff.sv"
`include "../clock/clock.sv"

module tb_dff;
    parameter n = 32; // #bits for an operand
    wire clk;
    logic enable;
    logic reset;
    logic [n-1:0] d;
    logic [n-1:0] q;

   initial begin
        $dumpfile("dff.vcd");
        $dumpvars(0, uut0, uut1);
        $monitor("time=%0t \t d=%h q=%h",$realtime, d, q);
    end

    initial begin
        d <= #n'h8000;
        enable <= 0;
        #10 enable <= 1;
        #10 reset <= 1;
        #20 d <= #n'h0001;
        #10 reset <= 0;
        #10 reset <=0;
        #20 d <= #n'h0001;
        #100 enable <= 0;
        $finish;        
    end

    dff uut0(
        .clk(clk), .rst(reset), .d(d), .q(q)
    );

   clock uut1(
        .enable(enable),
        .clk(clk)
    );
endmodule
`endif // TB_DFF
