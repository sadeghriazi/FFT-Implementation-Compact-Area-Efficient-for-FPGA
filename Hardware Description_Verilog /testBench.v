`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:15:26 12/14/2014
// Design Name:   compOp
// Module Name:   C:/Users/sk83/complexMul/complexMul-2/testBench.v
// Project Name:  complexMul-2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: compOp
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testBench;

	reg [31:0] re1,im1,re2,im2;

	reg start;
	reg clk;
	reg operation;
	reg rst;
	reg sw;
	wire [31:0] re,im;
	wire ready;
	wire [6:0] seg; 
	wire [3:0] an; 

	parameter CLK_PERIODE=10;
	
	
	// Instantiate the Unit Under Test (UUT)
	compOp uut (
		.re1(re1),
		.im1(im1),
		.re2(re2),
		.im2(im2),
		.re(re),
		.im(im),
		.ready(ready), 
		.start(start), 
		.clk(clk), 
		.op(operation),
		.rst(rst)
	);

	initial begin
		// Initialize Inputs
		re1 = 32'h41a80000;
		im1 = 32'h42400000;
		re2 = 32'h42920000;
		im2 = 32'hc1400000;
		start = 0;
		clk = 0;
		operation = 0;
		sw=0;
		rst=0;
		#50;
		rst=1;
		#50;
		rst=0;
		// Wait 100 ns for global reset to finish
		#100;
		// Add stimulus here
		start = 1;
		#50;
		rst=0;
	end	
	
	always begin	
		#(CLK_PERIODE/2); 
		clk=~clk;
	end	
	
endmodule

