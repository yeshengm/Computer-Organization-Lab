`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:07:21 03/03/2016
// Design Name:   signext
// Module Name:   C:/Users/Yesheng/Desktop/organization lab/lab/lab4/test_for_signext.v
// Project Name:  lab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: signext
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_signext;

	// Inputs
	reg [15:0] inst;

	// Outputs
	wire [31:0] data;

	// Instantiate the Unit Under Test (UUT)
	signext uut (
		.inst(inst), 
		.data(data)
	);

	initial begin
		// Initialize Inputs
		inst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#100;
		inst = 16'h0000;
		#100;
		inst = 16'h1000;
		#100;
		inst = 16'h1111;
	end
      
endmodule

