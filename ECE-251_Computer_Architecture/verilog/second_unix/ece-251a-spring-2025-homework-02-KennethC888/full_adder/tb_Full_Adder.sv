///////////////////////////////////////////////////////////////////////////////
//
// Module: Testbench for Full Adder
//
// Testbench for Full Adder
//
// module: Full Adder
// hdl: SystemVerilog
//
// author: Kenneth Chan <kenc0728@gmail.com
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`include "Full_Adder.sv"
module tb_FULL_ADDER;

    initial begin : dump_variables
        $dumpfile("tb_FULL_ADDER.vcd"); // for Makefile, make dump file same as module name
        $dumpvars(0, dut);
    end


    // Define the bit length for the testbench (default is 8 bits)
    parameter n = 8; // Can be changed to any value

    reg [n-1:0] A;    // n-bit input A
    reg [n-1:0] B;    // n-bit input B
    reg Cin;          // Carry input
    wire [n-1:0] Sum; // n-bit Sum output
    wire Cout;        // Carry output

    // Instantiate the n-bit full adder with the parameterized bit length
    FULL_ADDER #(n) dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );


    int error_count = 0; // Initialize outside the procedural block

    // Testbench logic
    initial begin
        integer i, j, k;

        // Loop through all possible values of A, B, and Cin
        for (i = 0; i < (1 << n); i = i + 1) begin
            for (j = 0; j < (1 << n); j = j + 1) begin
                for (k = 0; k < 2; k = k + 1) begin
                    // Assign inputs
                    A = i;
                    B = j;
                    Cin = k;
                    #10; // Wait for the output to stabilize

                    // Verify the output
                    if ({Cout, Sum} !== (A + B + Cin)) begin
                        $display("ERROR: A = %h, B = %h, Cin = %b, Sum = %h, Cout = %b", A, B, Cin, Sum, Cout);
                        error_count = error_count + 1; // Increment error count
                    end
                end
            end
        end

        // Display test results
        if (error_count == 0) begin
            $display("Test PASSED: All inputs verified successfully.");
        end else begin
            $display("Test FAILED: %0d errors found.", error_count);
        end

        // End simulation
        $stop;
    end

endmodule

