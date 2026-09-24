//////////////////////////////////////////////////////////////////////////////
//
// Module: IMEM
//
// IMEM
//
// module: IMEM
// hdl: SystemVerilog
// modeling: Behavior Level Modeling
//
// author: Kenneth Chan <kenc0728@gmail.com>
//
///////////////////////////////////////////////////////////////////////////////

`ifndef IMEM
`define IMEM

`timescale 1ns/100ps


module IMEM #(parameter n = 32, parameter r = 6)(
    input  logic [(r-1):0] addr,
    output logic [(n-1):0] readdata
);
    logic [(n-1):0] RAM[0:(2**r-1)];

    initial begin
        $readmemh("mult-prog_exe", RAM);
        $display("Program loaded:");
        for (int i=0; i<6; i++)
            $display("  [%h]: %h", i, RAM[i]);
    end

    assign readdata = RAM[addr];
endmodule

`endif // IMEM

