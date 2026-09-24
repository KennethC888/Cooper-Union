///////////////////////////////////////////////////////////////////////////////
//
// Module: Testbench for Memory Layout
//
// Testbench for Memory Layout
//
// module: Memory Layout
// hdl: SystemVerilog
//
// author: Kenneth Chan <kenc0728@gmail.com>
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps
`include "Memory_Layout.sv"

module tb_Memory_Layout;

    // Signals
    reg clk;             
    reg rst;           
    reg write_en;  // Write enable (1 = write, 0 = read)
    reg [7:0] addr;        
    reg [7:0] data_in;     
    wire [7:0] data_out;   

    Memory_Layout dut (
        .clk(clk),
        .rst(rst),
        .write_en(write_en),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test procedure
    initial begin
        // Initialize signals
        rst = 1;          // Assert reset
        write_en = 0;
        addr = 0;
        data_in = 0;
        #20;              // Wait for a few clock cycles

        // Release reset
        rst = 0;
        #10;

        // Test 1: Write data to address 0x10
        write_en = 1;     // Enable write
        addr = 8'h10;     // Address = 0x10
        data_in = 8'hA5;  // Data to write = 0xA5
        #10;              // Wait for one clock cycle

        write_en = 0;     // Disable write (enable read)
        #10;

        // Test 2: Read data from address 0x10
        if (data_out === 8'hA5)
            $display("Test 1 Passed: Data read from address 0x10 = 0x%h", data_out);
        else
            $display("Test 1 Failed: Expected 0xA5, Got 0x%h", data_out);

        // Test 3: Write data to address 0xFF
        write_en = 1;     // Enable write
        addr = 8'hFF;     // Address = 0xFF
        data_in = 8'h7E;  // Data to write = 0x7E
        #10;              

        // **Wait an extra cycle before reading**
        write_en = 0;     // Disable write (enable read)
        #10;

        // Test 4: Read data from address 0xFF
        if (data_out === 8'h7E)
            $display("Test 2 Passed: Data read from address 0xFF = 0x%h", data_out);
        else
            $display("Test 2 Failed: Expected 0x7E, Got 0x%h", data_out);

    
        #20;
        $finish;
    end

endmodule
