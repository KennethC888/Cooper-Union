//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2023
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: tb_computer
//     Description: Test bench for a single-cycle MIPS computer
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_COMPUTER
`define TB_COMPUTER

`timescale 1ns/100ps

`include "computer.sv"
`include "../clock/Clock.sv"

module computer_tb;
    logic clk = 1'b0;
    logic reset = 1'b1;
    computer dut(.clk(clk), .reset(reset));
    
    initial begin
        #15 reset = 1'b0;
        
        // Run until program completion
        #300;  // Extended simulation time
        
        // Direct memory inspection
        $display("\nTestbench Final Verification:");
        $display("DMEM[21] = %h", dut.dmem_inst.RAM[21]);
        $display("Monitor_54 = %h", dut.dmem_inst.debug_54);
        
        if (dut.dmem_inst.RAM[21] == 32'h96) begin
            $display("PASS: Value correctly stored");
            $finish;
        end
        else begin
            $display("FAIL: Incorrect value in memory");
            $finish(1);
        end
    end
    
    always #5 clk = ~clk;
endmodule

`endif
