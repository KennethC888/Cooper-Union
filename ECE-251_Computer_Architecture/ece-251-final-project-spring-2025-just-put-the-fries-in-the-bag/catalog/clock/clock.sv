//////////////////////////////////////////////////////////////////////////////
//
// clock.sv
//
// module: clock
// hdl: Verilog
// modeling: Behavioral Modeling
//
// author: Berry Xu <berry.xu@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps
`ifndef CLOCK
`define CLOCK

module clock(enable, clk);
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input logic enable;
    output logic clk;
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    parameter FREQ = 100000; // In kHz where 1 = 1kHz
    parameter PHASE = 0; // Phase shift in degrees
    parameter DUTY = 50; // Duty cycle in percentage

    real clk_pd = 1.0/(FREQ * 1e3) * 1e9; //converts to ns
    real clk_on = DUTY/100.0 * clk_pd;
    real clk_off = (100.0 - DUTY)/100.0 * clk_pd;
    real quarter = clk_pd/4;
    real start_dly = (quarter) * PHASE/90;
    reg start_clk;
    
    initial begin
        clk <= 0;
        start_clk <= 0;
    end

    always @(posedge enable or negedge enable)begin
        if(enable)
            #(start_dly) start_clk = 1;
        else
            #(start_dly) start_clk = 0;
    end

    always @(posedge start_clk)begin
        if(start_clk)begin
            clk = 1;
            while(start_clk) begin
                #(clk_on) clk = 0;
                #(clk_off) clk = 1;
            end
            clk = 0;
        end
    end

endmodule

`endif // CLOCK
