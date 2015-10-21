`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:03:11 12/14/2014 
// Design Name: 
// Module Name:    fpCompare 
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
module fpCompare( a,b,c
    );
input [31:0] a,b;
output reg c;

always@(*) //ignoring bit 31 because we know that all values are positive til now
begin
c=0;
	if (a[30:23] > b [30:23])
	begin
		c=1;	
	end else	begin
		if (a[30:23] == b [30:23])	begin
			if (a[22:0] >= b[22:0])	begin
				c=1;
			end else	begin
				c=0;
			end		
		end else begin
			c=0;
		end
	
	end
end
endmodule
