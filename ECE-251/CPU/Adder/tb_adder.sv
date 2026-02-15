///////////////////////////////////////////////////////////////////////////////
//
// Module: Testbench for ALU
//
// Testbench for ALU
//
// module: ALU
// hdl: SystemVerilog
///////////////////////////////////////////////////////////////////////////////
`ifndef TB_ADDER
`define TB_ADDER

`timescale 1ns/100ps
`include "adder.sv"

module tb_adder;
    parameter WIDTH = 32;
    
    // Test signals
    logic [WIDTH-1:0] A, B;
    logic [WIDTH-1:0] Sum;
    
    // Instantiate the adder
    adder #(.WIDTH(WIDTH)) dut (
        .A(A),
        .B(B),
        .Sum(Sum)
    );
    
    // Initialize waveform dumping
    initial begin
        $dumpfile("tb_adder.vcd");
        $dumpvars(0, tb_adder);
    end
    
    // Monitor changes
    initial begin
        $monitor("At time %t: A = %h, B = %h, Sum = %h", 
                 $time, A, B, Sum);
    end

    // Task to check expected result
    task check_result(input [WIDTH-1:0] expected);
        if (Sum === expected) begin
            $display("PASS: Sum = %h (expected %h)", Sum, expected);
        end else begin
            $display("FAIL: Sum = %h (expected %h)", Sum, expected);
        end
    endtask

    // Test cases
    initial begin
        // Test case 1: Basic addition
        A = 32'h00000001;
        B = 32'h00000001;
        #10;
        check_result(32'h00000002);

        // Test case 2: Overflow case (wrap-around)
        A = 32'hFFFFFFFF;
        B = 32'h00000001;
        #10;
        check_result(32'h00000000);

        // Test case 3: Random addition
        A = 32'h12345678;
        B = 32'h87654321;
        #10;
        check_result(32'h99999999);

        $finish;
    end

endmodule
`endif // TB_ADDER
