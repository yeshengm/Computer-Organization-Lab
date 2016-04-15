`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:24:52 03/26/2016 
// Design Name: 
// Module Name:    instMem 
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
module instMem(
  addr,
  clk,
  reset,
  inst
  );
  input [31:0] addr;
  input clk;
  input reset;
  output reg [31:0] inst;
	 
  reg [7:0] memBuf[0:51];
  
	 always @ (addr or clk)
	 begin
	   if (reset == 0) begin
       inst = { memBuf[addr], memBuf[addr+1], memBuf[addr+2], memBuf[addr+3] };
       memBuf[0] = 8'b10001100;
       memBuf[1] = 8'b00000000;
       memBuf[2] = 8'b00000000;
       memBuf[3] = 8'b00000000; // nop
       memBuf[4] = 8'b00010000;
       memBuf[5] = 8'b00000000;
       memBuf[6] = 8'b00000000;
       memBuf[7] = 8'b00000000; // beq reg0 reg0
	     memBuf[8] = 8'b10001100;
       memBuf[9] = 8'b00000000;
       memBuf[10] = 8'b00000000;
       memBuf[11] = 8'b00000000; // nop
       memBuf[12] = 8'b10001100;
       memBuf[13] = 8'b00000000;
       memBuf[14] = 8'b00000000;
       memBuf[15] = 8'b00000000; // nop
       memBuf[16] = 8'b10001100;
       memBuf[17] = 8'b00000001;
       memBuf[18] = 8'b00000000;
       memBuf[19] = 8'b00000001; // regFile[1] = memFile[1] = 1;
       memBuf[20] = 8'b10001100;
       memBuf[21] = 8'b00000010;
       memBuf[22] = 8'b00000000;
       memBuf[23] = 8'b00000010; // regFile[2] = memFile[2] = 2;
       memBuf[24] = 8'b00000000;
       memBuf[25] = 8'b00000000;
       memBuf[26] = 8'b00000000;
       memBuf[27] = 8'b00000000; // nop
       memBuf[28] = 8'b00000000;
       memBuf[29] = 8'b00000000;
       memBuf[30] = 8'b00000000;
       memBuf[31] = 8'b00000000; // nop
       memBuf[32] = 8'b00000000;
       memBuf[33] = 8'b00000000;
       memBuf[34] = 8'b00000000;
       memBuf[35] = 8'b00000000; // nop
       memBuf[36] = 8'b00000000;
       memBuf[37] = 8'b00100010;
       memBuf[38] = 8'b00011000;
       memBuf[39] = 8'b00100000; // regFile[3] = regFile[1] + regFile[2]
       memBuf[40] = 8'b00000000;
       memBuf[41] = 8'b01000001;
       memBuf[42] = 8'b00011000;
       memBuf[43] = 8'b00100010; // regFile[3] = regFile[1] - regFile[2]
       memBuf[44] = 8'b00000000;
       memBuf[45] = 8'b01000001;
       memBuf[46] = 8'b00011000;
       memBuf[47] = 8'b00100101; // regFile[3] = regFile[1] | regFile[2]
       memBuf[48] = 8'b00000000;
       memBuf[49] = 8'b01000001;
       memBuf[50] = 8'b00011000;
       memBuf[51] = 8'b00100100; // regFile[3] = regFile[1] & regFile[2]     
     end
		 else 
       inst = 0;
	 end
endmodule