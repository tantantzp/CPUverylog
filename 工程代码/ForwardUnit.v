`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:46:56 11/21/2013 
// Design Name: 
// Module Name:    ForwardUnit 
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
module ForwardUnit(
    input [15:0] rxdata_in,
    input [15:0] rydata_in,
    input [15:0] IN_in,
    input [15:0] SP_in,
    input [15:0] T_in,
    input [3:0] rx_index,
    input [3:0] ry_index,
    input [3:0] MEM_WBReg,
    input [3:0] WB_WBReg,
    input [15:0] MEM_ALUResult,
    input [15:0] WB_WBData,
    output reg [15:0] rxdata_out,
    output reg [15:0] rydata_out,
    output reg [15:0] IN_out,
    output reg [15:0] SP_out,
    output reg [15:0] T_out
    );
	 //数据旁路，接收MEM段（上一条指令），WB段（上两条指令）的数据，选择是否通过旁路传递数据

parameter idx_IN = 4'b1001, idx_SP = 4'b1010, idx_T = 4'b1011;
reg [15:0] rxdata_else, rydata_else, IN_else, SP_else, T_else;

//rx_index
always @(MEM_WBReg, rx_index)
begin
	if (MEM_WBReg == rx_index)
		rxdata_out = MEM_ALUResult;
	else
		rxdata_out = rxdata_else;
end

always @(WB_WBReg, rx_index)
begin
	if (WB_WBReg == rx_index)
		rxdata_else = WB_WBData;
	else
		rxdata_else = rxdata_in;
end

//ry_index
always @(MEM_WBReg, ry_index)
begin
	if (MEM_WBReg == ry_index)
		rydata_out = MEM_ALUResult;
	else
		rydata_out = rydata_else;
end

always @(WB_WBReg, ry_index)
begin
	if (WB_WBReg == ry_index)
		rydata_else = WB_WBData;
	else
		rydata_else = rydata_in;
end

//idx_IN
always @(MEM_WBReg)
begin
	if (MEM_WBReg == idx_IN)
		IN_out = MEM_ALUResult;
	else
		IN_out = IN_else;
end

always @(WB_WBReg)
begin
	if (WB_WBReg == idx_IN)
		IN_else = WB_WBData;
	else
		IN_else = IN_in;
end

//idx_SP
always @(MEM_WBReg)
begin
	if (MEM_WBReg == idx_SP)
		SP_out = MEM_ALUResult;
	else
		SP_out = SP_else;
end

always @(WB_WBReg)
begin
	if (WB_WBReg == idx_SP)
		SP_else = WB_WBData;
	else
		SP_else = SP_in;
end

//idx_T
always @(MEM_WBReg)
begin
	if (MEM_WBReg == idx_T)
		T_out = MEM_ALUResult;
	else
		T_out = T_else;
end

always @(WB_WBReg)
begin
	if (WB_WBReg == idx_T)
		T_else = WB_WBData;
	else
		T_else = T_in;
end

endmodule