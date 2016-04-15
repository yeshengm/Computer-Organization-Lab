`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:00:59 02/28/2016 
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
    clock_in, 
	 regWrite,
	 readReg1,
	 readReg2,
	 writeReg,
	 writeData,
	 readData1,
	 readData2,
    );

    input clock_in;
	 input regWrite;
	 input [25:21] readReg1;
	 input [20:16] readReg2;
	 input [4:0] writeReg;
	 input [31:0] writeData;
	 output readData1;
	 output readData2;
	 
	 reg [31:0] readData1;
	 reg [31:0] readData2;
	 reg [31:0] regFile[31:0];
	 
	 always @ (regWrite or readReg1 or readReg2 or writeReg or writeData)
	 begin
	 readData1 <= regFile[readReg1];
	 readData2 <= regFile[readReg2];
	 end
	 
	 always @ (negedge clock_in) 
	 begin
	 if (regWrite)
      regFile[writeReg] <= writeData;
	 end
	 
endmodule
