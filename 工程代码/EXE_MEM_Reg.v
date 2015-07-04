`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:14:10 11/21/2013 
// Design Name: 
// Module Name:    EXE_MEM_Reg 
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
module EXE_MEM_Reg(
    input CLK,
    input RST,
    input boot,
    input [7:0] PCSrc_in,
    input MemRead_in,
    input MemWrite_in,
    input [3:0] WBReg_in,
    input [7:0] WBSrc_in,
    input [15:0] pc_branch8_in,
    input [15:0] pc_branch11_in,
    input [15:0] pc_jump_in,
    input [15:0] ALU_result_in,
    input [15:0] MemData_in,
    input zero_in,
    output reg [7:0] PCSrc_out,
    output reg MemRead_out,
    output reg MemWrite_out,
    output reg [3:0] WBReg_out,
    output reg [7:0] WBSrc_out,
    output reg [15:0] pc_branch8_out,
    output reg [15:0] pc_branch11_out,
    output reg [15:0] pc_jump_out,
    output reg [15:0] ALU_result_out,
    output reg [15:0] MemData_out,
    output reg zero_out
    );
	 //段间寄存器，上升沿写入数据，rst时输出清零

parameter NEXT = 8'b00000001, idx_EMPTY = 4'b1111, EMPTY = 8'b00001011, PC_START = 16'h0000;
wire RSTboot;
assign RSTboot = RST && boot;			//这句可能有问题,boot的含义？

always @(negedge RSTboot, posedge CLK)
begin
	if (RSTboot == 0)
	begin
		PCSrc_out <= NEXT;
		MemRead_out <= 0;				//待确认false等价为0
		MemWrite_out <= 0;
		WBReg_out <= idx_EMPTY;
		WBSrc_out <= EMPTY;
		pc_branch8_out <= PC_START;
		pc_branch11_out <= PC_START;
		pc_jump_out <= PC_START;
		MemData_out <= 0;				//待确认others=>'0'
		ALU_result_out <= 0;
		zero_out <= 0;
	end
	else
	begin
		PCSrc_out <= PCSrc_in;
		MemRead_out <= MemRead_in;
		MemWrite_out <= MemWrite_in;
		WBReg_out <= WBReg_in;
		WBSrc_out <= WBSrc_in;
		
		pc_branch8_out <= pc_branch8_in;
		pc_branch11_out <= pc_branch11_in;
		pc_jump_out <= pc_jump_in;
		MemData_out <= MemData_in;
		ALU_result_out <= ALU_result_in;
		zero_out <= zero_in;
	end
end

endmodule
