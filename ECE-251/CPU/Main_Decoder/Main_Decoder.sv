//////////////////////////////////////////////////////////////////////////////
//
// Module: Main Decoder
//
// Main Decoder
//
// module: Main Decoder
// hdl: SystemVerilog
// modeling: Behavior Level Modeling
//
// author: Kenneth Chan <kenc0728@gmail.com> 
// Code inspired by Prof. Marano
//
///////////////////////////////////////////////////////////////////////////////
`ifndef MAINDEC
`define MAINDEC

`timescale 1ns/100ps

module MAINDEC(
    input  logic [5:0] op,         // Opcode
    output logic       memtoreg,   // Memory-to-register (LW)
    output logic       memwrite,   // Memory write (SW)
    output logic       branch,     // Branch (BEQ)
    output logic       alusrc,    // ALU source (0=reg, 1=imm)
    output logic       regdst,     // Register dest (0=rt, 1=rd)
    output logic       regwrite,  // Register write enable
    output logic       jump,      // Jump (J)
    output logic [1:0] aluop      // ALU operation (see below)
);
    // Control word: {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop[1:0]}
    logic [8:0] controls;

    assign {regwrite, regdst, alusrc, branch, 
            memwrite, memtoreg, jump, aluop} = controls;

    always_comb
        case(op)
            // R-type (ADD, SUB, AND, OR, SLT)
            6'b000000: controls = 9'b110000010; // aluop=10 (use funct)
            
            // LW (Load Word)
            6'b100011: controls = 9'b101001000; // aluop=00 (add)
            
            // SW (Store Word)
            6'b101011: controls = 9'b001010000; // aluop=00 (add)
            
            // BEQ (Branch Equal)
            6'b000100: controls = 9'b000100001; // aluop=01 (subtract)
            
            // ADDI (Add Immediate)
            6'b001000: controls = 9'b101000000; // aluop=00 (add)
            
            // J (Jump)
            6'b000010: controls = 9'b000000100; // aluop=xx (don't care)
            
            // Default: All signals disabled
            default:   controls = 9'b000000000; 
        endcase

    // aluop[1:0] encoding:
    // 00 = add (LW/SW/ADDI)
    // 01 = subtract (BEQ)
    // 10 = use funct (R-type)
    // 11 = unused (could be AND/OR for I-type)
endmodule

`endif