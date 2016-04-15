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
	 reset,
    clock_in, 
	 regWrite,
	 readReg1,
	 readReg2,
	 writeReg,
	 writeData,
	 readData1,
	 readData2,
	 led
   );
	 
	 input reset;
   input clock_in;
	 input regWrite;
	 input [25:21] readReg1;
	 input [20:16] readReg2;
	 input [4:0] writeReg;
	 input [31:0] writeData;
	 output readData1;
	 output readData2;
	 output reg [5:0] led;
	 
	 reg [31:0] readData1;
	 reg [31:0] readData2;
	 reg [31:0] regFile[7:0];
	 integer i;
	 

	 always @ (negedge clock_in)
	 begin
	 readData1 = regFile[readReg1];
	 readData2 = regFile[readReg2];
	 led[0] = regFile[1][0];
	 led[1] = regFile[1][1];
	 led[2] = regFile[2][0];
   led[3] = regFile[2][1];
	 led[4] = regFile[3][0];
	 led[5] = regFile[3][1];
	 end
	 
	 always @ (posedge clock_in)
	 begin
		if (reset)
			for (i = 0; i < 8; i = i + 1) 
				regFile[i] = 0;
		else if (regWrite)
	     regFile[writeReg] = writeData;
	 end
	 
endmodule
