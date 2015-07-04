`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:06:23 11/21/2013 
// Design Name: 
// Module Name:    PCMux 
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
module PCMux(
    input [15:0] pc_next,
    input [15:0] pc_branch8,
    input [15:0] pc_branch11,
    input [15:0] pc_jump,
    input zero,
    input [7:0] PCSrc,
    output reg [15:0] pc
    );
//���ݿ����ź�PCSrc��ALU�����������zeroѡ���µ�PC��ֵ

parameter NEXT = 8'b00000001, BRANCH8 = 8'b00000010, BRANCH11 = 8'b00000011, 
          JUMP = 8'b00000100, INTJUMP = 8'b00101000;

reg [15:0] temp;
/*
always @(zero)
begin
	case (zero)
		1:			pc = temp;
		default:	pc = pc_next;
	endcase
end

always @(PCSrc)
begin
	case (PCSrc)
		NEXT:			temp = pc_next;			//pc��1
		BRANCH8:		temp = pc_branch8;		//pc��1��8λ������
		BRANCH11:	temp = pc_branch11;		//pc��1��11λ������
		JUMP:			temp = pc_jump;			//R[x]
		INTJUMP:    temp = 16'h0005;		
		default:		temp = 0;
	endcase
end*/

always @(PCSrc)
begin
	case (PCSrc)
		NEXT:	begin
    		pc = pc_next;			//pc��1
	   end
		BRANCH8: begin
    		if(zero)
			    pc = pc_branch8;		//pc��1��8λ������
		   else
			    pc = pc_next;
		end
		BRANCH11:begin
    		if(zero)
			    pc = pc_branch11;		//pc��1��11λ������
		   else
			    pc = pc_next;
		end
		JUMP:			pc = pc_jump;			//R[x]
		INTJUMP:    pc = 16'h0005;
		default:		pc = 0;
	endcase
end


endmodule
