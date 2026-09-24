//////////////////////////////////////////////////////////////////////////////
//
// Module: register_file
//
// register File
//
// hdl: SystemVerilog
// modeling: Behavioral Modeling
//
// author: Berry Xu <berry.xu@cooper.edu
//
///////////////////////////////////////////////////////////////////////////////
`ifndef REGISTER_FILE
`define REGISTER_FILE

module register_file #(
    parameter WIDTH = 32,
    parameter ADDR_WIDTH = 5
)(
    input logic clk, rst, we,
    input logic [ADDR_WIDTH-1:0] ra1, ra2, wa,
    input logic [WIDTH-1:0] wd,
    output logic [WIDTH-1:0] rd1, rd2
);
    logic [WIDTH-1:0] regfile [0:2**ADDR_WIDTH-1];
    
    // Initialize register x2 (sp) to 0x1000
    initial begin
        regfile[2] = 32'h00001000;
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            for (int i = 0; i < 2**ADDR_WIDTH; i++)
                regfile[i] <= '0;
            regfile[2] <= 32'h00001000; // Reset stack pointer
        end
        else if (we && wa != 0)
            regfile[wa] <= wd;
    end

    assign rd1 = (ra1 != 0) ? regfile[ra1] : '0;
    assign rd2 = (ra2 != 0) ? regfile[ra2] : '0;
endmodule

`endif