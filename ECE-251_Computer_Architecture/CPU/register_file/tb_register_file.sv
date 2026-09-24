///////////////////////////////////////////////////////////////////////////////
//
// tb_register_file.sv
//
// module: tb_register_file
// hdl: Verilog
//
// author: Berry Xu <berry.xu@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/10ps

`include "./register_file.sv"
`include "../clock/Clock.sv"

module tb_register_file;
    logic clk;
    logic rst;
    logic we;
    logic [4:0] ra1, ra2, wa;
    logic [31:0] wd;
    logic [31:0] rd1, rd2;

    // Instantiate the register file
    register_file uut (
        .clk(clk),
        .rst(rst),
        .we(we),
        .ra1(ra1),
        .ra2(ra2),
        .wa(wa),
        .wd(wd),
        .rd1(rd1),
        .rd2(rd2)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        we = 0;
        ra1 = 5'b00000; // Read from x0 (should return 0)
        ra2 = 5'b00001; // Read from x1
        wa = 5'b00010;  // Write to x2 (stack pointer)
        wd = 32'hDEADBEEF; // Write value
        #10;

        // Test reset behavior
        rst = 1; // Assert reset
        #10;
        rst = 0; // Deassert reset
        #10;

        // Test write to register x2
        we = 1; // Enable writing
        ra1 = 5'b00010; // Read from x2
        ra2 = 5'b00011; // Read from x3
        wd = 32'h12345678; // New data to write to x2
        #10;

        // Check read data
        $display("Read from ra1 (x2): %h", rd1); // Should display 0x12345678
        $display("Read from ra2 (x3): %h", rd2); // Should display 0x0 (default value)

        // Test stack pointer initialization after reset
        ra1 = 5'b00010; // Read from x2 (stack pointer)
        #10;
        $display("Stack pointer (x2) after reset: %h", rd1); // Should display 0x1000

        // Test writing to x0 (shouldn't work)
        wa = 5'b00000; // Try writing to x0
        wd = 32'hFFFF0000; // Some arbitrary value
        #10;
        ra1 = 5'b00000; // Read from x0 (should always be 0)
        $display("Read from x0: %h", rd1); // Should display 0x0

        $finish;
    end
endmodule
