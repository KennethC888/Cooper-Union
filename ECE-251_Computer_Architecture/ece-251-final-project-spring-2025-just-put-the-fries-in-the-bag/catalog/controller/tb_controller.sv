//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// 
// Kenneth Chan
//
//     Module Name: tb_controller
//     Description: Test bench for a single-cycle MIPS computer
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps

module controller_tb;

  parameter n = 32;

  // Inputs
  logic [5:0] op, funct;
  logic       zero;

  // Outputs
  logic       memtoreg, memwrite;
  logic       pcsrc, alusrc;
  logic       regdst, regwrite;
  logic       jump;
  logic [2:0] alucontrol;

  // DUT
  controller #(n) dut (
    .op(op), .funct(funct), .zero(zero),
    .memtoreg(memtoreg), .memwrite(memwrite),
    .pcsrc(pcsrc), .alusrc(alusrc),
    .regdst(regdst), .regwrite(regwrite),
    .jump(jump), .alucontrol(alucontrol)
  );

  // Stimulus
  initial begin
    $display("Time\tOpcode\tFunct\tZero\tRegWrite\tMemWrite\tALUControl\tPCSrc\tJump");
    $monitor("%0dns\t%02h\t%02h\t%b\t%b\t\t%b\t\t%03b\t\t%b\t%b", 
      $time, op, funct, zero, regwrite, memwrite, alucontrol, pcsrc, jump);

    // Test R-type instruction: add
    op = 6'b000000; funct = 6'b100000; zero = 0;
    #10;

    // Test lw
    op = 6'b100011; funct = 6'bxxxxxx; zero = 0;
    #10;

    // Test sw
    op = 6'b101011; funct = 6'bxxxxxx; zero = 0;
    #10;

    // Test beq - not taken
    op = 6'b000100; funct = 6'bxxxxxx; zero = 0;
    #10;

    // Test beq - taken
    op = 6'b000100; funct = 6'bxxxxxx; zero = 1;
    #10;

    // Test jump
    op = 6'b000010; funct = 6'bxxxxxx; zero = 0;
    #10;

    $finish;
  end

endmodule
