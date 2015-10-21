`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:01:52 12/14/2014 
// Design Name: 
// Module Name:    adderDriver 
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
module adderDriver(A,B,R,clk,start,rdy,rst);

input clk;
input [31:0] A,B;
input start;
output [31:0] R;
output rdy;
reg [31:0] Alatched, Blatched;
reg en;
reg state;
input rst;

adder coreAdder (
  .a(A), // input [31 : 0] a
  .b(B), // input [31 : 0] b
  .operation_nd(en), // input operation_nd
  .clk(clk), // input clk
  .result(R), // output [31 : 0] result
  .rdy(rdy) // output rdy
);


always @(posedge clk)	begin

	if(rst==1)	begin
		Alatched<=0;
		Blatched<=0;
		en<=0;
		state<=0;
	end
	if (start==1)	begin
		Alatched <= A;
		Blatched <= B;
	end
	
	if (start==1 && state==0)	begin
		en <= 1;
		state <= 1;
	end
	else if (start==1 && state==1)	begin
		en <= 0;
	end
	else if (start==0 && state==1)	begin
		state <= 0;
		en <= 0;
	end
	else	begin
		state<=0;
		en<=0;
	end

end
endmodule

