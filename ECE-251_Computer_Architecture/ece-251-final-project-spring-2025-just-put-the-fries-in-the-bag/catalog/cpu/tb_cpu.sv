
`timescale 1ns/1ps

module cpu_tb;

  parameter n = 32;

  // Inputs to CPU
  logic clk, reset;
  logic [(n-1):0] instr;
  logic [(n-1):0] readdata;

  // Outputs from CPU
  logic [(n-1):0] pc;
  logic memwrite;
  logic [(n-1):0] aluout, writedata;

  // Instantiate DUT
  cpu #(n) dut (
    .clk(clk),
    .reset(reset),
    .pc(pc),
    .instr(instr),
    .memwrite(memwrite),
    .aluout(aluout),
    .writedata(writedata),
    .readdata(readdata)
  );

  // Mock instruction memory (8 instructions max)
  logic [31:0] imem [0:7];

  // Mock data memory (256 32-bit words)
  logic [31:0] dmem [0:255];

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Instruction fetch simulation
  always @(*) begin
    instr = imem[pc >> 2];
  end

  // Data memory read/write simulation
  always @(*) begin
    readdata = dmem[aluout >> 2];
  end

  always @(posedge clk) begin
    if (memwrite) begin
      dmem[aluout >> 2] <= writedata;
      $display("Memory write at %h: %h", aluout, writedata);
    end
  end

  // Test program (machine code)
  initial begin
    // Format: op[31:26] rs[25:21] rt[20:16] rd[15:11] shamt[10:6] funct[5:0]
    // addi $t0, $zero, 5     => 0x20080005
    // addi $t1, $zero, 3     => 0x20090003
    // add  $t2, $t0, $t1     => 0x01095020
    // sw   $t2, 0($zero)     => 0xac0a0000
    // lw   $t3, 0($zero)     => 0x8c0b0000
    imem[0] = 32'h20080005;
    imem[1] = 32'h20090003;
    imem[2] = 32'h01095020;
    imem[3] = 32'hac0a0000;
    imem[4] = 32'h8c0b0000;
    imem[5] = 32'h00000000; // NOP
    imem[6] = 32'h00000000;
    imem[7] = 32'h00000000;

    reset = 1;
    #10;
    reset = 0;

    // Run simulation
    #100;
    $display("Final PC = %h", pc);
    $display("Memory[0] = %h", dmem[0]);
    $finish;
  end

endmodule
