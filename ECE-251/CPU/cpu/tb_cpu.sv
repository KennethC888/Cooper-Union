///////////////////////////////////////////////////////////////////////////////
//
// Module: Testbench for CPU
//
// Testbench for CPU
//
// module: CPU
// hdl: SystemVerilog
//
// author: Kenneth Chan <kenc0728@gmail.com>
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps
`include "cpu.sv"

`timescale 1ns/100ps
`include "cpu.sv"

module tb_cpu;

    parameter N = 32;
    parameter CLK_PERIOD = 10; // 10ns period (100MHz)

    // Testbench signals
    logic clk, reset;
    logic [N-1:0] instr;
    logic memwrite;
    logic [N-1:0] pc, aluout, writedata, readdata;

    // Instantiate DUT
    cpu #(N) dut (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instr(instr),
        .memwrite(memwrite),
        .aluout(aluout),
        .writedata(writedata),
        .readdata(readdata)
    );

    // Clock generation
    initial clk = 0;
    always #(CLK_PERIOD/2) clk = ~clk;

    // Instruction Memory (ROM)
    logic [N-1:0] instr_mem [0:31];  // 32 words

    // Data Memory (RAM) - simple model
    logic [N-1:0] data_mem [0:255];
    
    // Register file contents (for debugging)
    logic [N-1:0] reg_file [0:31];

    // Initialize program and memory
    initial begin
        // Initialize memories
        for (int i = 0; i < 32; i++) begin
            instr_mem[i] = 32'b0;
            if (i < 256) data_mem[i] = 32'b0;
        end

        // Test program with enhanced branch testing:
        // 0: addi $t1, $zero, 5      // $t1 = 5
        // 1: addi $t2, $zero, 7      // $t2 = 7
        // 2: add  $t0, $t1, $t2      // $t0 = 12 (5+7)
        // 3: beq  $t1, $t2, fail     // Should NOT branch (5≠7)
        // 4: beq  $t1, $t1, target   // Should branch (5=5)
        // 5: addi $t3, $zero, 99     // Should be skipped (fail)
        // 6: target: addi $t4, $zero, 10  // Branch destination
        // 7: sw    $t4, 4($zero)     // Store 10 to mem[1]
        // 8: lw    $t5, 4($zero)     // Load mem[1] to $t5
        // 9: j     end
        // 10: addi $t6, $zero, 99    // Should be skipped
        // 11: end: addi $s0, $zero, 13  // Jump target
        
        instr_mem[0] = 32'b001000_00000_01001_0000000000000101;  // addi $t1, $zero, 5
        instr_mem[1] = 32'b001000_00000_01010_0000000000000111;  // addi $t2, $zero, 7
        instr_mem[2] = 32'b000000_01001_01010_01000_00000_100000; // add $t0, $t1, $t2
        instr_mem[3] = 32'b000100_01001_01010_0000000000000011;  // beq $t1, $t2, 3 (fail)
        instr_mem[4] = 32'b000100_01001_01001_0000000000000001;  // beq $t1, $t1, 1 (target)
        instr_mem[5] = 32'b001000_00000_01011_0000000001100011;  // addi $t3, $zero, 99 (skipped)
        instr_mem[6] = 32'b001000_00000_01100_0000000000001010;  // target: addi $t4, $zero, 10
        instr_mem[7] = 32'b101011_00000_01100_0000000000000100;  // sw $t4, 4($zero)
        instr_mem[8] = 32'b100011_00000_01101_0000000000000100;  // lw $t5, 4($zero)
        instr_mem[9] = 32'b000010_00000000000000000000001011;    // j end
        instr_mem[10] = 32'b001000_00000_01110_0000000001100011; // addi $t6, $zero, 99 (skipped)
        instr_mem[11] = 32'b001000_00000_10000_0000000000001101; // end: addi $s0, $zero, 13
    end

    // Instruction fetch
    assign instr = (pc >> 2) < 32 ? instr_mem[pc >> 2] : 32'b0;

    // Data memory simulation
    always @(posedge clk) begin
        if (memwrite) begin
            data_mem[aluout >> 2] <= writedata;
            $display("[MEM] Write @%h = %h", aluout, writedata);
        end
    end
    
    assign readdata = data_mem[aluout >> 2];

    // Register file monitoring
    always @(negedge clk) begin
        if (dut.dp.rf.we) begin
            reg_file[dut.dp.rf.wa] <= dut.dp.rf.wd;
            $display("[REG] $%0d <= %h", dut.dp.rf.wa, dut.dp.rf.wd);
        end
    end

    // Branch and jump monitoring
    always @(posedge clk) begin
        if (dut.pcsrc) 
            $display("[BRANCH] Taken! New PC = %h", pc + 4 + ({{14{dut.dp.signimm[15]}}, dut.dp.signimm, 2'b0}));
        
        if (dut.jump) 
            $display("[JUMP] To %h", {pc[31:28], dut.dp.instr[25:0], 2'b0});
    end

    // Main test sequence
    initial begin
        $display("\n=== Starting MIPS CPU Testbench ===");
        $display("Time\tPC\tInstr\t\tALUOut\tControls");
        $monitor("%0t\t%h\t%h\t%h\t%b_%b_%b_%b_%b_%b_%b", 
                $time, pc, instr, aluout, 
                dut.regwrite, dut.regdst, dut.alusrc, 
                dut.pcsrc, dut.memwrite, dut.memtoreg, dut.jump);

    // Reset and start the simulation
    reset = 1;
    #20 reset = 0;

    // Run the simulation for a specific number of cycles
    #200 $finish;
end

// For debugging (monitor instructions and data memory)
initial begin
    $dumpfile("cpu.vcd");
    $dumpvars(0, tb_cpu);
end

endmodule