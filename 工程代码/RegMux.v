`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:10:33 11/21/2013 
// Design Name: 
// Module Name:    RegMux 
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
module RegMux(
    input [7:0] WBReg,
    input [3:0] regx,
    input [3:0] regy,
    input [3:0] regz,
    output reg [3:0] WriteReg
    );
//根据WBReg选择要写的寄存器

parameter RX = 8'b00000101, RY = 8'b00000110, RZ = 8'b00000111,
	IN = 8'b00001000, SP = 8'b00001001, T = 8'b00001010, EMPTY = 8'b00001011, R5 = 8'b00101001;
//parameter idx_IN = 4'b1100, idx_SP = 4'b1101, idx_T = 4'b1110, idx_EMPTY = 4'b1111;
parameter idx_IN = 4'h9, idx_SP = 4'ha, idx_T = 4'hb, idx_EMPTY = 4'b1111;

always @(WBReg)
begin
	case (WBReg)
		RX:		WriteReg = regx;			//待确认VHDL中index()的含义
		RY:		WriteReg = regy;
		RZ:		WriteReg = regz;
		IN:		WriteReg = idx_IN;
		SP:		WriteReg = idx_SP;
		T:			WriteReg = idx_T;
		R5:      WriteReg = 4'h5;
		EMPTY:	WriteReg = idx_EMPTY;
		default:	WriteReg = 0;
	endcase
end

endmodule
