module tb_dff_reset()

// Inputs
    logic clk, d, rst;

// Outputs
    wire q, qn;
// $ implies internal function
    initial begin
        $dumpfile("tb_dff.vcd");
        $dumpvars(2, tb_dff_reset);
      $monitor("clk = %b, rst = %b, d = %b(%b), q = %b(%b), qn = %b(%b)", clk, rst, d, dut.D, q, dut.Q, qn, dut.Qn);
    end
  
   initial begin
        clk = 0;
        d = 0;
        rst = 0;
    end
    
   always begin
        clk = #5 ~clk;
    end

    initial begin
       #0
        #20 d = 1;
        #20 d = 0;
        #20;
        #20 rst =1;
        #20 rst = 0; 
        #40; 
        $finish;
    end


// dut is an instance of the module DFF
    dff_reset dut(
        .CLK(clk), .D(d), .Q(q), .Qn(qn), .Rst(rst)
    );
    // .CLK is the module, the clk is the instance. Outside is module, instance is inside
    // Dot notation allows for order to not matter 

endmodule 

// if (condition)
// begin
// procedure
// end

// case statements
// <= vs =, nonblocking (runs in parallel with the other lines) vs blocking (must be run before lines under it)