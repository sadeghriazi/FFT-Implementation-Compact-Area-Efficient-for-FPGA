`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// IN GOD WE TRUST
// Company:			RICE UNIVERSITY 
// Engineer: 		Mohammad Sadegh Riazi/ Hamed Rahmani/ Seyyed Mohammad Kazempour
// 
// Create Date:    10:34:16 12/12/2014 
// Design Name:	 Efficient FFT with least area consumption possible
// Module Name:    FFT 
// Project Name: 	 Final Project
// Target Devices: Xilinx Spartan3 AN 
// Tool versions:  1
// Description: 	 we have 7 stages, each of which has four phases and each has may vary in #clk cycle
//
// Dependencies: 	 compOp : calculates mult or addition of 2 floating point complex numbers (written by S.M.K)
//						 fpCmpr : compares two floating point numbers (written by M.S.R)
//						 Max Computer FSM: written by H.R.
//						 SevenSeg : shows the value on seven segment 
// Revision: 			
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module FFT(clk, rst, seg, an ,sw , Led
    );

//------------------------------------------------------------------ Signals
//inputs
input clk;
input rst;
input wire [7:0] sw;

//outputs
output wire [6:0] seg;
output wire [3:0] an;
output reg [7:0] Led;

//intermediate Registers 
reg start;
reg [31:0] maxAbsX;
reg [3:0] maxIndex;

reg [4:0] state;
reg [4:0] nState;


reg CMAaddMult;
reg maxAbsXen;
reg [3:0] addRam1,addRam2;
reg [3:0] addRam1Reg,addRam2Reg;

reg [31:0] cmp1,cmp2;

reg wEnRam1,wEnRam2;
reg [31:0] ram1ReIn,ram1ImIn,ram2ReIn,ram2ImIn;
reg [31:0] CMAre1,CMAre2,CMAim1,CMAim2;
reg [31:0] monitor;
reg [3:0] sample;
reg readed;
reg writed;
reg [1:0] hop; 
reg [2:0] WNindex;
reg [31:0] ram1Copy [0:15];
reg [31:0] ram2Copy [0:15];
reg [4:0] copyIndex;
reg [3:0] stage;
reg [3:0] nStage;
reg signBit;
reg [3:0] mask;
reg [2:0] freqFinal;
reg [2:0] freqFinalReg;
reg [3:0] revMaxIndex ;
reg [21:0] ledCounter;

//intermediate Wires
wire [31:0] x;
wire CMAready;
wire [31:0] CMAOre,CMAOim;
wire [31:0] WNreal,WNimag;
wire [31:0] ram1ReOut,ram1ImOut,ram2ReOut,ram2ImOut;
wire bigger;
wire [15:0] show;


//parameters
parameter readData =  0;
parameter stage1phase0 = 1;
parameter stage1phase1 = 2;
parameter stage1phase2 = 3;
parameter stage1phase3 = 4;

parameter stage2phase0 = 5;
parameter stage2phase1 = 6;
parameter stage2phase2 = 7;
parameter stage2phase3 = 8;

parameter maxCal = 9;
parameter halt = 31;
  
parameter scapeStage = 8;
//-------------------------------------------------------------------- Instantiations
SevenSeg mySevenSeg(clk, rst, an, seg, show) ; 

Signal_Mem signal_mem (
  .clka(clk), // input clka
  .addra(addRam1Reg), // input [3 : 0] addra
  .douta(x) // output [31 : 0] douta
);


//----------------------- WN
Wn_real Wn_Real (
  .clka(clk), // input clka
  .addra(WNindex), // input [2 : 0] addra
  .douta(WNreal) // output [31 : 0] douta
);
Wn_imag Wn_Imag (
  .clka(clk), // input clka
  .addra(WNindex), // input [2 : 0] addra
  .douta(WNimag) // output [31 : 0] douta
);



//------------------- Ram1
ram1Re ram1re (
  .clka(clk), // input clka
  .wea(wEnRam1), // input [0 : 0] wea
  .addra(addRam1), // input [3 : 0] addra
  .dina(ram1ReIn), // input [31 : 0] dina
  .douta(ram1ReOut) // output [31 : 0] douta
);
ram1Re ram1im (
  .clka(clk), // input clka
  .wea(wEnRam1), // input [0 : 0] wea
  .addra(addRam1), // input [3 : 0] addra
  .dina(ram1ImIn), // input [31 : 0] dina
  .douta(ram1ImOut) // output [31 : 0] douta
);



//----------------- Ram2
ram1Re ram2re (
  .clka(clk), // input clka
  .wea(wEnRam2), // input [0 : 0] wea
  .addra(addRam2), // input [3 : 0] addra
  .dina(ram2ReIn), // input [31 : 0] dina
  .douta(ram2ReOut) // output [31 : 0] douta
);
ram1Re ram2im (
  .clka(clk), // input clka
  .wea(wEnRam2), // input [0 : 0] wea
  .addra(addRam2), // input [3 : 0] addra
  .dina(ram2ImIn), // input [31 : 0] dina
  .douta(ram2ImOut) // output [31 : 0] douta
);

compOp complexMultAdd(
	.re1(CMAre1)
	,.im1(CMAim1)
	,.re2(CMAre2)
	,.im2(CMAim2)
	,.re(CMAOre)
	,.im(CMAOim)
	,.ready(CMAready)
	,.clk(clk)
	,.start(start)
	,.op(CMAaddMult)
	,.rst(rst)
    );


fpCompare fpCmpr (.a(cmp1),.b(cmp2),.c(bigger));

//-------------------------------------------------------------------- Assigns
assign show = {12'b0,freqFinalReg};

//just

//-------------------------------------------------------------------- Always
always @ (posedge clk) begin
	if (rst) begin//----------------- if rst
		state<=0;	
		addRam1Reg<=0;
		addRam2Reg<=0;
		CMAre1<=0;
		CMAim1<=0;
		CMAre2<=0;
		CMAim2<=0;
		readed<=0;
		copyIndex <=0;
		stage <=1; //yes 1 not 0
		maxIndex <= 0;
		maxAbsX <=0;
		Led <= 1;
		ledCounter <=0;
	end else	begin //----------------- casual operation	
//****************************************************************************************************************************************************		
		state<=nState;
		stage<=nStage;
		
		//monitor <= ram2Copy [13];
		
		case (state)
		
		readData: begin
			ram1ReIn <= x;
			ram1ImIn <= 0;
			addRam1Reg <= sample;
			if (addRam1Reg == 4'b1111) begin
				hop <= hop + 1;
			end else begin
				hop <=0;
			end
			end 
		
		//------------------------------------------------------------------------ ********************* stage1		
		stage1phase0: begin		
			if (readed == 0) begin
				readed <=1; 
			end else begin
				CMAre1 <= ram1ReOut;
				CMAim1 <= ram1ImOut;	
				readed <=0;
			end
			end
		
		stage1phase1: begin				
			if (readed == 0) begin
				readed <=1; 
			end else begin    // negate then store
				//if (ram1ReOut
					CMAre2 <= {signBit^ram1ReOut[31],ram1ReOut[30:0]};
					CMAim2 <= {signBit^ram1ImOut[31],ram1ImOut[30:0]};
				readed <=0;
			end
			end

		stage1phase2: begin
				//do nothing wait for ready signal of summation
				writed<=0;
			end
	
		stage1phase3: begin // save Complex Mult Add   state 4
			stage <= nStage;
			ram2ReIn <= CMAOre;
			ram2ImIn <= CMAOim;
			addRam2Reg <= addRam2;
			if (writed == 0) begin
				writed <=1; 
			end else begin
				writed <=0;
				addRam2Reg <= addRam2Reg+1;
				addRam1Reg<=0;//initialization for stage2
			end
			end
		
		//------------------------------------------------------------------------ ********************* stage2
		
		
		stage2phase0: begin		
																	// read first operand
			if (signBit) begin // for mult half
				if (readed == 0) begin
					readed <=1; 
				end else begin
					CMAre1 <= ram2ReOut;
					CMAim1 <= ram2ImOut;	
					readed <=0;
				end
			end else begin               // for not mult half
				if (readed == 0) begin
					readed <=1; 
				end else begin	
					readed <=0;
				end
			end
			end
																	// read second operand
		stage2phase1: begin
			if (signBit) begin // for mult half
				if (readed == 0) begin
					readed <=1; 
				end else begin
					if (stage == 8) begin
						CMAre2 <= ram2ReOut;
						CMAim2 <= {~ram2ImOut[31],ram2ImOut[30:0]};
					end else begin
						CMAre2 <= WNreal;
						CMAim2 <= WNimag;
					end
					readed <=0;
				end
			end else begin					 // for not mult half
				if (readed == 0) begin
					readed <=1; 
				end else begin
					readed <=0;
				end
			end
			end
																			// do mult
		stage2phase2: begin
				//do nothing wait for ready signal of multipication
				writed<=0;
			end
																			// save result
		stage2phase3: begin // save Complex Mult Add   state 4
			stage <= nStage;
			addRam2Reg<=0;//initialization for stage odd next time
			if (signBit) begin // for mult half
				ram1ReIn <= CMAOre;
				ram1ImIn <= CMAOim;
				addRam1Reg <= addRam1;
				if (writed == 0) begin
					writed <=1; 
				end else begin
					writed <=0;
					addRam1Reg <= addRam1Reg+1;
				end
			end else begin 				// for not mult half
				ram1ReIn <= ram2ReOut;
				ram1ImIn <= ram2ImOut;
				addRam1Reg <= addRam1;
				if (writed == 0) begin
					writed <=1; 
				end else begin
					writed <=0;
					addRam1Reg <= addRam1Reg+1;
				end
			
			end
			end
		
		//--------------------- ******** muxCal
		maxCal: begin
			addRam1Reg <= sample;
			if (writed == 0) begin
				writed <= 1;
			end else begin
				writed <= 0;
				if (bigger) begin
					maxAbsX <= ram1ReOut;
					maxIndex <= addRam1Reg;
				end
			end
			end

			
		//-------------------- ******* Halt
		halt: begin
			
			ram1Copy [copyIndex -1 ] <= ram1ReOut;
			ram2Copy [copyIndex -1 ] <= ram2ReOut;
			copyIndex <= copyIndex + 1;	
			
			
			freqFinalReg <= freqFinal + 1;
	
			ledCounter <= ledCounter + 1;
			
			
			if (ledCounter==0) begin
				Led <= {Led[6:0], Led[7]};
			end else begin
				Led <= Led;
			end
			
			
			end
	endcase
	end
end

//-----------------------------------------
always @ (*) begin
	signBit = 1'b0;
	mask = 4'b1111;
	WNindex =0;
	if (stage[0]) begin      // odd stages
		case (stage[2:1]) 
			2'b00: begin
				signBit = addRam2Reg[3];
				mask = 4'b 0111;
				end
			2'b01: begin
				signBit = addRam2Reg[2];
				mask = 4'b 1011;
				end
			2'b10: begin
				signBit = addRam2Reg[1];
				mask = 4'b 1101;
				end
			2'b11: begin
				signBit = addRam2Reg[0];
				mask = 4'b 1110;
				end	
		endcase
	end else begin
		case (stage[2:1])      // even stages
			2'b00: begin
					if (stage[3]) begin  // stage 8
						signBit = 1'b1; 
					end
				end
			2'b01: begin
				signBit = addRam1Reg[3]; //stage 2
				WNindex = addRam1Reg[2:0];
				end
			2'b10: begin
				signBit = addRam1Reg[2];  //stage 4
				WNindex = {addRam1Reg[1:0],1'b0};
				end
			2'b11: begin
				signBit = addRam1Reg[1];  //stage 6
				WNindex = {addRam1Reg[0],2'b00};
				end	
		endcase
	end
end


//###################################################################################################################################################

always @ (*) begin
	//default values
	nState = 0;
	nStage = stage;
	addRam1=0;
	addRam2=0;
	wEnRam1=0;	
	wEnRam2=0;	
	start=0;
	sample = 0;
	
	//data path
	case (state)
		
		
		readData: begin //ok tested
			wEnRam1=1;
			if (addRam1Reg == 4'b1111) begin
				sample  = addRam1Reg ;
			end else begin
				sample = addRam1Reg + 1;
			end
			
			if (addRam1Reg == 4'b 1111 && hop != 0) begin
				if (hop==1) begin
					addRam1 = addRam1Reg -1  ;
				end else begin
					addRam1 = addRam1Reg ;
				end
			end else begin
				addRam1 = addRam1Reg - 2  ;
			end
			
			if (hop == 3) begin
				nState = stage1phase0;
			end else begin
				nState = readData;
			end	
			end
			
		//------------------------------------------------------------------------ ################### stage1 
		stage1phase0: begin 	
			wEnRam1=0;		   //reading first operand
			addRam1= addRam2Reg & mask;
			if (readed == 0) begin
				nState = stage1phase0;
			end else begin
				nState = stage1phase1;
			end
			end
			
			
			
		stage1phase1: begin // reading second operand and taking care of sign bit
			addRam1 = addRam2Reg | (~mask);
			if (readed == 0) begin
				nState = stage1phase1;
			end else begin
				nState = stage1phase2;
			end	
			end
		
		stage1phase2: begin //add two component
			CMAaddMult=1;
			start=1;
			nState=stage1phase2;
			if (CMAready) begin
				nState = stage1phase3;
				start=0;
			end
			end
		
		stage1phase3: begin //save to ram2
			start=0;
			wEnRam2 = 1;
			addRam2 = addRam2Reg;
			if (writed==0) begin			
				wEnRam2 = 0;
				nState  = stage1phase3;
			end else begin									// finished with this phase
				if (addRam2Reg == 15) begin			// done with this loop
					if (stage == scapeStage) begin				// if totally done
						nState = halt;
					end else begin
						nState = stage2phase0; 				
						nStage = stage + 1;
					end
				end else begin
					nState = stage1phase0;
					nStage = stage;
				end
			end
			end
		
		
		
		//------------------------------------------------------------------------ ################### stage2
		stage2phase0: begin 	//state #5
			wEnRam2=0;		   //reading first operand from ram2
			addRam2= addRam1Reg;
			if (readed == 0) begin
				nState = stage2phase0;
			end else begin
				nState = stage2phase1;
			end
			end
			
			
			
		stage2phase1: begin // reading second operand from WN
			addRam2 = addRam1Reg;
			//WNindex = addRam1Reg[2:0];
			if (readed == 0) begin
				nState = stage2phase1;
			end else begin
				nState = stage2phase2;
			end	
			end
		
		stage2phase2: begin //mult two component
			addRam2 = addRam1Reg;
			//WNindex = addRam1Reg[2:0];
			if (signBit) begin // for lower half
				CMAaddMult=0;
				start=1;
				nState=stage2phase2;
				if (CMAready) begin
					nState = stage2phase3;
					start=0;
				end
			end else begin // for upper half
				nState = stage2phase3;		
			end
			end
		
		stage2phase3: begin //save to ram1    //state # 8
			start=0;
			wEnRam1 = 1;
			addRam1 = addRam1Reg;
			addRam2 = addRam1Reg;
			if (writed==0) begin										// this phase
				wEnRam1 = 0;
				nState  = stage2phase3;
			end else begin    			// if done in this phase
			
				if (addRam1Reg == 15) begin						// if done in this stage
					
					if (stage == scapeStage) begin //if totally done ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
						nState = maxCal;
					end else begin
						nStage = stage + 1;
						nState = stage1phase0; 
					end
					
					
				end else begin
					
					nStage = stage;
					nState = stage2phase0;
				
				end
			end
			end
			
			
		//--------------------- ########### muxCal
		maxCal: begin
			cmp1 = ram1ReOut;
			cmp2 = maxAbsX;
			addRam1 = addRam1Reg;
			if (writed ==0 ) begin
				nState = maxCal;
				sample = addRam1Reg ;
				
			end else begin
				sample = addRam1Reg + 1;
	
				if (addRam1Reg == 15) begin
					nState = halt;
				end else begin
					nState = maxCal;
				end
			end
			
			end	
			
		// ################## Halt
		halt: begin
			nState = halt;		
			wEnRam1 = 0;
			wEnRam2 = 0;			
			addRam1 = copyIndex;
			addRam2 = copyIndex;
			revMaxIndex = {maxIndex[0],maxIndex[1],maxIndex[2],maxIndex[3]};
			if (revMaxIndex[3]) begin //if freq >=8
				freqFinal = revMaxIndex [2:0] + 1;
			end else begin // if less than 8
				freqFinal = revMaxIndex[2:0] - 1;
			end
			end
	
	endcase
end


//---------------- end
endmodule
