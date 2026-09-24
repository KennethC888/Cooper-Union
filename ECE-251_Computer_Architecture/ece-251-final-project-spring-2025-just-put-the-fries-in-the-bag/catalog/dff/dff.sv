///////////////////////////////////////////////////////////////////////////////
//
// dff.sv
//
// module: d-flip-flop
// hdl: Verilog
// modeling: Behavioral Modeling
//
// author: Berry Xu <berry.xu@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////
`ifndef DFF
`define DFF

module dff #(parameter n = 32) (clk, rst, d, q);
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input logic clk, rst;
    input logic [n-1:0] d;
    output logic [n-1:0] q;
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    always_ff @(posedge clk, posedge rst)begin
        if (rst) 
            q <= 0;
        else 
            q <= d;
    end

endmodule
`endif // DFF
