//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// Kenneth Chan
// 
//     Module Name: tb_Main_Decoder
//     Description: Test bench
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`include "Main_Decoder.sv"

module tb_MAINDEC;
    logic [5:0] op;
    logic memtoreg, memwrite;
    logic branch, alusrc;
    logic regdst, regwrite;
    logic jump;
    logic [1:0] aluop;

    // Instantiate the maindec
    MAINDEC uut(
        .op(op),
        .memtoreg(memtoreg),
        .memwrite(memwrite),
        .branch(branch),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .aluop(aluop)
    );

    initial begin
        $dumpfile("MAINDEC.vcd");
        $dumpvars(0, tb_MAINDEC);

        $display("Time\topcode\tregwrite regdst alusrc branch memwrite memtoreg jump aluop");

        // Test known opcodes
        op = 6'b000000; #10; // RTYPE
        $display("%0t\t%06b\t   %b       %b      %b     %b      %b        %b    %b%b", $time, op, regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop[1], aluop[0]);

        op = 6'b100011; #10; // LW
        $display("%0t\t%06b\t   %b       %b      %b     %b      %b        %b    %b%b", $time, op, regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop[1], aluop[0]);

        op = 6'b101011; #10; // SW
        $display("%0t\t%06b\t   %b       %b      %b     %b      %b        %b    %b%b", $time, op, regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop[1], aluop[0]);

        op = 6'b000100; #10; // BEQ
        $display("%0t\t%06b\t   %b       %b      %b     %b      %b        %b    %b%b", $time, op, regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop[1], aluop[0]);

        op = 6'b001000; #10; // ADDI
        $display("%0t\t%06b\t   %b       %b      %b     %b      %b        %b    %b%b", $time, op, regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop[1], aluop[0]);

        op = 6'b000010; #10; // J
        $display("%0t\t%06b\t   %b       %b      %b     %b      %b        %b    %b%b", $time, op, regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop[1], aluop[0]);

        // Test illegal opcode
        op = 6'b111111; #10; // Illegal
        $display("%0t\t%06b\t   %b       %b      %b     %b      %b        %b    %b%b", $time, op, regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop[1], aluop[0]);

        $finish;
    end
endmodule
