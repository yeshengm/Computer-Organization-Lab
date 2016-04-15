`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:59:04 03/02/2016
// Design Name:   data_memory
// Module Name:   C:/Users/Yesheng/Desktop/organization lab/lab/lab4/test_for_datamem.v
// Project Name:  lab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: data_memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_datamem;

	// Inputs
	reg clock_in;
	reg [31:0] address;
	reg [31:0] writeData;
	reg memRead;
	reg memWrite;

	// Outputs
	wire [31:0] readData;

	// Instantiate the Unit Under Test (UUT)
	data_memory uut (
		.clock_in(clock_in), 
		.address(address), 
		.readData(readData), 
		.writeData(writeData), 
		.memRead(memRead), 
		.memWrite(memWrite)
	);

	initial begin
		// Initialize Inputs
		clock_in = 0;
		address = 0;
		writeData = 0;
		memRead = 0;
		memWrite = 0;

		// Wait 100 ns for global reset to finish
        
		// Add stimulus here
		#185;
		memWrite = 1'b1;
		address = 32'h0000000f;
		writeData = 32'hffff0000;
		
		#250;
		memRead = 1'b1;
		memWrite = 1'b0;
	end
   always #100
	begin
	   clock_in = ~clock_in;
	end
endmodule

