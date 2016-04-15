`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:30:00 03/27/2016 
// Design Name: 
// Module Name:    hazardDetect 
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
module hazardDetect(
  jump,
  PcSrc,
  IF_ID_Flush,
  ID_EX_Stall,
  EX_MEM_Stall
  );
  input jump;
  input PcSrc;
  output reg IF_ID_Flush;
  output reg ID_EX_Stall;
  output reg EX_MEM_Stall;
  
  initial begin
    IF_ID_Flush = 0;
    ID_EX_Stall = 0;
    EX_MEM_Stall = 0;
  end

  always @ (jump or PcSrc) begin
  if (jump) begin
    IF_ID_Flush = 1;
    ID_EX_Stall = 0;
    EX_MEM_Stall = 0;
  end
  else if (PcSrc) begin
    IF_ID_Flush = 1;
    ID_EX_Stall = 1;
    EX_MEM_Stall = 1;
  end
  else begin
    IF_ID_Flush = 0;
    ID_EX_Stall = 0;
    EX_MEM_Stall = 0;
  end
  end
endmodule
