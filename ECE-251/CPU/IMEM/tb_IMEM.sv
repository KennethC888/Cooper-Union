//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2023
// Kenneth Chan
// 
// 
//     Module Name: tb_IMEM
//     Description: Test bench 
//
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_IMEM
`define TB_IMEM

`timescale 1ns/100ps
`include "IMEM.sv"

module tb_IMEM;
    parameter n = 32; // bit length
    parameter r = 6;  // address bits (2^6 = 64 words)
    logic [(n-1):0] readdata;
    logic [(r-1):0] imem_addr;  // Corrected size for address input

    initial begin
        $dumpfile("imem.vcd");
        $dumpvars(0, uut);
        $monitor("time=%0t \t imem_addr=%h readdata=%h", $realtime, imem_addr, readdata);
    end

    initial begin
        #10 imem_addr = 6'b000000; // 0x00000000
        #10 imem_addr = 6'b000001; // 0x00000004
        #10 imem_addr = 6'b000010; // 0x00000008
        $finish;
    end

    // instantiate imem (match correct port names!)
    IMEM uut(
        .addr(imem_addr),    // Corrected to 'addr'
        .readdata(readdata)  // Corrected to 'readdata'
    );
endmodule

`endif // TB_IMEM

