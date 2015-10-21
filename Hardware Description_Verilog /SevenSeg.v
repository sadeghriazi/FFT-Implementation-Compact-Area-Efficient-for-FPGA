/*----------------------------------------------------------------------------------------
Project: 7seg time sharing module 
Aim:		Assignment 1 of ELEC 427
Author:  Mohammad Sadegh Riazi
Data:		October 7th

Inputs:  clk | button (rst) | swithes (sw) 
Outputs: anodes (an) | 7segments (seg)

Operation: set the desired value in the parameter part and the module will show it on the board
/*----------------------------------------------------------------------------------------*/


module SevenSeg(clk, rst, an, seg, show) ; 

//inputs 
input clk ;
input rst ;

//outputs 
output reg [6:0] seg; 
output reg [3:0] an; 

//16 bit number to be displayed
input [15:0] show ; 


//Internal Variables
wire outClk;
reg [3:0] outDigits; 
reg [6:0] invSeg;

//Intantiating clkDivider module

clkDivider #(18) myClkDivider(clk,outClk);

always @ (posedge clk)
begin
	if (rst)
	begin
		an<=4'b1110;
	end
	
	
	if (outClk)
	begin
		an <= {an[0],an[3:1]};
		case(an)
			4'b0111: 
			begin
				outDigits = show [7:4];
			end
			
			4'b1011: 
			begin
				outDigits = show [3:0];
			end
			
			4'b1101: 
			begin
				outDigits = show [15:12];
			end
			
			4'b1110: 
			begin
				outDigits = show [11:8];
			end	

			default: 
				outDigits = show [3:0];
		endcase 	
	end
end

always @ (posedge clk)
begin
	if (outClk)
	begin
		case (outDigits)
			4'h0: invSeg = 7'b0000000;
			4'h1: invSeg = 7'b0000110;
			4'h2: invSeg = 7'b1011011;
			4'h3: invSeg = 7'b1001111;
			4'h4: invSeg = 7'b1100110;
			4'h5: invSeg = 7'b1101101;
			4'h6: invSeg = 7'b1111101;
			4'h7: invSeg = 7'b0000111;
			4'h8: invSeg = 7'b1111111;
			4'h9: invSeg = 7'b1100111;
			4'hA: invSeg = 7'b1110111;
			4'hB: invSeg = 7'b1111100;
			4'hC: invSeg = 7'b0111001;
			4'hD: invSeg = 7'b1011110;
			4'hE: invSeg = 7'b1111001;
			4'hF: invSeg = 7'b1110001;
			default: invSeg = 7'b1001001;
		 endcase
		 seg = ~ invSeg;
	end
end


endmodule 