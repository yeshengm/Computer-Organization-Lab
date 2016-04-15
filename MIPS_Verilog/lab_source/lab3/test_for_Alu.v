`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:44:18 02/28/2016
// Design Name:   Alu
// Module Name:   C:/Users/Yesheng/Desktop/organization lab/lab/lab3/test_for_Alu.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_Alu;

	// Inputs
	reg [31:0] input1;
	reg [31:0] input2;
	reg [3:0] aluCtr;

	// Outputs
	wire zero;
	wire [31:0] aluRes;

	// Instantiate the Unit Under Test (UUT)
	Alu uut (
		.input1(input1), 
		.input2(input2), 
		.aluCtr(aluCtr), 
		.zero(zero), 
		.aluRes(aluRes)
	);

	initial begin
		// Initialize Inputs
		input1 = 0;
		input2 = 0;
		aluCtr = 0;

		// Wait 100 ns for global reset to finish
		#100;    
		// Add stimulus here
      #100 aluCtr = 4'b0000;  // and
		     input1 = 32'b11111111111111110000000000000000;
			  input2 = 32'b00000000000000001111111111111111;
			  
		#100 aluCtr = 4'b0001;  // or
		     input1 = 32'b10000000000000000000000000000000;
			  input2 = 32'h00000000000000000000000000000000;

      #100 aluCtr = 4'b0010;  // add
		     input1 = 1;
			  input2 = 7;

      #100 aluCtr = 4'b0110;  // sub
		     input1 = 32;
			  input2 = 16;

      #100 aluCtr = 4'b0110;
		     input1 = 1;
			  input2 = 1;
      
      #100 aluCtr = 4'b0111;  // set on less than
		     input1 = 512;
			  input2 = 511;
      
      #100 aluCtr = 4'b0111;
		     input1 = 0;
			  input2 = 4;

      #100 aluCtr = 4'b1100;  // NOR
		     input1 = 0;
			  input2 = 1;
	end
      
endmodule

