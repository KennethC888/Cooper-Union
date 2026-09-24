//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 
// Kenneth Chan
// Code inspired by Prof. Rob Marano
// 
// Module Name: Datapath
//
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef DATAPATH
`define DATAPATH

`timescale 1ns/100ps

`include "../register_file/register_file.sv"
`include "../ALU/ALU.sv"
`include "../dff/dff.sv"
`include "../Adder/adder.sv"
`include "../sl2/Shift_Left_2.sv"
`include "../mux2/mux2.sv"
`include "../signext/signext.sv"


module datapath #(parameter n = 32)(
    input  logic           clk, reset,
    input  logic           memtoreg, pcsrc,
    input  logic           alusrc, regdst, regwrite, jump,
    input  logic [2:0]     alucontrol,
    output logic [n-1:0]   pc,
    input  logic [n-1:0]   instr,
    output logic [n-1:0]   aluout, writedata,
    input  logic [n-1:0]   readdata,
    output logic [n-1:0]   hi, lo
);
    // Register file
    logic [n-1:0] regfile [0:31];
    initial begin
        foreach (regfile[i]) regfile[i] = 0;
    end

    // Internal signals
    logic [4:0] writereg;
    logic [n-1:0] pcnext, pcnextbr, pcplus4, pcbranch;
    logic [n-1:0] signimm, signimmsh;
    logic [n-1:0] srca, srcb, srcbmux;
    logic [n-1:0] result;
    
    // Special registers for multiplication
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            hi <= 0;
            lo <= 0;
        end
        else if (alucontrol == 3'b011) begin  // mult operation
            {hi, lo} <= srca * srcb;
            $display("MULT: %d * %d = %d (HI=%h, LO=%h)", 
                    srca, srcb, srca*srcb, hi, lo);
        end
    end

    // Register file write
    always @(posedge clk) begin
        if (regwrite && writereg != 0) begin  // $0 is read-only
            regfile[writereg] <= result;
            $display("REGWRITE: $%0d = %h", writereg, result);
        end
    end

    // ALU logic
    always_comb begin
        case (alucontrol)
            3'b000: aluout = srca + srcbmux;  // add
            3'b001: aluout = srca - srcbmux;  // sub
            3'b010: aluout = srca & srcbmux;  // and
            3'b011: aluout = 0;               // mult (handled separately)
            3'b100: aluout = lo;              // mflo
            3'b101: aluout = hi;              // mfhi
            default: aluout = 0;
        endcase
    end

    // Program counter
    always @(posedge clk or posedge reset) begin
        if (reset) pc <= 0;
        else pc <= pcnext;
    end

    // Instruction decoding
    assign writereg = regdst ? instr[15:11] : instr[20:16];
    assign signimm = {{16{instr[15]}}, instr[15:0]};
    assign signimmsh = signimm << 2;
    assign srca = regfile[instr[25:21]];
    assign srcb = regfile[instr[20:16]];
    assign srcbmux = alusrc ? signimm : srcb;
    assign writedata = srcb;
    
    // Result mux
    assign result = memtoreg ? readdata : 
                  (instr[5:0] == 6'b010010) ? lo : // mflo
                  (instr[5:0] == 6'b010000) ? hi : // mfhi
                  aluout;

    // PC calculation
    assign pcplus4 = pc + 4;
    assign pcbranch = pcplus4 + (signimm << 2);
    assign pcnextbr = pcsrc ? pcbranch : pcplus4;
    assign pcnext = jump ? {pcplus4[31:28], instr[25:0], 2'b00} : pcnextbr;
endmodule
`endif