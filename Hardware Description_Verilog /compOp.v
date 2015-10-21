`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:57:45 12/14/2014 
// Design Name: 
// Module Name:    compOp 
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
module compOp(re1,im1,re2,im2,re,im,ready,start,clk,op,rst);

input [31:0] re1;
input [31:0] im1;
input [31:0] re2;
input [31:0] im2;  
output reg [31:0] re;
output reg [31:0] im;
output reg ready;
input start;
input clk;
input op;
input rst;
wire [31:0] myre1,myim1,myre2,myim2;
wire [31:0] adderIn1;
wire [31:0] adderIn2;
wire [31:0] adderRes;
wire [31:0] mulIn1;
wire [31:0] mulIn2;
wire [31:0] mulRes;
wire [31:0] mulResplmi;
reg [31:0] adderResLatched;

wire readyAdd,readyMul;
reg startAdd,startMul,adderResLatchEn,outputReEn,outputImEn,negSel;
reg in1AddSel,in2AddSel,in1MulSel,in2MulSel;

parameter HALT = 0, MUL1 = 1, ADDERCAL1 = 2,ADDERLATCH1=3, MUL2=4, ADDERCAL2=5;
parameter RESETADDERREG=6, MUL3=7,ADDERCAL3=8,ADDERLATCH3=9, MUL4=10,ADDERCAL4=11, IMSTORE=12,END=17;
parameter ADD1=13,REALSTOREADD=14,ADD2=15,IMSTOREADD=16;

reg [4:0] state, next_state;

//-----------------		data path		---------------------------------

assign mulIn1=((in1MulSel==0)?re1:im1);
assign mulIn2=((in2MulSel==0)?re2:im2);
assign mulResplmi[30:0]=mulRes[30:0];
assign mulResplmi[31]=((negSel==1)?(~mulRes[31]):(mulRes[31]));
assign adderIn1=((in1AddSel==0)?mulIn1:mulResplmi);
assign adderIn2=((in2AddSel==0)?mulIn2:adderResLatched);

adderDriver add(adderIn1,adderIn2,adderRes,clk,startAdd,readyAdd,rst);
mulDriver mul(mulIn1,mulIn2,mulRes,clk,startMul,readyMul,rst);	

//---------------		FSM					---------------------------------
always @(posedge clk)	begin
	adderResLatched<=((state == RESETADDERREG || state == HALT || rst == 1)?(32'b0):((adderResLatchEn == 1)?adderRes:adderResLatched));
	re <= ((rst == 1)?0:((outputReEn == 0)?re:adderRes));
	im <= ((rst == 1)?0:((outputImEn == 0)?im:adderRes));
	if (rst) begin
		state <= HALT;
	end
	else begin
		state <= next_state;
	end
end	


always @(*)	begin
in1MulSel<=0;
in2MulSel<=0;
negSel<=0;
in1AddSel<=0;
in2AddSel<=0;
adderResLatchEn<=0;
startMul<=0;
startAdd<=0;
outputReEn<=0;
outputImEn<=0;
ready <= 0;
	case (state)
	HALT:	begin
		in1MulSel<=0;
		in2MulSel<=0;
		negSel<=0;
		in1AddSel<=0;
		in2AddSel<=0;
		adderResLatchEn<=0;
		startMul<=0;
		startAdd<=0;
		outputReEn<=0;
		outputImEn<=0;
		ready <= 0;
	end
	MUL1:	begin
		in1MulSel<=0;
		in2MulSel<=0;
		negSel<=0;
		in1AddSel<=1;
		in2AddSel<=1;
		adderResLatchEn<=0;
		startMul<=1;
		startAdd<=0;
		outputReEn<=0;
		outputImEn<=0;
		ready <= 0;
	end
	ADDERCAL1:	begin
		in1MulSel<=0;
		in2MulSel<=0;
		negSel<=0;
		in1AddSel<=1;
		in2AddSel<=1;
		adderResLatchEn<=0;
		startMul<=0;
		startAdd<=1;
		outputReEn<=0;
		outputImEn<=0;
		ready <= 0;
	end
	ADDERLATCH1:	begin
		in1MulSel<=0;
		in2MulSel<=0;
		negSel<=0;
		in1AddSel<=1;
		in2AddSel<=1;
		adderResLatchEn<=1;
		startMul<=0;
		startAdd<=0;
		outputReEn<=0;
		outputImEn<=0;
		ready <= 0;
	end
	MUL2:	begin
		in1MulSel<=1;
		in2MulSel<=1;
		negSel<=1;
		in1AddSel<=1;
		in2AddSel<=1;
		adderResLatchEn<=0;
		startMul<=1;
		startAdd<=0;
		outputReEn<=0;
		outputImEn<=0;
		ready <= 0;
	end
	ADDERCAL2:	begin
		in1MulSel<=1;
		in2MulSel<=1;
		negSel<=1;
		in1AddSel<=1;
		in2AddSel<=1;
		adderResLatchEn<=0;
		startMul<=0;
		startAdd<=1;
		outputReEn<=0;
		outputImEn<=0;
		ready <= 0;
	end
	RESETADDERREG:	begin
		in1MulSel<=1;
		in2MulSel<=1;
		negSel<=1;
		in1AddSel<=1;
		in2AddSel<=1;
		adderResLatchEn<=0;
		startMul<=0;
		startAdd<=0;
		outputReEn<=1;
		outputImEn<=0;
		ready <= 0;
	end
	MUL3:	begin
		in1MulSel<=0;
		in2MulSel<=1;
		negSel<=0;
		in1AddSel<=1;
		in2AddSel<=1;
		adderResLatchEn<=0;
		startMul<=1;
		startAdd<=0;
		outputReEn<=0;
		outputImEn<=0;
		ready <= 0;
	end
	ADDERCAL3:	begin
		in1MulSel<=0;
		in2MulSel<=1;
		negSel<=0;
		in1AddSel<=1;
		in2AddSel<=1;
		adderResLatchEn<=0;
		startMul<=0;
		startAdd<=1;
		outputReEn<=0;
		outputImEn<=0;
		ready <= 0;
	end
	ADDERLATCH3:	begin
		in1MulSel<=0;
		in2MulSel<=1;
		negSel<=0;
		in1AddSel<=1;
		in2AddSel<=1;
		adderResLatchEn<=1;
		startMul<=0;
		startAdd<=0;
		outputReEn<=0;
		outputImEn<=0;
		ready <= 0;
	end
	MUL4:	begin
		in1MulSel<=1;
		in2MulSel<=0;
		negSel<=0;
		in1AddSel<=1;
		in2AddSel<=1;
		adderResLatchEn<=0;
		startMul<=1;
		startAdd<=0;
		outputReEn<=0;
		outputImEn<=0;
		ready <= 0;
	end
	ADDERCAL4:	begin
		in1MulSel<=1;
		in2MulSel<=0;
		negSel<=0;
		in1AddSel<=1;
		in2AddSel<=1;
		adderResLatchEn<=0;
		startMul<=0;
		startAdd<=1;
		outputReEn<=0;
		outputImEn<=0;
		ready <= 0;
	end
	IMSTORE:	begin
		in1MulSel<=1;
		in2MulSel<=0;
		negSel<=0;
		in1AddSel<=1;
		in2AddSel<=1;
		adderResLatchEn<=0;
		startMul<=0;
		startAdd<=0;
		outputReEn<=0;
		outputImEn<=1;
		ready <= 0;
	end
	ADD1:	begin
		in1MulSel<=0;
		in2MulSel<=0;
		negSel<=0;
		in1AddSel<=0;
		in2AddSel<=0;
		adderResLatchEn<=0;
		startMul<=0;
		startAdd<=1;
		outputReEn<=0;
		outputImEn<=0;
		ready <= 0;
	end
	REALSTOREADD:	begin
		in1MulSel<=0;
		in2MulSel<=0;
		negSel<=0;
		in1AddSel<=0;
		in2AddSel<=0;
		adderResLatchEn<=0;
		startMul<=0;
		startAdd<=0;
		outputReEn<=1;
		outputImEn<=0;
		ready <= 0;
	end
	ADD2:	begin
		in1MulSel<=1;
		in2MulSel<=1;
		negSel<=0;
		in1AddSel<=0;
		in2AddSel<=0;
		adderResLatchEn<=0;
		startMul<=0;
		startAdd<=1;
		outputReEn<=0;
		outputImEn<=0;
		ready <= 0;
	end
	IMSTOREADD:	begin
		in1MulSel<=1;
		in2MulSel<=1;
		negSel<=0;
		in1AddSel<=0;
		in2AddSel<=0;
		adderResLatchEn<=0;
		startMul<=0;
		startAdd<=0;
		outputReEn<=0;
		outputImEn<=1;
		ready <= 0;
	end
	END:	begin
		in1MulSel<=0;
		in2MulSel<=0;
		negSel<=0;
		in1AddSel<=0;
		in2AddSel<=0;
		adderResLatchEn<=0;
		startMul<=0;
		startAdd<=0;
		outputReEn<=0;
		outputImEn<=0;
		ready <= 1;
	end
	endcase
end
always @(*)	begin
	next_state<=HALT;
	case (state)
	HALT:	begin
		if (start==1)	begin
			if (op==0)	begin
				next_state <= MUL1;
			end
			else	begin
				next_state <= ADD1;
			end
		end
		else	begin
			next_state <= HALT;
		end
	end
	MUL1:	begin
		if ( readyMul == 1)	next_state <= ADDERCAL1;
		else next_state <= MUL1;
	end
	ADDERCAL1:	begin
		if ( readyAdd == 1)	next_state <= ADDERLATCH1;
		else next_state <= ADDERCAL1;
	end
	ADDERLATCH1:	begin
		next_state <= MUL2;
	end
	MUL2:	begin
		if ( readyMul == 1)	next_state <= ADDERCAL2;
		else next_state <= MUL2;
	end
	ADDERCAL2:	begin
		if ( readyAdd == 1)	next_state <= RESETADDERREG;
		else next_state <= ADDERCAL2;
	end
	RESETADDERREG:	begin
		next_state <= MUL3;
	end
	MUL3:	begin
		if ( readyMul == 1)	next_state <= ADDERCAL3;
		else next_state <= MUL3;
	end
	ADDERCAL3:	begin
		if ( readyAdd == 1)	next_state <= ADDERLATCH3;
		else next_state <= ADDERCAL3;
	end
	ADDERLATCH3:	begin
		next_state <= MUL4;
	end
	MUL4:	begin
		if ( readyMul == 1)	next_state <= ADDERCAL4;
		else next_state <= MUL4;
	end
	ADDERCAL4:	begin
		if ( readyAdd == 1)	next_state <= IMSTORE;
		else next_state <= ADDERCAL4;
	end
	IMSTORE:	begin
		next_state <= END;
	end
	ADD1:	begin
		if ( readyAdd == 1)	next_state <= REALSTOREADD;
		else next_state <= ADD1;
	end
	REALSTOREADD:	begin
		next_state <= ADD2;
	end
	ADD2:	begin
		if ( readyAdd == 1)	next_state <= IMSTOREADD;
		else next_state <= ADD2;
	end
	IMSTOREADD:	begin
		next_state <= END;
	end
	END:	begin
		next_state <= HALT;
	end
endcase
end
endmodule

