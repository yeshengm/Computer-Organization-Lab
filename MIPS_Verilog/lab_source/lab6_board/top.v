`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:43:38 03/26/2016 
// Design Name: 
// Module Name:    top 
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
    buffer = buffer + 1;
    clk_out = buffer[25];
  end
endmodule

module Top(
  TopClk,
  RESET,
  led[7:0]
  );
  input TopClk;
  input RESET;
	output wire [7:0] led;
  wire clk;
  
	
  
	// IF 
	reg [31:0] PC;
	 
  // IF_ID
	wire [31:0] IF_PcPlusFour;
  wire [31:0] IF_INST;
  wire [31:0] IF_BeqPc;
  wire [31:0] IF_NextPc;
  reg [31:0] IF_ID_PCPlusFour;
  reg [31:0] IF_ID_Inst;
	 
	 
  //ID->EX
  wire ID_RegDst;
	wire ID_AluSrc;
  wire ID_MemToReg;
  wire ID_RegWrite;
	wire ID_MemRead;
	wire ID_MemWrite;
	wire ID_Branch;
  wire ID_Jump;
	wire [1:0] ID_AluOp;	
	wire [31:0] ID_ReadData1;
	wire [31:0] ID_ReadData2;
	wire [31:0] ID_Signext;
	reg ID_EX_RegDst;
  reg ID_EX_AluSrc;
  reg ID_EX_MemToReg;
  reg ID_EX_RegWrite;
  reg ID_EX_MemRead;
  reg ID_EX_MemWrite;
  reg ID_EX_Branch;
  reg [1:0] ID_EX_AluOp;
  reg [31:0] ID_EX_PCPlusFour;
  reg [31:0] ID_EX_ReadData1;
  reg [31:0] ID_EX_ReadData2;
  reg [31:0] ID_EX_Signext;
  reg [20:16] IF_ID_Inst_20_16;
  reg [15:11] IF_ID_Inst_15_11;
	 
  // EX_MEM
	wire [31:0] EX_AddRes;
  wire [31:0] EX_AluSrc_input_2;
	wire [5:0] EX_WriteReg;		
  wire EX_Zero;
	wire [31:0] EX_AluRes;		
  wire [3:0] EX_AluCtr;
		
  //reg
  reg EX_MEM_MemToReg;
  reg EX_MEM_RegWrite;
  reg EX_MEM_MemRead;
  reg EX_MEM_MemWrite;
  reg EX_MEM_Branch;
  reg [31:0] EX_MEM_AddRes;
  reg EX_MEM_Zero;
  reg [31:0] EX_MEM_AluRes;
  reg [31:0] EX_MEM_ReadData2;
  reg [4:0] EX_MEM_WriteReg;
		
	 
  // MEM_WB
	wire [31:0] MEM_ReadData;
	wire MEM_PCSrc;
	reg [31:0] MEM_WB_ReadData;
	reg [31:0] MEM_WB_AluRes;
	reg [4:0] MEM_WB_WriteReg;
	reg MEM_WB_MemToReg;
	reg MEM_WB_RegWrite;
  wire [31:0] WB_WriteData;


  assign IF_PcPlusFour = PC + 4;
  assign IF_BeqPc = MEM_PCSrc ? EX_MEM_AddRes : IF_PcPlusFour;
  assign IF_NextPc = ID_Jump ? {IF_ID_PCPlusFour[31:28], IF_ID_Inst[25:0], 2'b00} : IF_BeqPc;
  assign EX_AddRes = ID_EX_PCPlusFour + (ID_EX_Signext << 2);
  assign EX_AluSrc_input_2 = ID_EX_AluSrc ? ID_EX_Signext : ID_EX_ReadData2;
  assign EX_WriteReg = ID_EX_RegDst ? IF_ID_Inst_15_11 : IF_ID_Inst_20_16;
  assign MEM_PCSrc = EX_MEM_Branch & EX_MEM_Zero; 
  assign WB_WriteData = MEM_WB_MemToReg ? MEM_WB_ReadData : MEM_WB_AluRes; 
  
  
  
  timeDiv mainTimeDiv(
    .clk_in(TopClk),
    .clk_out(clk)
  );
  
  instMem mainInstMem(
	  .addr(PC),
	  .clk(clk),
	  .reset(RESET),
	  .inst(IF_INST)
  );
	
  register mainRegsiter(
    .clk(clk),
    .readReg1(IF_ID_Inst[25:21]),
    .readReg2(IF_ID_Inst[20:16]),
    .writeReg(MEM_WB_WriteReg),
    .writeData(WB_WriteData),
    .regWrite(MEM_WB_RegWrite),
    .readData1(ID_ReadData1),
    .readData2(ID_ReadData2),
    .reset(RESET),
    .led(led[5:0])
  );	
	
  signext mainSignext(
    .inst(IF_ID_Inst[15:0]),
    .signextOut(ID_Signext)
  );	
	
	Ctr mainCtr(
	 .opCode(IF_ID_Inst[31:26]),
	 .regDst(ID_RegDst),
	 .aluSrc(ID_AluSrc),
	 .memToReg(ID_MemToReg),
	 .regWrite(ID_RegWrite),
	 .memRead(ID_MemRead),
	 .memWrite(ID_MemWrite),
	 .branch(ID_Branch),
	 .aluOp(ID_AluOp),
   .jump(ID_Jump)
	);
  
  aluCtr mainAluCtr(
    .aluOp(ID_EX_AluOp),
    .funct(ID_EX_Signext[5:0]),
    .aluCtr(EX_AluCtr)
  );
  
  Alu mainAlu(
    .input1(ID_EX_ReadData1),
    .input2(EX_AluSrc_input_2),
    .aluCtr(EX_AluCtr),
    .zero(EX_Zero),
    .aluRes(EX_AluRes)
  );

  dataMemory mainDataMem(
    .clk(clk),
    .reset(RESET),
    .address(EX_MEM_AluRes),
    .writeData(EX_MEM_ReadData2),
    .memWrite(EX_MEM_MemWrite),
    .memRead(EX_MEM_MemRead),
    .readData(MEM_ReadData)
  );
  
  wire IF_ID_Flush;
  wire ID_EX_Stall;
  wire EX_MEM_Stall;
  
  hazardDetect mainHazardDetect(
    .jump(ID_Jump),
    .PcSrc(MEM_PCSrc),
    .IF_ID_Flush(IF_ID_Flush),
    .ID_EX_Stall(ID_EX_Stall),
    .EX_MEM_Stall(EX_MEM_Stall)
  );
  
  assign led[6] = PC[2];
  assign led[7] = PC[3];

  always @ (posedge clk) begin
    if (RESET)
      PC <= 0;
    else begin
      PC <= IF_NextPc;
    end
    //IF_ID
    IF_ID_PCPlusFour <= IF_PcPlusFour;
    if (IF_ID_Flush)
      IF_ID_Inst <= 0;
    else
      IF_ID_Inst <= IF_INST;
	
    //ID_EX
    if (ID_EX_Stall) begin
      ID_EX_RegDst <= 0;
      ID_EX_AluSrc <= 0;
      ID_EX_MemToReg <= 0;
      ID_EX_RegWrite <= 0;
      ID_EX_MemRead <= 0;
      ID_EX_MemWrite <= 0;
      ID_EX_Branch <= 0;
      ID_EX_AluOp <= 0;
      ID_EX_PCPlusFour = IF_ID_PCPlusFour;
      ID_EX_ReadData1 <= 0;
      ID_EX_ReadData2 <= 0;
      ID_EX_Signext <= ID_Signext;
      IF_ID_Inst_20_16 <= 0;
      IF_ID_Inst_15_11 <= 0;
    end
    else begin
      ID_EX_RegDst <= ID_RegDst;
      ID_EX_AluSrc <= ID_AluSrc;
      ID_EX_MemToReg <= ID_MemToReg;
      ID_EX_RegWrite <= ID_RegWrite;
      ID_EX_MemRead <= ID_MemRead;
      ID_EX_MemWrite <= ID_MemWrite;
      ID_EX_Branch <= ID_Branch;
      ID_EX_AluOp <= ID_AluOp;
      ID_EX_PCPlusFour = IF_ID_PCPlusFour;
      ID_EX_ReadData1 <= ID_ReadData1;
      ID_EX_ReadData2 <= ID_ReadData2;
      ID_EX_Signext <= ID_Signext;
      IF_ID_Inst_20_16 <= IF_ID_Inst[20:16];
      IF_ID_Inst_15_11 <= IF_ID_Inst[15:11];
    end
   
    //EX_MEM
    if (EX_MEM_Stall) begin
      EX_MEM_MemToReg <= 0;
      EX_MEM_RegWrite <= 0;
      EX_MEM_MemRead <= 0;
      EX_MEM_MemWrite <= 0;
      EX_MEM_Branch <= 0;
      EX_MEM_AddRes <= 0;
      EX_MEM_Zero <= 0;
      EX_MEM_AluRes <= 0;
      EX_MEM_ReadData2 <= 0;
      EX_MEM_WriteReg <= 0;
    end
    else begin
      EX_MEM_MemToReg <= ID_EX_MemToReg;
      EX_MEM_RegWrite <= ID_EX_RegWrite;
      EX_MEM_MemRead <= ID_EX_MemRead;
      EX_MEM_MemWrite <= ID_EX_MemWrite;
      EX_MEM_Branch <= ID_EX_Branch;
      EX_MEM_AddRes <= EX_AddRes;
      EX_MEM_Zero <= EX_Zero;
      EX_MEM_AluRes <= EX_AluRes;
      EX_MEM_ReadData2 <= ID_EX_ReadData2;
      EX_MEM_WriteReg <= EX_WriteReg; 
    end
    
    // MEM_WB
    MEM_WB_MemToReg <= EX_MEM_MemToReg;
    MEM_WB_RegWrite <= EX_MEM_RegWrite;
    MEM_WB_ReadData <= MEM_ReadData;
    MEM_WB_AluRes <= EX_MEM_AluRes;
    MEM_WB_WriteReg <= EX_MEM_WriteReg; 
  end

  initial begin
    PC <= 0;
		IF_ID_PCPlusFour <= 0;
    IF_ID_Inst <= 0;
		ID_EX_RegDst <= 0;
    ID_EX_AluSrc <= 0;
	  ID_EX_MemToReg <= 0;
	  ID_EX_RegWrite <= 0;
	  ID_EX_MemRead <= 0;
	  ID_EX_MemWrite <= 0;
	  ID_EX_Branch <= 0;
	  ID_EX_AluOp <= 0;
	  ID_EX_PCPlusFour <= 0;
	  ID_EX_ReadData1 <= 0;
	  ID_EX_ReadData2 <= 0;
	  ID_EX_Signext <= 0;
	  IF_ID_Inst_20_16 <= 0;
	  IF_ID_Inst_15_11 <= 0;
		EX_MEM_MemToReg <= 0;
	  EX_MEM_RegWrite <= 0;
    EX_MEM_MemRead <= 0;
    EX_MEM_MemWrite <= 0;
    EX_MEM_Branch <= 0;
    EX_MEM_AddRes <= 0;
	  EX_MEM_Zero <= 0;
	  EX_MEM_AluRes <= 0;
	  EX_MEM_ReadData2 <= 0;
	  EX_MEM_WriteReg <= 0;
    MEM_WB_ReadData <= 0;
	  MEM_WB_AluRes <= 0;
	  MEM_WB_WriteReg <= 0;
	  MEM_WB_MemToReg <= 0;
	  MEM_WB_RegWrite <= 0;
  end
endmodule
