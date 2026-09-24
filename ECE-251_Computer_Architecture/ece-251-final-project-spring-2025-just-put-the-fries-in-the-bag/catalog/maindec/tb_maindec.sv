//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// 
// Kenneth Chan
//
//     Module Name: tb_maindec
//     Description: Test bench for a single-cycle MIPS computer
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

module maindec_tb;

  parameter n = 32;

  // Inputs
  logic [5:0] op;

  // Outputs
  logic memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump;
  logic [1:0] aluop;

  // Instantiate the DUT
  maindec #(n) dut (
    .op(op),
    .memtoreg(memtoreg),
    .memwrite(memwrite),
    .branch(branch),
    .alusrc(alusrc),
    .regdst(regdst),
    .regwrite(regwrite),
    .jump(jump),
    .aluop(aluop)
  );

  // Stimulus
  initial begin
    $display("Time\tOPCODE\tRegWrite RegDst ALUSrc Branch MemWrite MemToReg Jump ALUOp");
    $monitor("%0dns\t%06b\t   %b\t   %b\t   %b\t   %b\t    %b\t     %b\t %b\t %02b",
             $time, op, regwrite, regdst, alusrc, branch,
             memwrite, memtoreg, jump, aluop);

    // R-type
    op = 6'b000000; #10;
    // lw
    op = 6'b100011; #10;
    // sw
    op = 6'b101011; #10;
    // beq
    op = 6'b000100; #10;
    // addi
    op = 6'b001000; #10;
    // j
    op = 6'b000010; #10;
    // invalid
    op = 6'b111111; #10;
    $finish;
  end

endmodule
