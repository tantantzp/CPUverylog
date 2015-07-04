`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:55:53 11/21/2013 
// Design Name: 
// Module Name:    MemDataMux 
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
module MemDataMux(
    input [15:0] rx_data,
    input [15:0] ry_data,
    input [7:0] MemSrc,
    output reg [15:0] MemData
    );
	 //根据MemSrc选择写回DataRam的数据

parameter RX = 8'b00000101, RY = 8'b00000110, EMPTY = 8'b00001011;	 

always @(MemSrc)
begin
	case (MemSrc)
		RX:		MemData = rx_data;
		RY:		MemData = ry_data;
		EMPTY:	MemData = 0;
	endcase
end

endmodule