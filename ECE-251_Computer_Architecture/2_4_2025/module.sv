//////////////////////////////////////////////////////////////////////////////
//
// Module: module_name
//
// 4:1 Multiplexer
//
// module: module_name
// hdl: SystemVerilog
// modeling: Gate Level Modeling
//
// author: Prof. Rob Marano <rob@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////
// DEPTH --> HOW Many rows of memory we have 
// Log base 2 of(depth) = width 

// assign {cout, sum} = a + b + cin; 
// localparam DELAY = 2; A delay value that should not be modified from ouside 

// genvar --> Declares a variable that is used as a loop counter or index inside a generator block
// generate block --> 
// array slicing? .a(data_a[i *WIDTH+ :WIDTH]), 

`ifndef DFF
`define DFF
// DO NOT FORGET TO RENAME MODULE_NAME to match your module_name

module DFF(input logic clk, input logic rst, input logic enable, input logic d, output logic q ); 

always_ff @(posedge clk) begin 
    if (rst) begin
         q <= 0; // Synchronous reset
          end else if (enable) begin 
            q <= d; // Data is loaded only when enable is high 
        end 
    end 
            
endmodule

`endif // MODULE_NAME