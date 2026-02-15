///////////////////////////////////////////////////////////////////////////////
//
// Module: Testbench for Datapath
//
// Testbench for Datapath
//
// module: Datapath
// hdl: SystemVerilog
//
// author: Kenneth Chan <kenc0728@gmail.com>
//
///////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

module tb_datapath;
    parameter n = 32;
    
    // Inputs
    reg clk, reset;
    reg memtoreg, pcsrc, alusrc, regdst, regwrite, jump;
    reg [2:0] alucontrol;
    reg [n-1:0] instr, readdata;
    
    // Outputs
    wire [n-1:0] pc, aluout, writedata;
    
    // Instantiate datapath
    datapath #(n) uut (
        .clk(clk),
        .reset(reset),
        .memtoreg(memtoreg),
        .pcsrc(pcsrc),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .alucontrol(alucontrol),
        .instr(instr),
        .readdata(readdata),
        .pc(pc),
        .aluout(aluout),
        .writedata(writedata)
    );
    
    // Clock generation (100MHz)
    always #5 clk = ~clk;
    
    initial begin
        // Initialize
        clk = 0;
        reset = 1;
        memtoreg = 0;
        pcsrc = 0;
        alusrc = 0;
        regdst = 0;
        regwrite = 0;
        jump = 0;
        alucontrol = 3'b000;
        instr = 0;
        readdata = 0;
        
        // Release reset
        #10 reset = 0;
        regwrite = 1;
        
        // Test 1: addi $1, $0, 5
        #10 alucontrol = 3'b010;  // ADD
        alusrc = 1;
        instr = 32'h20010005;  // addi $1, $0, 5
        
        // Test 2: and $2, $1, $0
        #10 alucontrol = 3'b000;  // AND
        alusrc = 0;
        regdst = 1;
        instr = 32'h00201024;  // and $2, $1, $0
        
        // Test 3: lw $3, 4($0)
        #10 alucontrol = 3'b010;  // ADD
        alusrc = 1;
        memtoreg = 1;
        regdst = 0;
        instr = 32'h8c030004;  // lw $3, 4($0)
        readdata = 32'h12345678;
        
        // Test 4: beq $1, $0, -20
        #10 alucontrol = 3'b110;  // SUB
        pcsrc = 1;
        instr = 32'h1020fffb;  // beq $1, $0, -20
        
        // Run for longer to observe behavior
        #100 $finish;
    end
    
    // Verification checks
    always @(posedge clk) begin
        if (instr == 32'h1020fffb) begin  // When executing beq
            #1; // Wait for signals to settle
            $display("BEQ Check: %d - %d = %d (Zero=%b)", 
                     uut.srca, uut.srcb, aluout, uut.zero_flag);
            if (aluout != (uut.srca - uut.srcb)) begin
                $error("Subtraction failed! Expected %d, got %d",
                      (uut.srca - uut.srcb), aluout);
            end
        end
    end
endmodule