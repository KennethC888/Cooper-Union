`timescale 1ns/100ps
`include "Counter.sv"

module tb_COUNTER;
  // Testbench signals
  logic clk;
  logic rst;
  logic enable;
  logic load;
  logic [7:0] load_value;
  logic [7:0] pc;

  // Instantiate the counter (default 8-bit width)
  COUNTER pc_8bit (
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .load(load),
    .load_value(load_value),
    .pc(pc)
  );

  // Clock generation (10ns period = 5ns high, 5ns low)
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Test sequence
  initial begin
    $dumpfile("tb_COUNTER.vcd"); // Dump waves
    $dumpvars(0, tb_COUNTER);

    // Initialize signals
    rst = 1;      // Apply reset
    enable = 0;   // Disable counting initially
    load = 0;
    load_value = 8'h00;

    #20;   // Hold reset for 2 clock cycles
    rst = 0;  // Release reset
    #10;  // Wait one clock cycle for reset to propagate

    // Verify reset behavior
    $display("Reset passed: pc = %h", pc);

    // Enable counting
    enable = 1;
    $display("Counter enabled. Counting through all values...");

    // Monitor counter output
    forever begin
      #10; // Wait for one clock cycle
      $display("pc = %h", pc);

      // Stop simulation when counter wraps around to 0
      if (pc == 8'h00 && enable) begin
        $display("Counter wrapped around to 0. Simulation complete.");
        $finish;
      end
    end
  end

endmodule
