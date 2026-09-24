`ifndef CONTROLLER
`define CONTROLLER

`timescale 1ns/1ps

`include "../maindec/maindec.sv"
`include "../aludec/aludec.sv"

module controller #(parameter n = 32)(
    input  logic [5:0] op, funct,
    input  logic       zero,
    output logic       memtoreg, memwrite,
    output logic       pcsrc, alusrc,
    output logic       regdst, regwrite,
    output logic       jump,
    output logic [2:0] alucontrol
);
    logic [1:0] aluop;
    logic       branch;
    
    // CPU main decoder
    maindec md(op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, aluop);
    // CPU's ALU decoder
    aludec  ad(funct, aluop, alucontrol);

  assign pcsrc = branch & zero;

endmodule

`endif // CONTROLLER
