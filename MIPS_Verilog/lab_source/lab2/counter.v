`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:04:40 02/25/2016 
// Design Name: 
// Module Name:    counter 
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
module timerDivider(
		 clockIn,
		 clockOut
		 );
		 input clockIn;
		 output clockOut;
		 reg clockOut;
		 
		 reg[23:0] buffer;
		 initial begin
     buffer = 0;
     end
		 always@(posedge clockIn)
		 begin
			buffer = buffer+1;
			clockOut = &buffer;
		 end
endmodule

module counter(
    mainClock,
	 reset,
	 count
	 );
	 input mainClock;
	 input reset;
	 output count;
	 reg[3:0] count;
	 wire slowClock;
	 
	 timerDivider td(.clockIn(mainClock), .clockOut(slowClock));
	 
	 
	 always@(posedge slowClock)
	 begin
		if (!reset)
			count <= 4'b1111;
		else
			count <= count+1;
	end
endmodule
