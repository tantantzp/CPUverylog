`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:12:40 11/21/2013 
// Design Name: 
// Module Name:    ALU_Src1Mux 
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
module ALU_Src1Mux(
    input [15:0] data_rx,
    input [15:0] imm3,
    input [15:0] imm8,
    input [15:0] data_IN,			//添加了前缀data_
    input [15:0] data_SP,
    input [15:0] data_T,
    input [15:0] data_pc,
    input [7:0] ALU_Src1,
    output reg [15:0] Src1
    );
	 //根据Src1选择ALU的输入1

parameter ZERO = 8'b00010000, RX = 8'b00000101, Z_IMM3 = 8'b00010001,
	Z_IMM8 = 8'b00010010, IN = 8'b00001000, SP = 8'b00001001,
	T = 8'b00001010, PC = 8'b00010011;

always @(ALU_Src1)
begin
	case (ALU_Src1)
		RX:		Src1 = data_rx;
		ZERO:		Src1 = 0;
		Z_IMM3:	Src1 = imm3;
		Z_IMM8:	Src1 = imm8;
		IN:		Src1 = data_IN;
		SP:		Src1 = data_SP;
		T:			Src1 = data_T;
		PC:		Src1 = data_pc;
		default:	Src1 = 0;
	endcase
end

endmodule
