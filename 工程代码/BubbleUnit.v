`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:59:24 11/21/2013 
// Design Name: 
// Module Name:    BubbleUnit 
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
module BubbleUnit(
    input [7:0] ID_Src1,
    input [7:0] ID_Src2,
    input [7:0] ID_MemSrc,
    input [7:0] ID_PCSrc,
    input [3:0] ID_rx_index,
    input [3:0] ID_ry_index,
    input EXE_MemRead,
    input [3:0] EXE_WBReg,
    input MEM_zero,
    input [7:0] MEM_PCSrc,
    output LoadSlot,
    output BranchSlot
    );
	 //根据上一条指令是否为读内存且写当前指令使用的寄存器，判断是否需要插入Load延迟
	 //根据前面第三条指令是否跳转且成功，判断是否需要清空上一条指令的影响（前面第二条指令默认为NOP且执行）

parameter NEXT = 8'b00000001, JUMP = 8'b00000100, SP = 8'b00001001, idx_SP = 4'b1010, RX = 8'b00000101, RY = 8'b00000110;
wire both_SP, both_rx, both_ry;

assign	BranchSlot = ((MEM_zero == 1) && (MEM_PCSrc != NEXT));
assign	LoadSlot = (EXE_MemRead && (both_SP || both_rx || both_ry));
assign	both_SP = (ID_Src1 == SP) && (EXE_WBReg == idx_SP);
assign	both_rx = ((ID_Src1 == RX) || (ID_MemSrc == RX) || (ID_PCSrc == JUMP)) && (EXE_WBReg == ID_rx_index);
assign	both_ry = ((ID_Src2 == RY) || (ID_MemSrc == RY)) && (EXE_WBReg == ID_ry_index);
/*
always @(*)
begin

end*/

endmodule
