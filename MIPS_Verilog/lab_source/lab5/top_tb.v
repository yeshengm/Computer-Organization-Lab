`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:13:57 03/17/2016
// Design Name:   Top
// Module Name:   C:/Users/Yesheng/Desktop/organization lab/lab/lab5/top_tb.v
// Project Name:  lab5
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module top_tb;

	// Inputs
	reg CLK;
	reg RESET;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.CLK(CLK), 
		.RESET(RESET)
	);
	always #50 CLK = ~CLK;
	initial begin
		// Initialize Inputs
		CLK = 0;
		RESET = 1;

		// Wait 100 ns for global reset to finish
		#95;
		RESET = 0;
        
		// Add stimulus here

	end
      
endmodule

