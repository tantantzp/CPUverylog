`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:08:56 11/21/2013 
// Design Name: 
// Module Name:    IF_ID_Reg 
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
module IF_ID_Reg(
    input RST,
    input boot,
    input CLK,
    //input IOSlot,
	 input ramSlot,
    input loadSlot,
	 input [15:0] instruction_in,
    input [15:0] pc_in,
    output reg [15:0] instruction_out,
    output reg [15:0] pc_out
    );
//段间寄存器，上升沿写入数据，RST时输出清零

parameter NOP = 16'h0800, PC_START = 16'h0000;
wire RSTboot;
assign RSTboot = RST && boot;			//这句可能有问题,boot的含义？

always @ (negedge RSTboot, posedge CLK)
begin
	if (RSTboot == 0)
	begin
		instruction_out <= NOP;
		pc_out <= PC_START;
	end
	else
	begin
		if (ramSlot) begin
         instruction_out <= NOP;
		end
		else
		if ((!loadSlot)) begin
			instruction_out <= instruction_in;
			pc_out <= pc_in;
		end
	end
end

endmodule