`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:21:43 11/21/2013 
// Design Name: 
// Module Name:    Registers 
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
module Registers(
    input CLK,
    input RST,
    input boot,
    input [3:0] readx,
    input [3:0] ready,
    input [3:0] writeReg,
    input [15:0] writeData,
    output reg[15:0] out_rx,
    output reg[15:0] out_ry,
    output [15:0]out_IN,
    output [15:0]out_SP,
    output [15:0]out_T,
	 
	 output [15:0] reg0,
	 output [15:0] reg1,
	 output [15:0] reg2,
	 output [15:0] reg3,
	 output [15:0] reg4,
	 output [15:0] reg5,
	 output [15:0] reg6,
	 output [15:0] reg7,
	 output [15:0] reg8,
	 output [15:0] regIN,
	 output [15:0] regSP,
	 output [15:0] regT
    );


parameter N = 4'hf, IN_index = 4'h9,
          SP_index = 4'ha, T_index = 4'hb;

wire RSTboot;
reg[15:0] registers[15:0];
reg[3:0] index;

assign RSTboot = RST && boot;

//上升沿读
always @ (readx, ready)
begin
    out_rx = registers[readx];
	 out_ry = registers[ready];
end

assign 	out_IN = registers[IN_index];
assign   out_SP = registers[SP_index];
assign	out_T = registers[T_index];

assign   reg0 = registers[4'h0];
assign   reg1 = registers[4'h1];
assign   reg2 = registers[4'h2];
assign   reg3 = registers[4'h3];
assign   reg4 = registers[4'h4];
assign   reg5 = registers[4'h5];
assign   reg6 = registers[4'h6];
assign   reg7 = registers[4'h7];
assign   reg8 = registers[4'h8];
assign   regIN = registers[4'h9];
assign   regSP = registers[4'ha];
assign   regT = registers[4'hb];



//寄存器堆，下降沿写入数据, RSTboot = 0时所有寄存器清零
always @ (negedge CLK, negedge RSTboot)
begin
    if(RSTboot == 0) begin
        for(index = 0; index < N; index = index + 1) begin
            registers[index] <= 16'h0000;
        end		  
	 end
	 else begin
	     registers[writeReg] <= writeData;
	 end
end

endmodule
