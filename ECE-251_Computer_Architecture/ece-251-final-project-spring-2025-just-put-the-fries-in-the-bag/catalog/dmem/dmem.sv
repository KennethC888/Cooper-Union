`ifndef DMEM
`define DMEM

`timescale 1ns/1ps

module dmem #(parameter n = 32, parameter r = 6) (
// n=bit length of register; r=bit length of addr to limit memory and not crash your verilog emulator
    input  logic           clk, write_enable,
    input  logic [(n-1):0] addr, writedata,
    output logic [(n-1):0] readdata
);
    logic [(n-1):0] RAM[0:(2**r-1)];

    assign readdata = RAM[addr[(n-1):2]]; 

    always @(posedge clk)
        if (write_enable) RAM[addr[(n-1):2]] <= writedata;
endmodule

`endif // DMEM
