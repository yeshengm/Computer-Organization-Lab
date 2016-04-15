`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:12:40 03/25/2016
// Design Name:   timeDiv
// Module Name:   C:/Users/Yesheng/Desktop/lab5/timeDivTest.v
// Project Name:  lab5
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: timeDiv
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module timeDivTest;
	timeDiv uut (
		.clk_in(clk_in), 
		.clk_out(clk_out)
	);

	initial begin
		// Initialize Inputs
		clk_out = 0;
	end
      
endmodule

