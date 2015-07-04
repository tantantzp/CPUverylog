`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:53:51 11/21/2013 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [15:0] input1,
    input [15:0] input2,
    input [7:0] opcode,
    output reg[15:0] result,
    output zero
    );

parameter ADD = 8'b00011001,  SUB = 8'b00011010,
		  AND = 8'b00011011,  OR  = 8'b00011100,
		  XOR = 8'b00011101,  NOT = 8'b00011110,
		  SLL = 8'b00011111,  SRL = 8'b00100000,
		  SRA = 8'b00100001,  ROL = 8'b00100010,
		  EQUAL = 8'b00100011, NEQUAL = 8'b00100100,
		  LESSTHEN = 8'b00100101, ONE = 8'b00100110,
		  EMPTY = 8'b00001011;
  
assign zero = (result == 0)? 1'b1: 1'b0;

always @(opcode)
begin
  case (opcode)
      ADD: result = input1 + input2;
      SUB: result = input1 - input2;
		AND: result = input1 & input2;
      OR:  result = input1 | input2;
      XOR: result = input1 ^ input2;
      NOT: result = ~input2;
      SLL: begin
		    if(input1 == 0)   result = input2 << 4'b1000;
			 else  result = input2 << input1;
        end
		SRL: begin
		    if(input1 == 0)  result = input2 >> 4'b1000;
			 else result = input2 >> input1;
        end
		SRA:  begin
		    if(input1 == 0)  result = input2 >>> 4'b1000;
			 else result = input2 >>> input1;
      end
      //ROL: result = (input1 << input2[3:0]) | input1 >> (16 - input2[3:0]);
		EQUAL: 
		    if(input1 == input2) result = 0;
			 else  result = ONE;
      NEQUAL:
		    if(input1 == input2) result = ONE;
			 else  result = 0;
		LESSTHEN:
			 if(input1 < input2) result = ONE;
			 else  result = 0;
		EMPTY:
		    result = 0;
		default: result = opcode;
	endcase
end

endmodule
