`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:26:17 03/26/2016 
// Design Name: 
// Module Name:    register 
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
module register(
  clk,
  readReg1,
  readReg2,
  writeReg,
  writeData,
  regWrite,
  readData1,
  readData2,
  reset
  );
  
  input clk;
  input [25:21] readReg1;
  input [20:16] readReg2;
  input [4:0] writeReg;
  input [31:0] writeData;
  input regWrite;
  input reset;
  output reg [31:0] readData1;
  output reg [31:0] readData2;

  reg [31:0] regFile[7:0];
  integer i ;
	
  initial begin
  for (i = 0; i < 8; i = i+1)
    regFile[i] = 0;
  end
		
	always @ (readReg1 or readReg2 or regWrite or writeReg or regWrite) begin
    readData1 = regFile[readReg1];
	  readData2 = regFile[readReg2];
  end
	 
	always @ (negedge clk or reset) begin
    readData1 = regFile[readReg1];
    readData2 = regFile[readReg2];
		if (reset == 1)
      for (i = 0; i < 8; i = i+1)
        regFile[i] = 0;
		else if (regWrite)
      regFile[writeReg] = writeData;
	 end
endmodule
