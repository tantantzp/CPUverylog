`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:16:35 11/21/2013 
// Design Name: 
// Module Name:    ALU_Src2Mux 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ALU_Src2Mux(
    input [15:0] data_ry,
    input [15:0] imm4,
    input [15:0] imm5,
    input [15:0] imm8,
    input [7:0] ALU_Src2,
    output reg [15:0] Src2
    );
	 //根据Src2选择ALU的输入2

parameter RY = 8'b00000110, ZERO = 8'b00010000, S_IMM4 = 8'b00010100,
	S_IMM5 = 8'b00010101, S_IMM8 = 8'b00010110, ONE = 8'b00100110;

always @(ALU_Src2)
begin
	case (ALU_Src2)
		RY:		Src2 = data_ry;
		ZERO:		Src2 = 0;
		ONE:     Src2 = 16'h0001;
		S_IMM4:	Src2 = imm4;
		S_IMM5:	Src2 = imm5;
		S_IMM8:	Src2 = imm8;
		default:	Src2 = 0;
	endcase
end

endmodule
