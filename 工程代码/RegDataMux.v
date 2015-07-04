`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:39:10 11/21/2013 
// Design Name: 
// Module Name:    RegDataMux 
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
module RegDataMux(
    input [7:0] WBSrc,
    input [15:0] ALU_result,
    input [15:0] Ramdata,
    output reg [15:0] WBData
    );
	 //根据WBSrc选择写回寄存器的数据

parameter ALU_RES = 8'b00010111, MEM_READ = 8'b00011000, EMPTY = 8'b00001011;

always @(WBSrc)
begin
	case (WBSrc)
		ALU_RES:		WBData = ALU_result;
		MEM_READ:	WBData = Ramdata;
		EMPTY:		WBData = 0;
		default:		WBData = 0;
	endcase
end

endmodule
