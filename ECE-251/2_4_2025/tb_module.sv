///////////////////////////////////////////////////////////////////////////////
//
// Module: Testbench for module module
//
// Testbench for MODULE_NAME
//
// module: tb_module
// hdl: SystemVerilog
//
// author: Prof. Rob Marano <rob@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`include "module.sv"

module tb_DFF;
  
    initial begin : initialize_variables
    end

    initial begin : dump_variables
        $dumpfile("tb_DFF.vcd"); // for Makefile, make dump file same as module name
        $dumpvars(0, dut);
    end


 logic clk; logic rst; logic enable; logic d; logic q; 
 DFF dut (.clk(clk), .rst(rst), .enable(enable), .d(d), .q(q) ); 
 // Clock generation 
 initial begin 
    clk = 0; 
    forever #5 clk = ~clk; // 10ns period 
    end 
    
    // Test sequence 
    initial begin 
        rst = 1; 
        enable = 0; 
        d = 0;
        #10 rst = 0; // Release reset 

        d = 1; enable = 1; #10; // q should now be 1 
        
        d = 0; enable = 1; #10; // q should now be 0 
        
        enable = 0; // Disable the flip-flop 
        
        d = 1; // Change d, but q should remain unchanged 
        #10; // q should still be 0 
        enable = 1; // Enable again 
        #10; // q should now be 1 
        $display("Final value of q: %b", q); 
        $finish; 
        end 
    
    


endmodule