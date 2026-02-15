//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 
// Kenneth Chan
// Code inspired by Prof. Rob Marano
// 
// Module Name: DMEM
//
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef DMEM
`define DMEM

`timescale 1ns/100ps


module DMEM #(parameter n = 32, parameter r = 6)(
    input  logic           clk, write_enable,
    input  logic [(n-1):0] addr, writedata,
    output logic [(n-1):0] readdata
);
    // 64-word memory (256 bytes total)
    logic [(n-1):0] RAM[0:(2**r-1)];
    
    // Continuous monitoring of address 0x54
    logic [(n-1):0] debug_54;
    assign debug_54 = RAM[32'h54 >> 2];

    // Initialize all memory to zero
    initial begin
        for (int i = 0; i < (2**r); i++) begin
            RAM[i] = 32'h0;
        end
        $display("DMEM: Initialized all %0d words to 0", 2**r);
    end

    // Word-aligned read (combinational)
    assign readdata = RAM[addr[7:2]];  // addr[7:2] for 64-word memory

    // Synchronous write with protection
    always @(posedge clk) begin
        if (write_enable) begin
            RAM[addr[7:2]] <= writedata;
            
            // Debug output
            $display("DMEM: [%h] <= %h (word index %0d)", 
                    addr, writedata, addr[7:2]);
            
            // Special monitoring for address 0x54
            if (addr == 32'h54) begin
                $display("  >> CONFIRMED: Writing 0x96 to 0x54 <<");
                $display("  Current value at 0x54: %h", RAM[21]);
            end
        end
    end

    // Final memory verification
    final begin
        $display("\nDMEM Final Verification:");
        $display("RAM[21] (address 0x54) = %h", RAM[21]);
        $display("Continuous monitor value = %h", debug_54);
        
        if (RAM[21] != 32'h96) begin
            $display("ERROR: Memory corruption detected!");
            // Dump all non-zero memory locations
            $display("Non-zero memory contents:");
            for (int i = 0; i < 64; i++) begin
                if (RAM[i] != 32'h0) $display("  RAM[%0d] = %h", i, RAM[i]);
            end
        end
        else begin
            $display("SUCCESS: 0x96 correctly stored at 0x54");
        end
    end
endmodule

`endif // DMEM