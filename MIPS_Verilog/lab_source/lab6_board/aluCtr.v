`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:35:43 03/26/2016 
// Design Name: 
// Module Name:    aluCtr 
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
module aluCtr(
  aluOp,
  funct,
  aluCtr
  );
	 
  input [1:0] aluOp;
  input [5:0] funct;
  output reg [3:0] aluCtr;
	 	 
	always @ (aluOp or funct) begin
    casex ({aluOp, funct})
	    8'b00xxxxxx: aluCtr = 4'b0010;
	    8'bx1xxxxxx: aluCtr = 4'b0110;
		  8'b1xxx0000: aluCtr = 4'b0010;
		  8'b1xxx0010: aluCtr = 4'b0110;
		  8'b1xxx0100: aluCtr = 4'b0000;
		  8'b1xxx0101: aluCtr = 4'b0001;
		  8'b1xxx1010: aluCtr = 4'b0111;
		  default: aluCtr = 4'b0000;
    endcase
   end
endmodule