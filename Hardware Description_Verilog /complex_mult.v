`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:14:38 12/13/2014 
// Design Name: 
// Module Name:    complex_mult 
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
module complex_mult_add(
	re1,im1,re2,im2,re,im,ready,clk,start,op,rst
    );
	input wire [31:0] re1,re2,im1,im2;
	output wire [31:0] re,im;
	output reg ready;
	wire gh;
	input wire clk,start,op,rst;
	reg [4:0] counter ;
	float_mult floatMult (
  .a(re1), // input [31 : 0] a
  .b(re2), // input [31 : 0] b
  .operation_nd(start), // input operation_nd
  .operation_rfd(operation_rfd), // output operation_rfd
  .clk(clk), // input clk
  .result(re), // output [31 : 0] result
  .rdy(gh) // output rdy
   );
	assign im=0;
	always @ (posedge clk)begin
		if (rst) begin
			counter<=0;
		end
		
		if (start) begin
			counter<=counter+1;
		end
		
		
		if (counter==5'b01111) begin
			ready<=1'b1;
			counter<=0;
		end else begin
			ready<=1'b0;
		end
	end

endmodule
