`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:07:55 02/28/2016
// Design Name:   aluCtr
// Module Name:   C:/Users/Yesheng/Desktop/organization lab/lab/lab3/test_for_aluCtr.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: aluCtr
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_aluCtr;

	// Inputs
	reg [1:0] aluOp;
	reg [5:0] funct;

	// Outputs
	wire [3:0] aluCtr;

	// Instantiate the Unit Under Test (UUT)
	aluCtr uut (
		.aluOp(aluOp), 
		.funct(funct), 
		.aluCtr(aluCtr)
	);

	initial begin
		// Initialize Inputs
		aluOp = 0;
		funct = 0;
		{aluOp, funct} = 8'b00000000;
		
		// Wait 100 ns for global reset to finish
		#100;
		// Add stimulus here
		#100 {aluOp, funct} = 8'b00xxxxxx;
		#100 {aluOp, funct} = 8'bx1xxxxxx;
		#100 {aluOp, funct} = 8'b1xxx0000;
		#100 {aluOp, funct} = 8'b1xxx0010;
		#100 {aluOp, funct} = 8'b1xxx0100;
		#100 {aluOp, funct} = 8'b1xxx0101;
		#100 {aluOp, funct} = 8'b1xxx1010;
	end
      
endmodule

