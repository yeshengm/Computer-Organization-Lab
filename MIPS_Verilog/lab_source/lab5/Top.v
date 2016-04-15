`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:20:44 03/03/2016 
// Design Name: 
// Module Name:    Top 
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
module Top(
    CLK,
    RESET
    );
	 input CLK;
	 input RESET;
	 
	 reg [31:0] INST;
	 reg [7:0] instMem[0:127];
	 reg [31:0] PC;
	 
	 initial
	 begin
		$readmemb("./src/my_inst_mem.txt", instMem);
	 end
	 
	 // Ctr
	 wire REG_DST;
	 wire JUMP;
	 wire BRANCH;
	 wire MEM_READ;
	 wire MEM_TO_REG;
	 wire [1:0] ALU_OP;
	 wire MEM_WRITE;
	 wire ALU_SRC;
	 wire REG_WRITE;
	 Ctr mainCtr(
		.opCode(INST[31:26]),
		.regDst(REG_DST),
		.jump(JUMP),
		.branch(BRANCH),
		.memRead(MEM_READ),
		.memToReg(MEM_TO_REG),
		.aluOp(ALU_OP),
		.memWrite(MEM_WRITE),
		.aluSrc(ALU_SRC),
		.regWrite(REG_WRITE)
	 );
	 
	 // register
	 wire [4:0] WRITE_REG;
	 wire [31:0] WRITE_REG_DATA;
	 wire [31:0] READ_DATA_1;
	 wire [31:0] READ_DATA_2;
	 assign WRITE_REG = REG_DST ? INST[15:11] : INST[20:16];
	 register mainRegister(
		.regWrite(REG_WRITE),
	   .readReg1(INST[25:21]),
		.readReg2(INST[20:16]),
		.writeReg(WRITE_REG),
		.writeData(WRITE_REG_DATA),
		.readData1(READ_DATA_1),
		.readData2(READ_DATA_2),
		.clock_in(CLK),
		.reset(RESET)
	 );
	 
	 // sign extension
	 wire [31:0] SIGNEXT_OUT;
	 signext mainSignext(
	   .inst(INST[15:0]),
		.signextOut(SIGNEXT_OUT)
	 );
	 
	 // aluCtr
	 wire [3:0] ALU_CTR;
	 aluCtr mainAluCtr(
	   .funct(INST[5:0]),
		.aluOp(ALU_OP),
		.aluCtr(ALU_CTR)
	 );
	 
	 // Alu
	 wire [31:0] ALU_INPUT_2;
	 wire ZERO;
	 wire [31:0] ALU_RES;
	 assign ALU_INPUT_2 = ALU_SRC ? SIGNEXT_OUT : READ_DATA_2;
	 Alu mainAlu(
	   .input1(READ_DATA_1),
		.input2(ALU_INPUT_2),
		.aluCtr(ALU_CTR),
		.zero(ZERO),
		.aluRes(ALU_RES)
	 );
	 
	 // memory
	 wire [31:0] READ_MEM_DATA;
	 data_memory mainDataMem(
	   .clock_in(CLK),
		.address(ALU_RES),
		.readData(READ_MEM_DATA),
		.writeData(READ_DATA_2),
	   .memRead(MEM_READ),
		.memWrite(MEM_WRITE)
	 );
	 
	 // register data_in
	 assign WRITE_REG_DATA = MEM_TO_REG ? READ_MEM_DATA : ALU_RES;
	 
	 	 
	 initial begin
	 PC = 0;
	 end
	  
	 wire [31:0] PC_PLUS_FOUR;
	 assign PC_PLUS_FOUR = PC + 4;
	 wire [31:0] JUMP_ADDR;
	 assign JUMP_ADDR = {PC_PLUS_FOUR[31:28], INST[25:0]<<2};
	 wire [31:0] BEQ_ADDR;
	 assign BEQ_ADDR = PC_PLUS_FOUR + SIGNEXT_OUT<<2;
	 wire [31:0] ACTUAL_BEQ_ADDR;
	 assign ACTUAL_BEQ_ADDR = (BRANCH && ZERO) ? BEQ_ADDR : PC_PLUS_FOUR;
	 wire [31:0] NEXT_PC;
	 assign NEXT_PC = (JUMP) ? JUMP_ADDR : ACTUAL_BEQ_ADDR;
	 
	  
	 
	 always @ (posedge CLK) begin
   if (RESET)
      PC = 0;
	 else 
      PC = NEXT_PC;
	 end
	 
	 always @ (PC)
	 begin
	 INST = {instMem[PC], instMem[PC+1], instMem[PC+2], instMem[PC+3]};
	 end
endmodule
