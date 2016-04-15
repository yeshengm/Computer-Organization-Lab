`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:45:25 03/26/2016
// Design Name:   Top
// Module Name:   C:/Users/Yesheng/Desktop/organization lab/lab/lab6/testForTop.v
// Project Name:  lab6
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

module testForTop;

	// Inputs
	reg CLOCK_IN;
	reg RESET;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.CLOCK_IN(CLOCK_IN), 
		.RESET(RESET)
	);

	initial begin
		CLOCK_IN = 0;
		RESET = 1;
    #10;
    RESET = 0;	
	end
 always #50 CLOCK_IN = ~CLOCK_IN;	     
endmodule


