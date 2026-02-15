///////////////////////////////////////////////////////////////////////////////
//
// Module: Testbench for ALU Decoder
//
// Testbench for ALU Decoder
//
// module: ALU Decoder
// hdl: SystemVerilog
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps
`include "aludec.sv"

module aludec_tb;

    reg [5:0] funct;
    reg [1:0] aluop;
    wire [3:0] alucontrol; //3

    aludec dut (
        .funct(funct),
        .aluop(aluop),
        .alucontrol(alucontrol)
    );

    initial begin

        // R - mult
        aluop = 2'b11; funct = 6'b011000;
        #1 $display("MUL: aluop = %b, funct = %b -> alucontrol = %b", aluop, funct, alucontrol);

        // R-type: div
        funct = 6'b011010;
        #1 $display("DIV: aluop = %b, funct = %b -> alucontrol = %b", aluop, funct, alucontrol);

        // R-type: add
        funct = 6'b100000;
        #1 $display("ADD: aluop = %b, funct = %b -> alucontrol = %b", aluop, funct, alucontrol);

        // I-type: aluop = 2'b00 
        aluop = 2'b00; funct = 6'bxxxxxx;
        #1 $display("I-type ADD: aluop = %b -> alucontrol = %b", aluop, alucontrol);

        $finish;
    end

endmodule
