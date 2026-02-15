//////////////////////////////////////////////////////////////////////////////
//
// Module: Controller
//
// Controller
//
// module: Controller
// hdl: SystemVerilog
// modeling: Behavior Level Modeling
//
// author: Kenneth Chan <kenc0728@gmail.com> 
// Code inspired by Prof. Marano
// need to account for R, I, J type instructions
//
///////////////////////////////////////////////////////////////////////////////

`ifndef CONTROLLER
`define CONTROLLER

`include "../Main_Decoder/Main_Decoder.sv"
`include "../ALU_decoder/aludec.sv"

`timescale 1ns/100ps


module CONTROLLER(
    input  logic [5:0] op, funct,
    input  logic zero,
    output logic memtoreg, memwrite,
    output logic pcsrc, alusrc,
    output logic regdst, regwrite,
    output logic jump,
    output logic [2:0] alucontrol
);
    logic [1:0] aluop;
    logic branch;

    // Main decoder
    always_comb begin
        case (op)
            6'b000000: begin // R-type
                regwrite = 1; regdst = 1;
                alusrc = 0; memwrite = 0;
                memtoreg = 0; jump = 0;
                aluop = 2'b10;
            end
            6'b100011: begin // lw
                regwrite = 1; regdst = 0;
                alusrc = 1; memwrite = 0;
                memtoreg = 1; jump = 0;
                aluop = 2'b00;
            end
            6'b101011: begin // sw
                regwrite = 0; regdst = 0;
                alusrc = 1; memwrite = 1;
                memtoreg = 0; jump = 0;
                aluop = 2'b00;
            end
            6'b000100: begin // beq
                regwrite = 0; regdst = 0;
                alusrc = 0; memwrite = 0;
                memtoreg = 0; jump = 0;
                aluop = 2'b01;
            end
            6'b001000: begin // addi
                regwrite = 1; regdst = 0;
                alusrc = 1; memwrite = 0;
                memtoreg = 0; jump = 0;
                aluop = 2'b00;
            end
            default: begin
                regwrite = 0; regdst = 0;
                alusrc = 0; memwrite = 0;
                memtoreg = 0; jump = 0;
                aluop = 2'b00;
            end
        endcase
    end

    // ALU decoder
    always_comb begin
        case (aluop)
            2'b00: alucontrol = 3'b000; // add
            2'b01: alucontrol = 3'b001; // sub
            2'b10: begin // R-type
                case (funct)
                    6'b100000: alucontrol = 3'b000; // add
                    6'b100010: alucontrol = 3'b001; // sub
                    6'b100100: alucontrol = 3'b010; // and
                    6'b011000: alucontrol = 3'b011; // mult
                    6'b010010: alucontrol = 3'b100; // mflo
                    6'b010000: alucontrol = 3'b101; // mfhi
                    default:   alucontrol = 3'b000;
                endcase
            end
            default: alucontrol = 3'b000;
        endcase
    end

    assign branch = (op == 6'b000100) & zero;
    assign pcsrc = branch | jump;
endmodule
`endif





// `ifndef CONTROLLER
// `define CONTROLLER

// `include "../Main_Decoder/Main_Decoder.sv"
// `include "../ALU_decoder/aludec.sv"

// `timescale 1ns/100ps
// module CONTROLLER(
//     input  logic [5:0] op,
//     input  logic [5:0] funct,
//     input  logic       zero,
//     output logic       memtoreg,
//     output logic       memwrite,
//     output logic       pcsrc,
//     output logic       alusrc,
//     output logic       regdst,
//     output logic       regwrite,
//     output logic       jump,
//     output logic [2:0] alucontrol //3
// );

//     typedef enum logic [2:0] {
//         ADD = 3'b010,
//         SUB = 3'b110,
//         AND = 3'b000,
//         OR  = 3'b001,
//         SLT = 3'b111
//     } alu_ops_t;

//     logic [2:0] aluop;

//     // Default values
//     always_comb begin
//         // Defaults for all control signals
//         regwrite  = 0;
//         regdst    = 0;
//         alusrc    = 0;
//         memtoreg  = 0;
//         memwrite  = 0;
//         pcsrc     = 0;
//         jump      = 0;
//         aluop     = 3'b000;

//         case (op)
//             6'b000000: begin // R-type
//                 regwrite = 1;
//                 regdst   = 1;
//                 aluop    = 3'b010;
//             end

//             6'b100011: begin // lw
//                 regwrite = 1;
//                 alusrc   = 1;
//                 memtoreg = 1;
//                 aluop    = 3'b000;
//             end

//             6'b101011: begin // sw
//                 alusrc   = 1;
//                 memwrite = 1;
//                 aluop    = 3'b000;
//             end

//             6'b000100: begin // beq
//                 pcsrc    = zero;
//                 aluop    = 3'b001;
//             end

//             6'b001000: begin // addi
//                 regwrite = 1;
//                 alusrc   = 1;
//                 aluop    = 3'b000;
//             end

//             6'b000010: begin // j
//                 jump     = 1;
//             end
//         endcase
//     end

//     // ALU decoder
//     always_comb begin
//         case (aluop)
//             3'b000: alucontrol = 3'b010; // ADD
//             3'b001: alucontrol = 3'b110; // SUB
//             3'b010: begin
//                 case (funct)
//                     6'b100000: alucontrol = 3'b010; // ADD
//                     6'b100010: alucontrol = 3'b110; // SUB
//                     6'b100100: alucontrol = 3'b000; // AND
//                     6'b100101: alucontrol = 3'b001; // OR
//                     6'b101010: alucontrol = 3'b111; // SLT
//                     default:   alucontrol = 3'bxxx;
//                 endcase
//             end
//             default: alucontrol = 3'bxxx;
//         endcase
//     end

// endmodule
// `endif

// THING 3

// module CONTROLLER #(parameter n = 32)(
//     input  logic [5:0] op, funct,
//     input  logic       zero,
//     output logic       memtoreg, memwrite,
//     output logic       pcsrc, alusrc,
//     output logic       regdst, regwrite,
//     output logic       jump,
//     output logic [3:0] alucontrol,
//     output logic       branch  // Explicitly expose branch signal
// );
//     logic [1:0] aluop;
    
//     MAINDEC md(
//         .op(op),
//         .memtoreg(memtoreg),
//         .memwrite(memwrite),
//         .branch(branch),  // branch=1 for BEQ, 0 otherwise
//         .alusrc(alusrc),
//         .regdst(regdst),
//         .regwrite(regwrite),
//         .jump(jump),
//         .aluop(aluop)
//     );
    
//     aludec ad(
//         .funct(funct),
//         .aluop(aluop),
//         .alucontrol(alucontrol)
//     );

//     assign pcsrc = branch & zero;  // pcsrc = 1 only if branch=1 and zero=1
//endmodule
