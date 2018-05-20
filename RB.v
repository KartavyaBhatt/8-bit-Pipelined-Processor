
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Group : A11
//Members : Heet Gorakhiya, Kartavya Bhatt, Sahil Panchal
//Code : For Register bank
//Description : To get operands for execution block
//////////////////////////////////////////////////////////////////////////////////

module RB(A, B, ins, RW_dm, ans_ex, mux_ans_dm, ans_wb, imm, mux_sel_A, mux_sel_B, imm_sel, clk, reset);


//Declaring inputs and outputs
input imm_sel, clk, reset;
input[19:0] ins;
input[4:0] RW_dm;
input[7:0] ans_ex, mux_ans_dm, ans_wb, imm;
input[1:0] mux_sel_A, mux_sel_B;

output[7:0] A, B;


//Declaring wires and regs as per the block diagram
wire[7:0] temp_B;
reg[7:0] Register_Bank[0:31];
reg[7:0] reg_A, reg_B;


//Declaring variables for combinational curcuit of register
wire[7:0] regA_temp, regB_temp;


//Assigning values to variables which are inputs to sequential circuit and outputs of mux with reset as selection line to avoid combinational logic in sequential block
assign regA_temp = reset ? Register_Bank[ins[9:5]] : 8'b0;
assign regB_temp = reset ? Register_Bank[ins[4:0]] : 8'b0;

//Sequential circuit
always@(posedge clk)
begin
	Register_Bank[RW_dm] <= mux_ans_dm;
	reg_A <= regA_temp;
	reg_B <= regB_temp;
end


//Initializing register bank
initial
begin
	Register_Bank[0] <= 8'h00;
	Register_Bank[1] <= 8'h01;
	Register_Bank[2] <= 8'h02;
	Register_Bank[3] <= 8'h03;
	Register_Bank[4] <= 8'h04;
	Register_Bank[5] <= 8'h05;
	Register_Bank[6] <= 8'h06;
	Register_Bank[7] <= 8'h07;
	Register_Bank[8] <= 8'h08;
	Register_Bank[9] <= 8'h09;
	Register_Bank[10] <= 8'h10;
	Register_Bank[11] <= 8'h11;
	Register_Bank[12] <= 8'h12;
	Register_Bank[13] <= 8'h13;
	Register_Bank[14] <= 8'h14;
	Register_Bank[15] <= 8'h15;
	Register_Bank[16] <= 8'h16;
	Register_Bank[17] <= 8'h17;
	Register_Bank[18] <= 8'h18;
	Register_Bank[19] <= 8'h19;
	Register_Bank[20] <= 8'h20;
	Register_Bank[21] <= 8'h21;
	Register_Bank[22] <= 8'h22;
	Register_Bank[23] <= 8'h23;
	Register_Bank[24] <= 8'h24;
	Register_Bank[25] <= 8'h25;
	Register_Bank[26] <= 8'h26;
	Register_Bank[27] <= 8'h27;
	Register_Bank[28] <= 8'h28;
	Register_Bank[29] <= 8'h29;
	Register_Bank[30] <= 8'h30;
	Register_Bank[31] <= 8'h31;
end



//Assignigng values to operands using mux having selection line as mux_sel__
assign A = mux_sel_A == 2'b00 ? reg_A : (mux_sel_A == 2'b01 ? ans_ex : (mux_sel_A == 2'b10 ? mux_ans_dm : (mux_sel_A == 2'b11 ? ans_wb : 8'b0)));
assign temp_B = mux_sel_B == 2'b00 ? reg_B : (mux_sel_B == 2'b01 ? ans_ex : (mux_sel_B == 2'b10 ? mux_ans_dm : (mux_sel_B == 2'b11 ? ans_wb : 8'b0)));
assign B = imm_sel ? imm : temp_B;

endmodule
