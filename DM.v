`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Group : A11
//Members : Heet Gorakhiya, Kartavya Bhatt, Sahil Panchal
//Code : For Data Memory Block
//Description : To read or write data from execution block and to forward the destination address
//////////////////////////////////////////////////////////////////////////////////
module DM(mux_ans_dm, RW_dm, ans_ex, B_Bypass, RW_ex, mem_en_ex, mem_rw_ex, mem_mux_sel_ex, clk, reset);


//Declaring inputs
input[7:0] ans_ex, B_Bypass;
input[4:0] RW_ex;
input mem_en_ex, mem_rw_ex, mem_mux_sel_ex, clk, reset;

//Declaring outputs
output [7:0] mux_ans_dm;
output reg[4:0] RW_dm;

//Declaring wire and regs
wire[7:0] ans_dm;
reg[7:0] ans_reg;
reg mem_mux_sel_dm;

//Declaring variables for combinational curcuit of register
wire[4:0] ans_ex_temp;
wire[4:0] RW_ex_temp;
wire mem_mux_sel_ex_temp;


//Assigning values to variables which are inputs to sequential circuit and outputs of mux with reset as selection line to avoid combinational logic in sequential block
assign ans_ex_temp = reset ? ans_ex : 8'b0;
assign mem_mux_sel_ex_temp = reset ? mem_mux_sel_ex : 1'b0;
assign RW_ex_temp = reset ? RW_ex : 5'b0;


//Sequential curcuit for register
always@(posedge clk)
begin
	ans_reg = ans_ex_temp;
	mem_mux_sel_dm = mem_mux_sel_ex_temp;
	RW_dm = RW_ex_temp;
end


//Calling instance of data memory
DataMemory dataMem (
  .clka(clk), 
  .ena(mem_en_ex), 
  .wea(mem_rw_ex), 
  .addra(ans_ex), 
  .dina(B_Bypass), 
  .douta(ans_dm) 
);


//Assigning value to output 
assign mux_ans_dm = mem_mux_sel_dm ? ans_dm : ans_reg;

endmodule
