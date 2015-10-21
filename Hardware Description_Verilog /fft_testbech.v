`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:13:12 12/12/2014
// Design Name:   FFT
// Module Name:   C:/Users/hr11/Final Proj/Final/fft_testbech.v
// Project Name:  Final
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FFT
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fft_testbech;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [6:0] seg;
	wire [3:0] an;

	// Instantiate the Unit Under Test (UUT)
	FFT uut (
		.clk(clk), 
		.rst(rst), 
		.seg(seg), 
		.an(an)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		

		// Wait 10 ns for global reset to finish
		#50;
		rst = 0;
      

		// Add stimulus here

	end
	always
		begin
			#10 clk = !clk;	// the clock frequency is 50MHz
		end
      
endmodule

