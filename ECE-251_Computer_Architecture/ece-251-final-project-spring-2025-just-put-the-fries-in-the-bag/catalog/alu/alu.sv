`ifndef ALU
`define ALU

`timescale 1ns/1ps

module alu #(parameter n = 32)(
	input logic clk,
	input logic [n-1:0] a, b,
	input logic [2:0] alucontrol,
	output logic [n-1:0] result,
	output logic zero
);
	logic [n-1:0] condinvb, sum;
	logic [2*n-1:0] hilo;

	assign zero = (result == {n{1'b0}});
	assign condinvb = alucontrol[2] ? ~b : b;
	assign sumSlt = a + condinvb + alucontrol[2];

	initial begin
		hilo = 64'b0;
	end

	always @(a, b, alucontrol) begin
		case (alucontrol)
			3'b000: result = a & b;
			3'b001: result = a | b;
			3'b010: result = a + b;
			3'b011: result = ~(a | b);
			3'b100: result = hilo[n-1:0];
			3'b101: result = hilo[2*n-1:n];
			3'b110: result = sumSlt;
			3'b111: begin
					if (a[31] != b[31]) 
						result = (a[31] > b[31]) ? 1'b1 : 1'b0;
					else
						result = (a < b) ? 1'b1 : 1'b0;
				end
		endcase
	end

	always @(negedge clk) begin
		case(alucontrol)
			3'b011: hilo = a*b;
			3'b101: begin
					hilo[n-1:0] = a / b;
					hilo[2*n-1:n] = a % b;
				end
		endcase
	end
endmodule

`endif // ALU
