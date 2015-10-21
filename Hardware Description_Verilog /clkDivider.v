`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  Rice 	
// Engineer: 
// 
// Create Date:    16:38:09 10/07/2014 
// Design Name: 
// Module Name:    clkDivider 
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
module clkDivider #(	parameter counterBits = 19 )
	(
    input clk,
    output outClk
    );
	
	reg [counterBits-1:0] counter ;
	wire andCounter;
	
	always @ (posedge clk)
		begin
			counter <= counter + 1;		
		end
	

	assign outClk = &counter ? 1 : 0;
	
endmodule
