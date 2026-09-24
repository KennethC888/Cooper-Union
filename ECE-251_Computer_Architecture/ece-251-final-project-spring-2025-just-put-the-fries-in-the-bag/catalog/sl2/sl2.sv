`ifndef SL2
`define SL2

`timescale 1ns/1ps

module sl2
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [(n-1):0] A,
    output logic [(n-1):0] Y
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    assign Y = {A[(n-3):0], 2'b00};
endmodule

`endif // SL2
