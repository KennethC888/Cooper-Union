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
`include "ALU.sv"

module tb_alu;

    // Inputs
    reg [31:0] a, b;
    reg [2:0] alucontrol;

    // Outputs
    wire [31:0] aluout;
    wire zero;
    wire overflow;

    // Instantiate the ALU
    alu uut (
        .a(a),
        .b(b),
        .alucontrol(alucontrol),
        .aluout(aluout),
        .zero(zero),
        .overflow(overflow)
    );

    // Test vector
    initial begin
        // Test case 1: AND operation (a & b)
        a = 32'b10101010101010101010101010101010;
        b = 32'b11001100110011001100110011001100;
        alucontrol = 3'b000; // AND
        #10;
        $display("AND operation: a = %b, b = %b, result = %b, zero = %b, overflow = %b", a, b, aluout, zero, overflow);

        // Test case 2: OR operation (a | b)
        alucontrol = 3'b001; // OR
        #10;
        $display("OR operation: a = %b, b = %b, result = %b, zero = %b, overflow = %b", a, b, aluout, zero, overflow);

        // Test case 3: ADD operation (a + b)
        a = 32'd2147483647; // maximum positive value for 32-bit signed integer
        b = 32'd1;
        alucontrol = 3'b010; // ADD
        #10;
        $display("ADD operation: a = %d, b = %d, result = %d, zero = %b, overflow = %b", a, b, aluout, zero, overflow);

        // Test case 4: SUB operation (a - b)
        a = 32'd10;
        b = 32'd5;
        alucontrol = 3'b110; // SUB
        #10;
        $display("SUB operation: a = %d, b = %d, result = %d, zero = %b, overflow = %b", a, b, aluout, zero, overflow);

        // Test case 5: SLT operation (a < b)
        a = 32'd5;
        b = 32'd10;
        alucontrol = 3'b111; // SLT (Set Less Than)
        #10;
        $display("SLT operation: a = %d, b = %d, result = %d, zero = %b, overflow = %b", a, b, aluout, zero, overflow);

        // Test case 6: Overflow on ADD operation (a + b)
        a = 32'd2147483647; // max positive value
        b = 32'd2147483647; // another large value
        alucontrol = 3'b010; // ADD
        #10;
        $display("Overflow ADD operation: a = %d, b = %d, result = %d, zero = %b, overflow = %b", a, b, aluout, zero, overflow);

        // Test case 7: Zero detection
        a = 32'd0;
        b = 32'd0;
        alucontrol = 3'b010; // ADD
        #10;
        $display("Zero detection: a = %d, b = %d, result = %d, zero = %b, overflow = %b", a, b, aluout, zero, overflow);

        // Test case 8: SLT with equal values (should be 0)
        a = 32'd5;
        b = 32'd5;
        alucontrol = 3'b111; // SLT
        #10;
        $display("SLT with equal values: a = %d, b = %d, result = %d, zero = %b, overflow = %b", a, b, aluout, zero, overflow);

        // Test case 9: Edge case for SUB with result = 0
        a = 32'd5;
        b = 32'd5;
        alucontrol = 3'b110; // SUB
        #10;
        $display("Edge case SUB result = 0: a = %d, b = %d, result = %d, zero = %b, overflow = %b", a, b, aluout, zero, overflow);

        // Test case 10: Negative result in SUB
        a = 32'd5;
        b = 32'd10;
        alucontrol = 3'b110; // SUB
        #10;
        $display("Negative result in SUB: a = %d, b = %d, result = %d, zero = %b, overflow = %b", a, b, aluout, zero, overflow);

        $finish;
    end

endmodule
