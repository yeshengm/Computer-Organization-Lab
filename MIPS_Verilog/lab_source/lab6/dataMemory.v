`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:41:47 03/26/2016 
// Design Name: 
// Module Name:    dataMemory 
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
module dataMemory(
  clk,
  address,
  writeData,
  memWrite,
  memRead,
  readData
  );
  input clk;
  input [31:0] address;
  input [31:0] writeData;
  input memWrite;
  input memRead;
  output reg [31:0] readData;

  reg [31:0] memFile[8:0];
	 
  initial begin
    memFile[0] = 0;
    memFile[1] = 1;
    memFile[2] = 2;
    memFile[3] = 3;
    memFile[4] = 4;
    memFile[5] = 5;
    memFile[6] = 6;
    memFile[7] = 7;
  end
  
  always @ (memRead or memWrite or address) begin
    if (memRead == 1) readData = memFile[address];
	end
	 
  always @ (negedge clk) begin
	  if (memWrite) 
      memFile[address] = writeData;
		if (memRead)
      readData = memFile[address];
	 end
endmodule