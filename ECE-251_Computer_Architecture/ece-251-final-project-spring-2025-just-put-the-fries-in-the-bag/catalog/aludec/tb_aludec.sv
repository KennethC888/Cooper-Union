//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// 
// Berry Xu
//
//     Module Name: tb_aludec
//     Description: Test bench for a single-cycle MIPS computer
//
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps

module aludec_tb;

  parameter n = 32;

  logic [5:0] funct;
  logic [1:0] aluop;
  logic [2:0] alucontrol;

  // Instantiate the ALU Decoder
  aludec #(n) dut (
    .funct(funct),
    .aluop(aluop),
    .alucontrol(alucontrol)
  );

  // Stimulus
  initial begin
    $display("Time\taluop\tfunct\talucontrol");
    $monitor("%0dns\t%02b\t%06b\t%03b", $time, aluop, funct, alucontrol);

    // lw/sw (addi-style): aluop = 00 => add
    aluop = 2'b00; funct = 6'bxxxxxx;
    #10;

    // beq: aluop = 01 => sub
    aluop = 2'b01; funct = 6'bxxxxxx;
    #10;

    // R-type: aluop = 10 or 11 (default)
    aluop = 2'b10; funct = 6'b100000; // add
    #10;

    funct = 6'b100010; // sub
    #10;

    funct = 6'b100100; // and
    #10;

    funct = 6'b100101; // or
    #10;

    funct = 6'b101010; // slt
    #10;

    funct = 6'b011000; // mult
    #10;

    funct = 6'b010010; // mflo
    #10;

    funct = 6'b010000; // mfhi
    #10;

    funct = 6'b111111; // invalid
    #10;

    $finish;
  end

endmodule
