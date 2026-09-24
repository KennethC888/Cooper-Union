`ifndef IMEM
`define IMEM

`timescale 1ns/1ps

module imem #(parameter n = 32, parameter r = 6)(
// n=bit length of register; r=bit length of addr to limit memory and not crash your verilog emulator
    input  logic [r-1:0] addr,
    output logic [n-1:0] readdata
);
    logic [n-1:0] RAM[0:(2**r-1)];

  initial
    begin
      // read memory in hex format from file 
      // $readmemh("program_exe",RAM);
      $readmemh("program_exe",RAM);
    end

  assign readdata = RAM[addr]; // word aligned

endmodule

`endif // IMEM
