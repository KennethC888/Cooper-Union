//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2023
// Kenneth Chan, code inspired by Prof. Marano
// 
//     Create Date: 2023-02-07
//     Module Name: computer
//     Description: 32-bit RISC
//
// 
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef COMPUTER
`define COMPUTER

`timescale 1ns/100ps

`include "../cpu/cpu.sv"
`include "../IMEM/IMEM.sv"
`include "../DMEM/DMEM.sv"

module computer (
    input logic clk, reset
);
    logic [31:0] pc, instr, readdata, aluout, writedata;
    logic memwrite;

    cpu c(
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instr(instr),
        .memwrite(memwrite),
        .aluout(aluout),
        .writedata(writedata),
        .readdata(readdata)
    );

    IMEM imem_inst(
        .addr(pc[7:2]),     // Word-aligned addressing
        .readdata(instr)
    );

    DMEM dmem_inst(
        .clk(clk),
        .write_enable(memwrite),
        .addr(aluout),
        .writedata(writedata),
        .readdata(readdata)
    );

    // Debug monitoring
    always @(posedge clk) begin
        $display("CYCL=%0t PC=%8h INSTR=%8h ALUOUT=%8h DATA=%8h", 
                $time, pc, instr, aluout, writedata);
        if (memwrite) 
            $display("  MEM[%h] <= %h", aluout, writedata);
    end
endmodule
`endif // COMPUTER
