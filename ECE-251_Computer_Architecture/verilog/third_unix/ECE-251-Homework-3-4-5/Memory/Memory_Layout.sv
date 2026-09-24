//////////////////////////////////////////////////////////////////////////////
//
// Module: Memory Layout
//
// Memory Layout
//
// module: Memory Layout
// hdl: SystemVerilog
// modeling: Behavior Level Modeling
//
// author: Kenneth Chan <kenc0728@gmail.com>
//
///////////////////////////////////////////////////////////////////////////////
`ifndef Memory_Layout
`define Memory_Layout

module Memory_Layout (
    input wire clk,              
    input wire rst,              
    input wire write_en,          // Write enable (1 is write, 0 is read)
    input wire [7:0] addr,        // 8-bit address input
    input wire [7:0] data_in,     // (writing)
    output reg [7:0] data_out     // (reading)
);

    // Memory array: 256 bytes 
    reg [7:0] memory [0:255];

    integer i;

    // Initialize memory
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            memory[i] = 8'b0; // Reset memory
        end
    end

    // Sequential Write and Read Operation
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 256; i = i + 1) begin
                memory[i] <= 8'b0; // Reset 
            end
            data_out <= 8'b0; // Reset data output
        end else if (write_en) begin
            memory[addr] <= data_in; // Write data to memory
        end
    end

    always @(posedge clk) begin
        if (!write_en) begin
            data_out <= memory[addr]; // Read from memory
        end
    end

endmodule

`endif
