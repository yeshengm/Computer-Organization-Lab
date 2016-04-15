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
	 output readData;
	 
	 reg [31:0] readData;
    reg [31:0] memFile[0:127];
	 
	 initial
	 begin
		$readmemh("./src/data_mem.txt", memFile);
	 end
	 
	 always @ (address or memRead)
	 begin
	     if (memRead)
	         readData <= memFile[address];
	 end
	 
	 always @ (negedge clock_in)
	 begin
	     if (memWrite)
	         memFile[address] = writeData;
	 end
endmodule
