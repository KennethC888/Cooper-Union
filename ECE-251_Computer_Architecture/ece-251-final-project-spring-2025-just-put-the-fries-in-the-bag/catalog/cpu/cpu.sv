`ifndef CPU
`define CPU

`timescale 1ns/1ps

`include "../controller/controller.sv"
`include "../datapath/datapath.sv"

module cpu #(parameter n = 32)(
    input  logic           clk, reset,
    output logic [(n-1):0] pc,
    input  logic [(n-1):0] instr,
    output logic           memwrite,
    output logic [(n-1):0] aluout, writedata,
    input  logic [(n-1):0] readdata
);
    logic       memtoreg, alusrc, regdst, regwrite, jump, pcsrc, zero;
    logic [2:0] alucontrol;
    
    controller c(instr[(31):26], instr[5:0], zero,
                    memtoreg, memwrite, pcsrc,
                    alusrc, regdst, regwrite, jump,
                    alucontrol);

    datapath dp(clk, reset, memtoreg, pcsrc,
                    alusrc, regdst, regwrite, jump,
                    alucontrol,
                    zero, pc, instr,
                    aluout, writedata, readdata);
endmodule

`endif // CPU
