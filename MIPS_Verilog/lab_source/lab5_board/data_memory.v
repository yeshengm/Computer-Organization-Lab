`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:24:44 03/02/2016 
// Design Name: 
// Module Name:    data_memory 
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
module data_memory(
	 reset,
    clock_in,
	 address,
	 readData,
	 writeData,
	 memRead,
	 memWrite
    );
    input clock_in;
	 input [31:0] address;
	 input [31:0] writeData;
	 input memRead;
	 input memWrite;
	 input reset;
	 output readData;
	 
	 reg [31:0] readData;
    reg [31:0] memFile[0:7];
	 	 
	 always @ (address or memRead)
	 begin
	     
	 end
	 
	 always @ (negedge clock_in)
	 begin
     if (reset) begin
       memFile[0] = 0;
       memFile[1] = 1;
       memFile[2] = 2;
       memFile[3] = 3;
       memFile[4] = 4;
       memFile[5] = 5;
       memFile[6] = 6;
       memFile[7] = 7;
     end
     if (memRead)
       readData = memFile[address];
     if (memWrite)
       memFile[address] = writeData;
	 end
endmodule
