`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:08:46 11/21/2013 
// Design Name: 
// Module Name:    ID_EXE_Reg 
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
module ID_EXE_Reg(
    input CLK,
    input RST,
    input boot,
    input Slot,
    input [7:0] ALU_Src1_in,
    input [7:0] ALU_Src2_in,
    input [7:0] ALUOp_in,
    input [7:0] MemSrc_in,
    input [7:0] PCSrc_in,
    input MemRead_in,
    input MemWrite_in,
    input [3:0] WBReg_in,
    input [7:0] WBSrc_in,
    input [15:0] rxdata_in,
    input [15:0] rydata_in,
    input [15:0]IN_in,
    input [15:0]SP_in,
    input [15:0]T_in,
    input [15:0] pc_in,
    input [10:0] immediate_in,
    input [3:0] rx_index_in,
    input [3:0] ry_index_in,
    output reg [7:0] ALU_Src1_out,
    output reg [7:0] ALU_Src2_out,
    output reg [7:0] ALUOp_out,
    output reg [7:0] MemSrc_out,
    output reg [7:0] PCSrc_out,
    output reg MemRead_out,
    output reg MemWrite_out,
    output reg [3:0] WBReg_out,
    output reg [7:0] WBSrc_out,
    output reg [15:0] rxdata_out,
    output reg [15:0] rydata_out,
    output reg [15:0]IN_out,
    output reg [15:0]SP_out,
    output reg [15:0]T_out,
    output reg [15:0] pc_out,
    output reg [10:0] immediate_out,
    output reg [3:0] rx_index_out,
    output reg [3:0] ry_index_out
    );
	 //段间寄存器，上升沿写入数据，rst时输出清零


parameter ZERO = 8'b00010000, EMPTY = 8'b00001011, NEXT = 8'b00000001, idx_EMPTY = 8'b00001111, PC_START = 16'h0000;
wire RSTboot;
assign RSTboot = RST && boot;			//这句可能有问题,boot的含义？

always @(negedge RSTboot, posedge CLK)
begin
	if (RSTboot == 0)
	begin
		ALU_Src1_out <= ZERO;
		ALU_Src2_out <= ZERO;
		ALUOp_out <= EMPTY;
		MemSrc_out <= EMPTY;
		PCSrc_out <= NEXT;
		MemRead_out <= 0;
		MemWrite_out <= 0;
		WBReg_out <= idx_EMPTY;
		WBSrc_out <= EMPTY;
		rx_index_out <= idx_EMPTY;
		ry_index_out <= idx_EMPTY;
		rxdata_out <= 0;
		rydata_out <= 0;
		IN_out <= 0;
		SP_out <= 0;
		T_out <= 0;
		pc_out <= PC_START;
		immediate_out <= 0;
	end
	else
	begin
		if (Slot)			//NOP
		begin
			ALU_Src1_out <= ZERO;
			ALU_Src2_out <= ZERO;
			ALUOp_out <= EMPTY;
			MemSrc_out <= EMPTY;
			PCSrc_out <= NEXT;
			MemRead_out <= 0;
			MemWrite_out <= 0;
			WBReg_out <= idx_EMPTY;
			WBSrc_out <= EMPTY;
			rx_index_out <= rx_index_in;
			ry_index_out <= ry_index_in;
			rxdata_out <= rxdata_in;
			rydata_out <= rydata_in;
			IN_out <= IN_in;
			SP_out <= SP_in;
			T_out <= T_in;
			pc_out <= pc_in;
			immediate_out <= immediate_in;
		end
		else
		begin
			ALU_Src1_out <= ALU_Src1_in;
			ALU_Src2_out <= ALU_Src2_in;
			ALUOp_out <= ALUOp_in;
			MemSrc_out <= MemSrc_in;
			PCSrc_out <= PCSrc_in;
			MemRead_out <= MemRead_in;
			MemWrite_out <= MemWrite_in;
			WBReg_out <= WBReg_in;
			WBSrc_out <= WBSrc_in;
			rx_index_out <= rx_index_in;
			ry_index_out <= ry_index_in;
			rxdata_out <= rxdata_in;
			rydata_out <= rydata_in;
			IN_out <= IN_in;
			SP_out <= SP_in;
			T_out <= T_in;
			pc_out <= pc_in;
			immediate_out <= immediate_in;
		end
	end
end

endmodule

