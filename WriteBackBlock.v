
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Group : A11
//Members : Heet Gorakhiya, Kartavya Bhatt, Sahil Panchal
//Code : For Write Back block
//Description : To 8 bit number which can be served as operand
//////////////////////////////////////////////////////////////////////////////////

module WriteBackBlock(ans_wb, mux_ans_dm, clk, reset);

//Declaring inputs and output
input[7:0] mux_ans_dm;
input clk, reset;

output reg[7:0] ans_wb;

//Declaring wire
wire[7:0] ans_wb_reg;

//Assigning values to variables which are inputs to sequential circuit and outputs of mux with reset as selection line to avoid combinational logic in sequential block
assign ans_wb_reg = reset ? mux_ans_dm : 8'b0;

//Sequential circuit
always@(posedge clk)
begin
	ans_wb <= ans_wb_reg;
end

endmodule
