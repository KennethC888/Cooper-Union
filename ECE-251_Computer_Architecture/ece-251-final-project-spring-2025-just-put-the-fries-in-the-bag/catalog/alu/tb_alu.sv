<<<<<<< HEAD
`timescale 1ns/1ps

module alu_tb;

  parameter n = 32;

  logic clk;
  logic [n-1:0] a, b;
  logic [2:0] alucontrol;
  logic [n-1:0] result;
  logic zero;

  // Instantiate the ALU
  alu #(n) dut (
    .clk(clk),
    .a(a),
    .b(b),
    .alucontrol(alucontrol),
    .result(result),
    .zero(zero)
  );

  // Clock generator
  initial clk = 0;
  always #5 clk = ~clk;

  // Stimulus
  initial begin
    $display("Time\tclk\ta\tb\tctrl\tresult\tzero");
    $monitor("%0dns\t%b\t%h\t%h\t%03b\t%h\t%b", $time, clk, a, b, alucontrol, result, zero);

    a = 32'h0000000A; // 10
    b = 32'h00000005; // 5

    // AND
    alucontrol = 3'b000;
    #10;

    // OR
    alucontrol = 3'b001;
    #10;

    // ADD
    alucontrol = 3'b010;
    #10;

    // SLT (signed)
    alucontrol = 3'b111;
    #10;

    // MUL (will latch on negedge)
    alucontrol = 3'b011;
    #10;

    // Wait for falling edge to store mult result
    #10;
    alucontrol = 3'b100; // lo
    #10;
    alucontrol = 3'b101; // hi
    #10;

    // DIV (will latch on negedge)
    alucontrol = 3'b101;
    #10;

    // Wait for falling edge to store div result
    #10;
    alucontrol = 3'b100; // quotient
    #10;
    alucontrol = 3'b101; // remainder
    #10;

    $finish;
  end

endmodule
=======
///////////////////////////////////////////////////////////////////////////////
//
// Module: Testbench for ALU
//
// Testbench for ALU
//
// module: ALU
// hdl: SystemVerilog
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps
`include "alu.sv"
`timescale 1ns/1ps

module alu_tb;

  parameter n = 32;

  logic clk;
  logic [n-1:0] a, b;
  logic [2:0] alucontrol;
  logic [n-1:0] result;
  logic zero;

  // Instantiate the ALU
  alu #(n) dut (
    .clk(clk),
    .a(a),
    .b(b),
    .alucontrol(alucontrol),
    .result(result),
    .zero(zero)
  );

  // Clock generator
  initial clk = 0;
  always #5 clk = ~clk;

  // Stimulus
  initial begin
    $display("Time\tclk\ta\tb\tctrl\tresult\tzero");
    $monitor("%0dns\t%b\t%h\t%h\t%03b\t%h\t%b", $time, clk, a, b, alucontrol, result, zero);

    a = 32'h0000000A; // 10
    b = 32'h00000005; // 5

    // AND
    alucontrol = 3'b000;
    #10;

    // OR
    alucontrol = 3'b001;
    #10;

    // ADD
    alucontrol = 3'b010;
    #10;

    // SLT (signed)
    alucontrol = 3'b111;
    #10;

    // MUL (will latch on negedge)
    alucontrol = 3'b011;
    #10;

    // Wait for falling edge to store mult result
    #10;
    alucontrol = 3'b100; // lo
    #10;
    alucontrol = 3'b101; // hi
    #10;

    // DIV (will latch on negedge)
    alucontrol = 3'b101;
    #10;

    // Wait for falling edge to store div result
    #10;
    alucontrol = 3'b100; // quotient
    #10;
    alucontrol = 3'b101; // remainder
    #10;

    $finish;
  end
endmodule
>>>>>>> a47ce938a46c9547c84f9477844e7dd3d86dbfe9
