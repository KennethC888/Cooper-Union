//////////////////////////////////////////////////////////////////////////////
//
// Module: ALU
//
// ALU
//
// module: ALU
// hdl: SystemVerilog
// modeling: Behavior Level Modeling
//
// author: Kenneth Chan <kenc0728@gmail.com>
//
///////////////////////////////////////////////////////////////////////////////
`ifndef ALU
`define ALU
// DO NOT FORGET TO RENAME MODULE_NAME to match your module_name

module ALU #(
    parameter WIDTH = 32
)(
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    input [3:0] operation,
    output [WIDTH-1:0] result,
    output carry_out
   
);

    reg [WIDTH-1:0] ALU_Result;
    wire [WIDTH:0] extended_result;
    assign result = ALU_Result;    
    assign extended_result = {1'b0, a} + {1'b0, b};
    assign carry_out = extended_result[8];  

    always @(*)
    begin
        case (operation)
         // Arithmetic operations
         4'b0000: ALU_Result = a + b;    // Addition
         4'b0001: ALU_Result = a - b;    // Subtraction
         4'b0010: ALU_Result = a * b;    // Multiplication
         4'b0011: ALU_Result = a / b;    // Division
         // Bitwise operations
         4'b0100: ALU_Result = a << 1;  // Logical shift left
         4'b0101: ALU_Result = a >> 1;  // Logical shift right
         4'b0110: ALU_Result = {a[6:0], a[7]}; // Rotate left
         4'b0111: ALU_Result = {a[0], a[7:1]};// Rotate right
         // Logical operations
         4'b1000: ALU_Result = a & b; // Logical AND
         4'b1001: ALU_Result = a | b; // Logical OR
         4'b1010: ALU_Result = a ^ b; // Logical XOR
         4'b1011: ALU_Result = ~(a | b);// Logical NOR
         4'b1100: ALU_Result = ~(a & b);// Logical NAND
         4'b1101: ALU_Result = ~(a ^ b); // Logical XNOR
         // Comparison operations
         default: result = {WIDTH{1'b0}}; // Default case to 0
        endcase
    end
endmodule 

`endif 

//Design and implement in SystemVerilog a simplified memory layout from and to which you can load and store data, using byte addressing.