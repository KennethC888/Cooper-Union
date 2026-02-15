//////////////////////////////////////////////////////////////////////////////
//
// Module: ALU decoder
//
// ALU decoder
//
// module: ALU decoder
// hdl: SystemVerilog
// modeling: Behavior Level Modeling
//
// author: Kenneth Chan <kenc0728@gmail.com>
//
///////////////////////////////////////////////////////////////////////////////
`ifndef ALUDEC
`define ALUDEC

`timescale 1ns/100ps

module aludec(
    input  logic [5:0] funct,
    input  logic [1:0] aluop,
    output logic [3:0] alucontrol //3
);
    always_comb
        case(aluop)
            2'b00: alucontrol = 4'b0010;  // add (for lw/sw/addi)
            2'b01: alucontrol = 4'b0110;  // sub (for beq)
            default: case(funct)          // R-type instructions
                6'b100000: alucontrol = 4'b0010; // add
                6'b100010: alucontrol = 4'b0110; // sub
                6'b100100: alucontrol = 4'b0000; // and
                6'b100101: alucontrol = 4'b0001; // or
                6'b101010: alucontrol = 4'b0111; // slt
                default:   alucontrol = 4'bxxxx; // ???
            endcase
        endcase

endmodule

`endif // ALU_DECODER

