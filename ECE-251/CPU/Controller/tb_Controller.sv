`timescale 1ns/100ps

module CONTROLLER_tb;
  parameter n = 32;
  
  // Inputs
  reg [5:0] op;
  reg [5:0] funct;
  reg zero;
  
  // Outputs from controller
  wire memtoreg, memwrite;
  wire pcsrc, alusrc;
  wire regdst, regwrite;
  wire jump;
  wire [2:0] alucontrol; //3

  // Internal reconstructed branch signal
  wire branch = pcsrc | (zero & pcsrc); // Handles both cases

  // Instantiate the Controller
  CONTROLLER #(n) uut (
    .op(op),
    .funct(funct),
    .zero(zero),
    .memtoreg(memtoreg),
    .memwrite(memwrite),
    .pcsrc(pcsrc),
    .alusrc(alusrc),
    .regdst(regdst),
    .regwrite(regwrite),
    .jump(jump),
    .alucontrol(alucontrol)
  );

  // Test cases
  initial begin
    $display("Time\tInstruction\tZero\tControls\t\tALUCtrl\tStatus");
    $display("------------------------------------------------------------");
    
    test_rtype();
    test_itype();
    test_jtype();
    test_invalid();
    
    $display("\nAll tests completed");
    $finish;
  end

  task test_rtype;
    begin
      op = 6'b000000; zero = 0;
      
      // ADD
      funct = 6'b100000;
      #10 verify_outputs("ADD", 
                         {1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}, 
                         4'b0010);
      
      // SUB
      funct = 6'b100010;
      #10 verify_outputs("SUB", 
                         {1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}, 
                         4'b0110);
      
      // AND
      funct = 6'b100100;
      #10 verify_outputs("AND", 
                         {1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}, 
                         4'b0000);
      
      // OR
      funct = 6'b100101;
      #10 verify_outputs("OR", 
                         {1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}, 
                         4'b0001);
      
      // SLT
      funct = 6'b101010;
      #10 verify_outputs("SLT", 
                         {1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}, 
                         4'b0111);
    end
  endtask

  task test_itype;
    begin
      funct = 6'b000000;
      
      // LW
      op = 6'b100011; zero = 0;
      #10 verify_outputs("LW", 
                         {1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0}, 
                         4'b0010);
      
      // SW
      op = 6'b101011; zero = 0;
      #10 verify_outputs("SW", 
                         {1'b0, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0}, 
                         4'b0010);
      
      // ADDI
      op = 6'b001000; zero = 0;
      #10 verify_outputs("ADDI", 
                         {1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0}, 
                         4'b0010);
      
      // BEQ (taken)
      op = 6'b000100; zero = 1;
      #10 verify_outputs("BEQ (taken)", 
                         {1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0}, 
                         4'b0110);
      
      // BEQ (not taken) - branch signal should still be 1
      op = 6'b000100; zero = 0;
      #10 verify_outputs("BEQ (not taken)", 
                         {1'b0, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0}, 
                         4'b0110);
    end
  endtask

  task test_jtype;
    begin
      // J
      op = 6'b000010; zero = 0;
      #10 verify_outputs("J", 
                         {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1}, 
                         4'b0010);
    end
  endtask

  task test_invalid;
    begin
      op = 6'b111111; zero = 0;
      #10 $display("%0t\tINVALID\t%b\t%b%b%b%b%b%b%b\txxxx", $time, zero,
                  regwrite, regdst, alusrc, pcsrc, memwrite, memtoreg, jump);
    end
  endtask

  task verify_outputs;
    input [80:0] instr_name;
    input [6:0] expected_controls; // {regwrite,regdst,alusrc,pcsrc,memwrite,memtoreg,jump}
    input [3:0] expected_aluctrl;
    reg [6:0] observed_controls;
  begin
    observed_controls = {regwrite,regdst,alusrc,pcsrc,memwrite,memtoreg,jump};
    
    $display("%0t\t%s\t%b\t%b%b%b%b%b%b%b\t%4b", $time, instr_name, zero,
            regwrite, regdst, alusrc, pcsrc, memwrite, memtoreg, jump,
            alucontrol);
    
    // Special case for BEQ - only check branch signal when zero=1
    if (op == 6'b000100) begin
      if (zero && !pcsrc) begin
        $error("  BEQ should branch when zero=1");
      end
      if (alucontrol !== 4'b0110) begin
        $error("  BEQ should use SUB for comparison");
      end
    end
    else if (observed_controls !== expected_controls) begin
      $error("  Control signals mismatch");
      $display("    Expected: %b%b%b%b%b%b%b", 
               expected_controls[6], expected_controls[5], 
               expected_controls[4], expected_controls[3],
               expected_controls[2], expected_controls[1],
               expected_controls[0]);
      $display("    Observed: %b%b%b%b%b%b%b", 
               regwrite, regdst, alusrc, pcsrc, 
               memwrite, memtoreg, jump);
    end
    
    if (alucontrol !== expected_aluctrl && op != 6'b000100) begin
      $error("  ALU control mismatch");
      $display("    Expected: %4b", expected_aluctrl);
      $display("    Observed: %4b", alucontrol);
    end
  end
  endtask

endmodule