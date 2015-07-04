`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:50:54 11/21/2013 
// Design Name: 
// Module Name:    CPU 
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
  module CPU(
    //input CLK,
    input CLK_50m,
    input RST,
    output ram1_en,
    output ram1_oe,
    output ram1_rw,
    output ram2_en,
    output ram2_oe,
    output ram2_rw,
    output [17:0] ram1_address,
    output [17:0] ram2_address,
    inout [15:0] ram1_data,
    inout [15:0] ram2_data,
  	 input tbre, tsre, data_ready,
	 output rdn, wrn,
	 input [15:0] inputSW,
	 output reg[15:0] display
	 /*output vgaHs, vgaVs,
    output [2:0] vgaR, vgaG, vgaB*/
    );


    reg CLK;
	 integer count;
    always @(posedge CLK_50m) 
	 begin
	     if(count < 2) begin
		    count = count + 1;
		  end
		  else begin
		     count = 0;
	        CLK <= ~CLK;		  
		  end

	 end
	 wire[15:0]	reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, 
	            reg8, regIN, regSP, regT;
//-----------IF--------------------------

	 wire[15:0] IF_pc,IF_pc_add, IF_instruction;

//-----------ID---------------------------	 
	 wire[15:0] ID_instruction, ID_rx_data, ID_ry_data, ID_IN, ID_SP, ID_T,
	           ID_pc_normal;
	 
	 wire[10:0] ID_imm;	 
	 
	 wire[7:0] ID_ALU_Src1, ID_ALU_Src2, ID_ALUOp, ID_MemSrc, ID_PCSrc,
	          ID_WBReg, ID_WBSrc;

    wire[3:0] ID_rx_id, ID_ry_id, ID_rz_id, ID_WriteReg_id;
	 
	 wire ID_MemRead, ID_MemWrite;
//-----------EXE-------------------------
    wire[15:0] EXE_rx_datatmp, EXE_ry_datatmp, EXE_IN_tmp, EXE_SP_tmp, EXE_T_tmp,
              EXE_rx_data, EXE_ry_data, EXE_IN, EXE_SP, EXE_T,
				  EXE_z_imm3, EXE_z_imm8, EXE_s_imm4, EXE_s_imm5, EXE_s_imm8,
				  EXE_pc_normal, EXE_pc_branch8, EXE_pc_branch11, EXE_pc_jump,
				  EXE_ALU_data1, EXE_ALU_data2, EXE_ALU_result, EXE_Mem_data;
	 wire[10:0] EXE_imm;
	
	 wire[7:0]  EXE_ALU_Src1, EXE_ALU_Src2, EXE_ALUOp, EXE_MemSrc, EXE_PCSrc,
	           EXE_WBSrc;
				  
	 wire[3:0]  EXE_rx_id, EXE_ry_id, EXE_WriteReg_id;
     
	 wire  EXE_MemRead, EXE_MemWrite, EXE_zero;
 

//-----------MEM-------------------------
    wire[15:0]  MEM_pc_branch8, MEM_pc_branch11, MEM_pc_jump,
               MEM_ALU_result, MEM_Mem_data, MEM_Mem_result;	 
	 
	 wire[7:0]   MEM_PCSrc, MEM_WBSrc;
	 
	 wire[3:0]   MEM_WriteReg_id;
	 
	 wire  MEM_MemRead, MEM_MemWrite, MEM_zero;
//-----------WB-------------------------
    wire[15:0]  WB_ALU_result, WB_Mem_result, WB_WBData;	 
	 
	 wire[7:0]  WB_WBSrc;
	 
	 wire[3:0]  WB_WriteReg_id;

//-----------Others-------------------------
    wire RamSlot, IOSlot, Slot, top_boot;
	 wire LoadSlot, BranchSlot;


assign IF_pc_add = IF_pc + 16'b0000000000000001;
assign ID_rx_id = ID_instruction[10:8];
assign ID_ry_id = ID_instruction[7:5];
assign ID_rz_id = ID_instruction[4:2];
assign ID_imm = ID_instruction[10:0];

assign EXE_z_imm3 = {{13{1'b0}}, EXE_imm[4:2]};
assign EXE_z_imm8 = {{8{1'b0}}, EXE_imm[7:0]};
assign EXE_s_imm4 = {{12{EXE_imm[3]}}, EXE_imm[3:0]};
assign EXE_s_imm5 = {{11{EXE_imm[4]}}, EXE_imm[4:0]};
assign EXE_s_imm8 = {{8{EXE_imm[7]}}, EXE_imm[7:0]};

assign EXE_pc_branch8 = EXE_pc_normal + {{8{EXE_imm[7]}}, EXE_imm[7:0]};
assign EXE_pc_branch11 = EXE_pc_normal + {{5{EXE_imm[10]}}, EXE_imm[10:0]};
assign EXE_pc_jump = EXE_rx_data;



assign IOSlot = LoadSlot || RamSlot;
//assign Slot = IOSlot || BranchSlot;
assign Slot = LoadSlot || BranchSlot;
assign top_boot = 1'b1;//(RST == 1'b0)? 1'b1: 1'b0;


	 
 always @(inputSW)
 begin
	  case(inputSW)
			16'h0000:   display = IF_pc;
			16'h0001:   display = IF_instruction;
			16'h0002:   display = ID_instruction;
			16'h0003:   display = {ID_ALU_Src1, ID_ALU_Src2};
			16'h0004:   display = {ID_ALUOp, ID_MemSrc};
			16'h0005:   display = {ID_PCSrc, ID_WBReg};
			16'h0006:   display = {ID_WBReg, ID_WBSrc};
			16'h0007:   display = {ID_MemRead, ID_MemWrite};
			16'h0008:   display = {EXE_ALU_Src1, EXE_ALU_Src2};
			16'h0009:   display = {EXE_ALUOp, EXE_MemSrc};
			16'h000a:   display = EXE_ALU_result;
			16'h000b:   display = EXE_Mem_data;
			16'h000c:   display = EXE_ALU_data1;
			16'h000d:   display = EXE_ALU_data2;			
			16'h000e:   display = {MEM_PCSrc, MEM_WBSrc};
			16'h000f:   display = MEM_WriteReg_id;
			16'h0010:   display = WB_ALU_result;
			16'h0011:   display = WB_Mem_result;
			16'h0012:   display = WB_WBData;
			16'h0013:   display = {RamSlot, IOSlot, Slot, top_boot, LoadSlot, BranchSlot};
			16'h0014:   display = ID_pc_normal;
			16'h0015:   display = IF_pc_add;	
			16'h0016:   display = EXE_pc_branch8;
			16'h0017:   display = EXE_pc_branch11;
			16'h0018:   display = EXE_pc_jump;  
			16'h0019:   display = EXE_PCSrc; 
			16'h001a:   display = EXE_zero; 
			16'h001b:   display = MEM_zero;			
			16'h001c:   display = EXE_rx_datatmp;
			16'h001d:   display = EXE_ry_datatmp;
			16'h001e:   display = EXE_IN_tmp;
			16'h001f:   display = EXE_SP_tmp;
			16'h0020:   display = EXE_s_imm8;
			16'h0021:   display = EXE_s_imm5;
			16'h0022:   display = MEM_Mem_data;
			16'h0023:   display = MEM_Mem_result;
			16'h0024:   display = ID_rx_data;
			16'h0025:   display = ID_ry_data;
			16'h0026:   display = {ID_rx_id, ID_ry_id, ID_rz_id, ID_WriteReg_id};
			16'h0027:   display = WB_WriteReg_id;
			16'h0028:   display = WB_WBData;
			16'h0029:   display = WB_ALU_result;
			16'h002a:   display = WB_WBSrc;		
         16'h002b:   display = {EXE_MemRead, EXE_MemWrite};			
         16'h002c:   display = ID_SP;
         16'h002d:   display = ID_IN;
         16'h002e:   display = ID_T;	
         16'h002f:   display = MEM_pc_jump; 		

         16'h0100:   display = reg0;
         16'h0101:   display = reg1;
         16'h0102:   display = reg2;
         16'h0103:   display = reg3;
         16'h0104:   display = reg4;
         16'h0105:   display = reg5;
         16'h0106:   display = reg6;
         16'h0107:   display = reg7;
         16'h0108:   display = reg8;
         16'h0109:   display = regIN;
         16'h010a:   display = regSP;
         16'h010b:   display = regT;

			
         default: display = 16'hffff;			
	  endcase
  end
 

//------------------------------IF  Part------------------------------


PCMux My_PCMux(
    .pc_next(ID_pc_normal),
    .pc_branch8(MEM_pc_branch8),
    .pc_branch11(MEM_pc_branch11),
    .pc_jump(MEM_pc_jump),
    .zero(MEM_zero),
    .PCSrc(MEM_PCSrc),
    .pc(IF_pc)
    );



//------------------------------IF  End------------------------------

IF_ID_Reg My_IF_ID_Reg(
    .RST(RST),
    .boot(top_boot),
    .CLK(CLK),
    //.IOSlot(IOSlot),
	 .ramSlot(RamSlot),
	 .loadSlot(LoadSlot),
    .instruction_in(IF_instruction),
    .pc_in(IF_pc_add),
    .instruction_out(ID_instruction),
    .pc_out(ID_pc_normal)
    );
	 

//------------------------------ID  Part------------------------------	

	 


Controler My_Controler(
    .instruction(ID_instruction),
    .ALU_src1(ID_ALU_Src1),
    .ALU_src2(ID_ALU_Src2),
    .ALUOp(ID_ALUOp),
    .MemSrc(ID_MemSrc),
    .PCSrc(ID_PCSrc),
    .MemRead(ID_MemRead),
    .MemWrite(ID_MemWrite),
    .WBReg(ID_WBReg),
    .WBSrc(ID_WBSrc)
    );

RegMux My_RegMux(
    .WBReg(ID_WBReg),
    .regx(ID_rx_id),
    .regy(ID_ry_id),
    .regz(ID_rz_id),
    .WriteReg(ID_WriteReg_id)
    );

Registers MyRegisters(
    .CLK(CLK),
    .RST(RST),
    .boot(top_boot),
    .readx(ID_rx_id),
    .ready(ID_ry_id),
    .writeReg(WB_WriteReg_id),
    .writeData(WB_WBData),
    .out_rx(ID_rx_data),
    .out_ry(ID_ry_data),
    .out_IN(ID_IN),
    .out_SP(ID_SP),
    .out_T(ID_T),
	 .reg0(reg0),
	 .reg1(reg1),
	 .reg2(reg2),
	 .reg3(reg3),
	 .reg4(reg4),
	 .reg5(reg5),
	 .reg6(reg6),
	 .reg7(reg7),
	 .reg8(reg8),
	 .regIN(regIN),
	 .regSP(regSP),	 
	 .regT(regT)
    );

	 

//------------------------------ID  End------------------------------
ID_EXE_Reg My_ID_EXE_Reg(
    .CLK(CLK),
    .RST(RST),
    .boot(top_boot),
    .Slot(Slot),
    .ALU_Src1_in(ID_ALU_Src1),
    .ALU_Src2_in(ID_ALU_Src2),
    .ALUOp_in(ID_ALUOp),
    .MemSrc_in(ID_MemSrc),
    .PCSrc_in(ID_PCSrc),
    .MemRead_in(ID_MemRead),
    .MemWrite_in(ID_MemWrite),
    .WBReg_in(ID_WriteReg_id),
    .WBSrc_in(ID_WBSrc),
    .rxdata_in(ID_rx_data),
    .rydata_in(ID_ry_data),
    .IN_in(ID_IN),
    .SP_in(ID_SP),
    .T_in(ID_T),
    .pc_in(ID_pc_normal),
    .immediate_in(ID_imm),
    .rx_index_in(ID_rx_id),
    .ry_index_in(ID_ry_id),
    .ALU_Src1_out(EXE_ALU_Src1),
    .ALU_Src2_out(EXE_ALU_Src2),
    .ALUOp_out(EXE_ALUOp),
    .MemSrc_out(EXE_MemSrc),
    .PCSrc_out(EXE_PCSrc),
    .MemRead_out(EXE_MemRead),
    .MemWrite_out(EXE_MemWrite),
    .WBReg_out(EXE_WriteReg_id),
    .WBSrc_out(EXE_WBSrc),
    .rxdata_out(EXE_rx_datatmp),
    .rydata_out(EXE_ry_datatmp),
    .IN_out(EXE_IN_tmp),
    .SP_out(EXE_SP_tmp),
    .T_out(EXE_T_tmp),
    .pc_out(EXE_pc_normal),
    .immediate_out(EXE_imm),
    .rx_index_out(EXE_rx_id),
    .ry_index_out(EXE_ry_id)
    );

//------------------------------EXE Part------------------------------	


ForwardUnit MY_ForwardUnit(
    .rxdata_in(EXE_rx_datatmp),
    .rydata_in(EXE_ry_datatmp),
    .IN_in(EXE_IN_tmp),
    .SP_in(EXE_SP_tmp),
    .T_in(EXE_T_tmp),
    .rx_index(EXE_rx_id),
    .ry_index(EXE_ry_id),
    .MEM_WBReg(MEM_WriteReg_id),
    .WB_WBReg(WB_WriteReg_id),
    .MEM_ALUResult(MEM_ALU_result),
    .WB_WBData(WB_WBData),
    .rxdata_out(EXE_rx_data),
    .rydata_out(EXE_ry_data),
    .IN_out(EXE_IN),
    .SP_out(EXE_SP),
    .T_out(EXE_T)
    );

ALU_Src1Mux My_ALU_Src1Mux(
    .data_rx(EXE_rx_data),
    .imm3(EXE_z_imm3),
    .imm8(EXE_z_imm8),
    .data_IN(EXE_IN),
    .data_SP(EXE_SP),
    .data_T(EXE_T),
    .data_pc(EXE_pc_normal),
    .ALU_Src1(EXE_ALU_Src1),
    .Src1(EXE_ALU_data1)
    );

ALU_Src2Mux My_ALU_Src2Mux(
    .data_ry(EXE_ry_data),
    .imm4(EXE_s_imm4),
    .imm5(EXE_s_imm5),
    .imm8(EXE_s_imm8),
    .ALU_Src2(EXE_ALU_Src2),
    .Src2(EXE_ALU_data2)
    );
	 

ALU My_ALU(
    .input1(EXE_ALU_data1),
    .input2(EXE_ALU_data2),
    .opcode(EXE_ALUOp),
    .result(EXE_ALU_result),
    .zero(EXE_zero)
    );

MemDataMux My_MemDataMux(
    .rx_data(EXE_rx_data),
    .ry_data(EXE_ry_data),
    .MemSrc(EXE_MemSrc),
    .MemData(EXE_Mem_data)
    );


//------------------------------EXE  End------------------------------

EXE_MEM_Reg My_EXE_MEM_Reg(
    .CLK(CLK),
    .RST(RST),
    .boot(top_boot),
    .PCSrc_in(EXE_PCSrc),
    .MemRead_in(EXE_MemRead),
    .MemWrite_in(EXE_MemWrite),
    .WBReg_in(EXE_WriteReg_id),
    .WBSrc_in(EXE_WBSrc),
    .pc_branch8_in(EXE_pc_branch8),
    .pc_branch11_in(EXE_pc_branch11),
    .pc_jump_in(EXE_pc_jump),
    .ALU_result_in(EXE_ALU_result),
    .MemData_in(EXE_Mem_data),
    .zero_in(EXE_zero),
    .PCSrc_out(MEM_PCSrc),
    .MemRead_out(MEM_MemRead),
    .MemWrite_out(MEM_MemWrite),
    .WBReg_out(MEM_WriteReg_id),
    .WBSrc_out(MEM_WBSrc),
    .pc_branch8_out(MEM_pc_branch8),
    .pc_branch11_out(MEM_pc_branch11),
    .pc_jump_out(MEM_pc_jump),
    .ALU_result_out(MEM_ALU_result),
    .MemData_out(MEM_Mem_data),
    .zero_out(MEM_zero)
    );


//------------------------------MEM Part------------------------------\

Ram My_Ram(
    .CLK(CLK),
    .RST(RST),
    .boot(top_boot),
    .ram1_en(ram1_en),
    .ram1_oe(ram1_oe),
    .ram1_rw(ram1_rw),
    .ram2_en(ram2_en),
    .ram2_oe(ram2_oe),
    .ram2_rw(ram2_rw),
    .ram1_addr(ram1_address),
    .ram2_addr(ram2_address),
    .ram1_data(ram1_data),
    .ram2_data(ram2_data),
    .tbre(tbre),
	 .tsre(tsre),
	 .data_ready(data_ready),
	 .rdn(rdn),
	 .wrn(wrn),
    .pc(IF_pc),
    .instruction(IF_instruction),
    /*.addrin(EXE_ALU_result),
    .datain(EXE_Mem_data),
    .MemRead(EXE_MemRead),
    .MemWrite(EXE_MemWrite),*/
    .addrin(MEM_ALU_result),
    .datain(MEM_Mem_data),
    .MemRead(MEM_MemRead),
    .MemWrite(MEM_MemWrite),	
    .dataout(MEM_Mem_result),
    .RamSlot(RamSlot)
    );


//------------------------------MEM  End------------------------------

MEM_WB_Reg My_MEM_WB_Reg(
    .CLK(CLK),
    .RST(RST),
    .boot(top_boot),
    .WBReg_in(MEM_WriteReg_id),
    .WBSrc_in(MEM_WBSrc),
    .ALU_result_in(MEM_ALU_result),
    .Ramdata_in(MEM_Mem_result),
    .WBReg_out(WB_WriteReg_id),
    .WBSrc_out(WB_WBSrc),
    .ALU_result_out(WB_ALU_result),
    .Ramdata_out(WB_Mem_result)
    );

//------------------------------WB  Part------------------------------

RegDataMux My_RegDataMux(
    .WBSrc(WB_WBSrc),
    .ALU_result(WB_ALU_result),
    .Ramdata(WB_Mem_result),
    .WBData(WB_WBData)
    );


//------------------------------WB   END------------------------------


BubbleUnit My_BubbleUnit(
    .ID_Src1(ID_ALU_Src1),
    .ID_Src2(ID_ALU_Src2),
    .ID_MemSrc(ID_MemSrc),
    .ID_PCSrc(ID_PCSrc),
    .ID_rx_index(ID_rx_id),
    .ID_ry_index(ID_ry_id),
    .EXE_MemRead(EXE_MemRead),
    .EXE_WBReg(EXE_WriteReg_id),
    .MEM_zero(MEM_zero),
    .MEM_PCSrc(MEM_PCSrc),
    .LoadSlot(LoadSlot),
    .BranchSlot(BranchSlot)
    );


//------------------------------VGA ------------------------------

/*
wire[159:0] registerVGA = {regT,regSP, reg7, reg6, reg5, reg4, reg3, reg2, reg1, reg0 };


VGATop MyVGATop(
  .clk50M(CLK_50m), 
  .rst(RST),
  .registerVGA(registerVGA),
  .pc(IF_pc),
  .vgaHs(vgaHs), 
  .vgaVs(vgaVs),
  .vgaR(vgaR),
  .vgaG(vgaG),
  .vgaB(vgaB)
);*/

endmodule
