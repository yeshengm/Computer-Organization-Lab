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
module timeDiv(
	clk_in,
	clk_out
	);
	input clk_in;
	output reg clk_out;
	reg [25:0] buffer;
	always @ (posedge clk_in) begin
		buffer <= buffer + 1;
		clk_out <= buffer[25];
	end
endmodule

module Top(
    CLK,
    RESET,
	 led
    );
	 input CLK;
	 input RESET;
	 output wire [7:0] led;
	 wire topClk;
	 
	 timeDiv mainTimeDiv(
		.clk_in(CLK),
		.clk_out(topClk)
	 );
	 
	 reg [31:0] INST;
	 reg [7:0] instMem[0:40];
	 reg [31:0] PC;
	 
   assign led[6] = PC[3];
   assign led[7] = PC[4];
   
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
		.clock_in(topClk),
		.led(led[5:0]),
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
	   .clock_in(topClk),
		.address(ALU_RES),
		.readData(READ_MEM_DATA),
		.writeData(READ_DATA_2),
	   .memRead(MEM_READ),
		.memWrite(MEM_WRITE),
		.reset(RESET)
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
	 
	  
	 
	 always @ (posedge topClk)
	 begin
		if (RESET) begin
      PC = 0;
      instMem[0] = 8'b00001000;
      instMem[1] = 8'b00000000;
      instMem[2] = 8'b00000000;
      instMem[3] = 8'b00000001; // if (regFile[3] == regFile[0]) goto PC = 0
      instMem[4] = 8'b10001100;
      instMem[5] = 8'b00000001;
      instMem[6] = 8'b00000000;
      instMem[7] = 8'b00000001; // regFile[1] = memFile[1] = 1;
      instMem[8] = 8'b10001100;
      instMem[9] = 8'b00000010;
      instMem[10] = 8'b00000000;
      instMem[11] = 8'b00000010; // regFile[2] = memFile[2] = 2;
      instMem[12] = 8'b00000000;
      instMem[13] = 8'b00100010;
      instMem[14] = 8'b00011000;
      instMem[15] = 8'b00100000; // regFile[3] = regFile[1] + regFile[2]
      instMem[16] = 8'b00000000;
      instMem[17] = 8'b01000001;
      instMem[18] = 8'b00011000;
      instMem[19] = 8'b00100010; // regFile[3] = regFile[1] - regFile[2]
      instMem[20] = 8'b00000000;
      instMem[21] = 8'b01000001;
      instMem[22] = 8'b00011000;
      instMem[23] = 8'b00100101; // regFile[3] = regFile[1] | regFile[2]
      instMem[24] = 8'b00000000;
      instMem[25] = 8'b01000001;
      instMem[26] = 8'b00011000;
      instMem[27] = 8'b00100100; // regFile[3] = regFile[1] & regFile[2]
      instMem[28] = 8'b10101100;
      instMem[29] = 8'b00000010;
      instMem[30] = 8'b00000000;
      instMem[31] = 8'b00000000; // regFile[3] = memFile[0]
     
    end
		else PC = NEXT_PC;
	 end
	 
	 always @ (PC)
	 begin
		INST = {instMem[PC], instMem[PC+1], instMem[PC+2], instMem[PC+3]};
	 end
endmodule
