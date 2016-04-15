`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:38:35 03/26/2016 
// Design Name: 
// Module Name:    alu 
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
module Alu(  
  input1,
  input2,
  aluCtr,
  zero,
  aluRes
  );
  input [31:0] input1;
  input [31:0] input2;
  input [3:0] aluCtr;
  output reg zero;
  output reg [31:0] aluRes;

  always @ (input1 or input2 or aluCtr)
    begin
    case (aluCtr)
    4'b0000:  // and
      aluRes = input1 & input2;
    4'b0001:  // or
	    aluRes = input1 | input2;
    4'b0010:  // add
	    aluRes = input1 + input2;
    4'b0110:  // sub
	    aluRes = input1 - input2;
	  4'b0111:  // set on less than
      begin
        aluRes = input1 - input2;
        if (aluRes[31] == 0) aluRes = 0;
        else aluRes = 1;
	    end
    4'b1100:  // NOR
	    aluRes = ~(input1 | input2);
    default:
	    aluRes = 0;
	 endcase
	 if (aluRes == 0) zero = 1;
	 else zero = 0;
	 end
endmodule

