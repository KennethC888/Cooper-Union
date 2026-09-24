//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2023
// Engineer: Prof Rob Marano
// 
// Create Date: 2023-02-07
// Module Name: cpu
// Description: 32-bit RISC-based CPU (MIPS)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef CPU
`define CPU

`timescale 1ns/100ps

`include "../Controller/Controller.sv"
`include "../Datapath/Datapath.sv"


module cpu #(parameter n = 32)(
    input  logic           clk, reset,
    output logic [(n-1):0] pc,
    input  logic [(n-1):0] instr,
    output logic           memwrite,
    output logic [(n-1):0] aluout, writedata,
    input  logic [(n-1):0] readdata
);
    logic memtoreg, alusrc, regdst, regwrite, jump, pcsrc;
    logic [2:0] alucontrol;
    logic zero;
    logic [31:0] hi, lo;

    CONTROLLER c(
        .op(instr[31:26]),
        .funct(instr[5:0]),
        .zero(zero),
        .memtoreg(memtoreg),
        .memwrite(memwrite),
        .pcsrc(pcsrc),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .alucontrol(alucontrol)
    );

    datapath dp(
        .clk(clk),
        .reset(reset),
        .memtoreg(memtoreg),
        .pcsrc(pcsrc),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .alucontrol(alucontrol),
        .pc(pc),
        .instr(instr),
        .aluout(aluout),
        .writedata(writedata),
        .readdata(readdata),
        .hi(hi),
        .lo(lo)
    );

    assign zero = (aluout == 0);

    // Enhanced debugging
    always @(posedge clk) begin
        $display("CPU: PC=%h INSTR=%h ALUOUT=%h $2=%h $3=%h HI=%h LO=%h", 
                pc, instr, aluout, dp.regfile[2], dp.regfile[3], hi, lo);
        
        if (pc > 32'h00000020) begin
            $display("Final DMEM[54] = %h", readdata);
            $finish;
        end
    end
endmodule
`endif
