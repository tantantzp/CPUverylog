`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:37:56 11/21/2013 
// Design Name: 
// Module Name:    MEM_WB_Reg 
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
module MEM_WB_Reg(
    input CLK,
    input RST,
    input boot,
    input [3:0] WBReg_in,
    input [7:0] WBSrc_in,
    input [15:0] ALU_result_in,
    input [15:0] Ramdata_in,
    output reg [3:0] WBReg_out,
    output reg [7:0] WBSrc_out,
    output reg [15:0] ALU_result_out,
    output reg [15:0] Ramdata_out
    );
	 //�μ�Ĵ�����������д�����ݣ�rstʱ�������

parameter idx_EMPTY = 8'b00001111, EMPTY = 8'b00001011;
wire RSTboot;
assign RSTboot = RST && boot;			//������������,boot�ĺ��壿

always @(negedge RSTboot, posedge CLK)
begin
	if (RSTboot == 0)
	begin
		WBReg_out <= idx_EMPTY;
		WBSrc_out <= EMPTY;
		ALU_result_out <= 0;				//��ȷ��others => '0'������
		Ramdata_out <= 0;
	end
	else
	begin
		WBReg_out <= WBReg_in;
		WBSrc_out <= WBSrc_in;
		ALU_result_out <= ALU_result_in;
		Ramdata_out <= Ramdata_in;
	end
end

endmodule
