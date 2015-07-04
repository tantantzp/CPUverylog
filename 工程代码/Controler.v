`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:13:50 11/21/2013 
// Design Name: 
// Module Name:    Controler 
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
module Controler(
    input[15:0] instruction,
    output reg[7:0] ALU_src1,
    output reg[7:0] ALU_src2,
    output reg[7:0] ALUOp,
    output reg[7:0] MemSrc,
    output reg[7:0] PCSrc,
    output reg[7:0] MemRead,
    output reg[7:0] MemWrite,
    output reg[7:0] WBReg,
    output reg[7:0] WBSrc
    );
//MFPC = 5'b11101,BTEQZ = 5'b01100,MTSP = 5'b01100,
parameter ADDU_SUBU = 5'b11100, ADDIU = 5'b01001, ADDIU3 = 5'b01000,
          ADDSP_BTEQZ_MTSP = 5'b01100, AND_OR_CMP_JALR_NOT_SLT_JR_MFPC = 5'b11101,
			 B = 5'b00010, BEQZ = 5'b00100, BNEZ = 5'b00101, 
			 LI = 5'b01101, LW = 5'b10011, LW_SP = 5'b10010,
			 SW = 5'b11011, SW_SP = 5'b11010, MFIN_MTIN = 5'b11110,
			 SLL_SRA = 5'b00110,INT = 5'b11111,
			 NOP = 5'b00001, CMPI = 5'b01110, ADDSP3 = 5'b00000;

parameter NEXT = 8'b00000001, BRANCH8 = 8'b00000010, BRANCH11 = 8'b00000011,
			 JUMP = 8'b00000100, RX = 8'b00000101, RY = 8'b00000110, RZ = 8'b00000111,
			 IN = 8'b00001000, SP = 8'b00001001, T = 8'b00001010, EMPTY = 8'b00001011,
			 idx_IN = 8'b00001001, idx_SP = 8'b00001010, idx_T = 8'b00001011,
			 idx_EMPTY = 8'b00001111, ZERO = 8'b00010000, Z_IMM3 = 8'b00010001,
			 Z_IMM8 = 8'b00010010, PC = 8'b00010011, S_IMM4 = 8'b00010100,
			 S_IMM5 = 8'b00010101, S_IMM8 = 8'b00010110, ALU_RES = 8'b00010111,
			 MEM_READ = 8'b00011000, ADD = 8'b00011001, SUB = 8'b00011010,
			 AND = 8'b00011011, OR = 8'b00011100, XOR = 8'b00011101, NOT = 8'b00011110,
			 SLL = 8'b00011111, SRL = 8'b00100000, SRA = 8'b00100001, ROL = 8'b00100010,
			 EQUAL = 8'b00100011, NEQUAL = 8'b00100100, LESSTHEN = 8'b00100101,
			 ONE = 8'b00100110, RA = 8'b00100111, INTJUMP = 8'b00101000, R5 = 8'b00101001;

wire[1:0] FUN2;
wire[4:0] CODE, FUN5;
wire[7:0] FUN8;
wire[2:0] FUN3;


assign FUN2 = instruction[1:0];
assign CODE = instruction[15:11];
assign FUN5 = instruction[4:0];
assign FUN8 = instruction[7:0];
assign FUN3 = instruction[10:8];
always @(instruction)
begin
    case(CODE)
	     ADDU_SUBU: begin
				if(FUN2 == 2'b01) begin  //ADDU
					ALU_src1 = RX;
					ALU_src2 = RY;
					ALUOp = ADD;
					MemSrc = EMPTY;
					PCSrc = NEXT;
					MemRead = 0;
					MemWrite = 0;
					WBReg = RZ;
					WBSrc = ALU_RES;					
				end
				else begin               //SUBU
					ALU_src1 = RX;
					ALU_src2 = RY;
					ALUOp = SUB;
					MemSrc = EMPTY;
					PCSrc = NEXT;
					MemRead = 0;
					MemWrite = 0;
					WBReg = RZ;
					WBSrc = ALU_RES;					
				end
		  end
	     ADDIU: begin						//ADDIU
		      ALU_src1 = RX;
				ALU_src2 = S_IMM8;
				ALUOp = ADD;
				MemSrc = EMPTY;
				PCSrc = NEXT;
				MemRead = 0;
				MemWrite = 0;
				WBReg = RX;
				WBSrc = ALU_RES;
		  end
	     ADDIU3: begin					//ADDIU3
		      ALU_src1 = RX;
				ALU_src2 = S_IMM4;
				ALUOp = ADD;
				MemSrc = EMPTY;
				PCSrc = NEXT;
				MemRead = 0;
				MemWrite = 0;
				WBReg = RY;
				WBSrc = ALU_RES;
		  end
		  ADDSP_BTEQZ_MTSP: begin
		      case(FUN3)
				    3'b011: begin   //ADDSP
						ALU_src1 = SP;
						ALU_src2 = S_IMM8;
						ALUOp = ADD;
						MemSrc = EMPTY;
						PCSrc = NEXT;
						MemRead = 0;
						MemWrite = 0;
						WBReg = SP;
						WBSrc = ALU_RES;					 
					 end
					 3'b000: begin   //BTEQZ
						ALU_src1 = T;
						ALU_src2 = ZERO;
						ALUOp = EQUAL;
						MemSrc = EMPTY;
						PCSrc = BRANCH8;
						MemRead = 0;
						MemWrite = 0;
						WBReg = EMPTY;
						WBSrc = EMPTY;					 
					 end
					 3'b100: begin   //MTSP
						ALU_src1 = ZERO;
						ALU_src2 = RY;
						ALUOp = ADD;
						MemSrc = EMPTY;
						PCSrc = NEXT;
						MemRead = 0;
						MemWrite = 0;
						WBReg = SP;
						WBSrc = ALU_RES;					 
					 end
				endcase
		  end

	     AND_OR_CMP_JALR_NOT_SLT_JR_MFPC: begin
				case (FUN5)
					5'b00000:	begin
										if (FUN8 == 8'b11000000)	//JALR
										begin
											ALU_src1 = PC;
											ALU_src2 = ONE;
											ALUOp = ADD;
											MemSrc = EMPTY;
											PCSrc = JUMP;
											MemRead = 0;
											MemWrite = 0;
											WBReg = RA;
											WBSrc = ALU_RES;
										end
										else										//JR
										if(FUN8 == 8'b00000000)
										begin
											ALU_src1 = ZERO;
											ALU_src2 = ZERO;
											ALUOp = EQUAL;
											MemSrc = EMPTY;
											PCSrc = JUMP;
											MemRead = 0;
											MemWrite = 0;
											WBReg = EMPTY;
											WBSrc = EMPTY;
										end
										else
										begin                 //MFPC
											ALU_src1 = PC;
											ALU_src2 = ZERO;
											ALUOp = ADD;
											MemSrc = EMPTY;
											PCSrc = NEXT;
											MemRead = 0;
											MemWrite = 0;
											WBReg = RX;
											WBSrc = ALU_RES;															
										end
									end
					5'b01100:	begin								//AND
										ALU_src1 = RX;
										ALU_src2 = RY;
										ALUOp = AND;
										MemSrc = EMPTY;
										PCSrc = NEXT;
										MemRead = 0;
										MemWrite = 0;
										WBReg = RX;
										WBSrc = ALU_RES;
									end
					5'b01101:	begin								//OR
										ALU_src1 = RX;
										ALU_src2 = RY;
										ALUOp = OR;
										MemSrc = EMPTY;
										PCSrc = NEXT;
										MemRead = 0;
										MemWrite = 0;
										WBReg = RX;
										WBSrc = ALU_RES;
									end
					5'b01010:	begin								//CMP
										ALU_src1 = RX;
										ALU_src2 = RY;
										ALUOp = EQUAL;
										MemSrc = EMPTY;
										PCSrc = NEXT;
										MemRead = 0;
										MemWrite = 0;
										WBReg = T;
										WBSrc = ALU_RES;
									end
					5'b01111:	begin								//NOT
										ALU_src1 = ZERO;
										ALU_src2 = RY;
										ALUOp = NOT;
										MemSrc = EMPTY;
										PCSrc = NEXT;
										MemRead = 0;
										MemWrite = 0;
										WBReg = RX;
										WBSrc = ALU_RES;
									end
					5'b00010:	begin								//SLT
										ALU_src1 = RX;
										ALU_src2 = RY;
										ALUOp = LESSTHEN;
										MemSrc = EMPTY;
										PCSrc = NEXT;
										MemRead = 0;
										MemWrite = 0;
										WBReg = T;
										WBSrc = ALU_RES;
									end
				endcase
		  end
	     B: begin							//B
		      ALU_src1 = ZERO;
				ALU_src2 = ZERO;
				ALUOp = EMPTY;
				MemSrc = EMPTY;
				PCSrc = BRANCH11;
				MemRead = 0;
				MemWrite = 0;
				WBReg = EMPTY;
				WBSrc = EMPTY;
		  end
	     BEQZ: begin						//BEQZ
		      ALU_src1 = RX;
				ALU_src2 = ZERO;
				ALUOp = EQUAL;
				MemSrc = EMPTY;
				PCSrc = BRANCH8;
				MemRead = 0;
				MemWrite = 0;
				WBReg = EMPTY;
				WBSrc = EMPTY;
		  end
	     BNEZ: begin						//BNEZ
		      ALU_src1 = RX;
				ALU_src2 = ZERO;
				ALUOp = NEQUAL;
				MemSrc = EMPTY;
				PCSrc = BRANCH8;
				MemRead = 0;
				MemWrite = 0;
				WBReg = EMPTY;
				WBSrc = EMPTY;
		  end

	     LI: begin							//LI
		      ALU_src1 = Z_IMM8;
				ALU_src2 = ZERO;
				ALUOp = ADD;
				MemSrc = EMPTY;
				PCSrc = NEXT;
				MemRead = 0;
				MemWrite = 0;
				WBReg = RX;
				WBSrc = ALU_RES;
		  end
	     LW: begin							//LW
		      ALU_src1 = RX;
				ALU_src2 = S_IMM5;
				ALUOp = ADD;
				MemSrc = EMPTY;
				PCSrc = NEXT;
				MemRead = 1'b1;
				MemWrite = 1'b0;
				WBReg = RY;
				WBSrc = MEM_READ;
		  end
	     LW_SP: begin
		      ALU_src1 = SP;
				ALU_src2 = S_IMM8;
				ALUOp = ADD;
				MemSrc = EMPTY;
				PCSrc = NEXT;
				MemRead = 1'b1;
				MemWrite = 1'b0;
				WBReg = RX;
				WBSrc = MEM_READ;
		  end
	     SW: begin
		      ALU_src1 = RX;
				ALU_src2 = S_IMM5;
				ALUOp = ADD;
				MemSrc = RY;
				PCSrc = NEXT;
				MemRead = 1'b0;
				MemWrite = 1'b1;
				WBReg = EMPTY;
				WBSrc = EMPTY;
		  end
	     SW_SP: begin
		      ALU_src1 = SP;
				ALU_src2 = S_IMM8;
				ALUOp = ADD;
				MemSrc = RX;
				PCSrc = NEXT;
				MemRead = 1'b0;
				MemWrite = 1'b1;
				WBReg = EMPTY;
				WBSrc = EMPTY;
		  end
	     MFIN_MTIN: begin
		      if(FUN2 == 2'b00) begin  //MFIN
					ALU_src1 = IN;
					ALU_src2 = ZERO;
					ALUOp = ADD;
					MemSrc = EMPTY;
					PCSrc = NEXT;
					MemRead = 0;
					MemWrite = 0;
					WBReg = RX;
					WBSrc = ALU_RES;					
				end
				else begin               //MTIN
					ALU_src1 = RX;
					ALU_src2 = ZERO;
					ALUOp = ADD;
					MemSrc = EMPTY;
					PCSrc = NEXT;
					MemRead = 0;
					MemWrite = 0;
					WBReg = IN;
					WBSrc = ALU_RES;					
				end
		  end

	     SLL_SRA: begin
		      if(FUN2 == 2'b00) begin  //SLL
					ALU_src1 = Z_IMM3;
					ALU_src2 = RY;
					ALUOp = SLL;
					MemSrc = EMPTY;
					PCSrc = NEXT;
					MemRead = 0;
					MemWrite = 0;
					WBReg = RX;
					WBSrc = ALU_RES;					
				end
				else begin               //SRA
					ALU_src1 = Z_IMM3;
					ALU_src2 = RY;
					ALUOp = SRA;
					MemSrc = EMPTY;
					PCSrc = NEXT;
					MemRead = 0;
					MemWrite = 0;
					WBReg = RX;
					WBSrc = ALU_RES;					
				end

		  end
	     NOP : begin
		      ALU_src1 = ZERO;
				ALU_src2 = ZERO;
				ALUOp = EMPTY;
				MemSrc = EMPTY;
				PCSrc = NEXT;
				MemRead = 0;
				MemWrite = 0;
				WBReg = EMPTY;
				WBSrc = EMPTY;
		  end
	     CMPI: begin
		      ALU_src1 = RX;
				ALU_src2 = S_IMM8;
				ALUOp = EQUAL;
				MemSrc = EMPTY;
				PCSrc = NEXT;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				WBReg = T;
				WBSrc = ALU_RES;
		  end
	     ADDSP3: begin
		      ALU_src1 = SP;
				ALU_src2 = S_IMM8;
				ALUOp = ADD;
				MemSrc = EMPTY;
				PCSrc = NEXT;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				WBReg = RX;
				WBSrc = ALU_RES;
		  end
		  INT: begin
		      ALU_src1 = PC;
				ALU_src2 = ZERO;
				ALUOp = ADD;
				MemSrc = EMPTY;
				PCSrc = INTJUMP;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				WBReg = R5;
				WBSrc = ALU_RES;
		  end		  
		  default: begin
		      ALU_src1 = ZERO;
				ALU_src2 = ZERO;
				ALUOp = EMPTY;
				MemSrc = EMPTY;
				PCSrc = NEXT;
				MemRead = 0;
				MemWrite = 0;
				WBReg = EMPTY;
				WBSrc = EMPTY;  
		  end
	 endcase
end



endmodule
