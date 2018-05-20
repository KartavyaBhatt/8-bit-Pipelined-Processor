`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Group : A11
//Members : Heet Gorakhiya, Kartavya Bhatt, Sahil Panchal
//Code : For Stall Control block
//Description : To generate stall signals
//////////////////////////////////////////////////////////////////////////////////

module StallControlBlock(stall, stall_pm, ins_pm, clk, reset);

//Declaring inputs
input[19:0] ins_pm;
input clk, reset;


//Declaring outputs
output stall;
output reg stall_pm;


//Declaring to detect particular operations
wire Jump, Load, HLT;

//Declaring wires and regs for sequential circuit for stalling
wire Q_LD_temp, Q_JMP1_temp, Q_JMP2_temp, stall_pm_temp;
reg Q_LD, Q_JMP1, Q_JMP2;



//Conbinational curcuit
assign Load = (ins_pm[19: 15] == 5'b10100) & (~Q_LD) ? 1 : 0;		//To detect Load instruction
assign HLT = (ins_pm[19: 15] == 5'b10001) ? 1'b1 : 1'b0;				//To detect Halt instruction
assign Jump = (ins_pm[19:17] == 3'b111) & (~Q_JMP2) ? 1 : 0;		//To detect Jump instruction


//Assigning values to variables which are inputs to sequential circuit and outputs of mux with reset as selection line to avoid combinational logic in sequential block
assign Q_LD_temp = reset ? Load : 1'b0;
assign Q_JMP1_temp = reset ? Jump : 1'b0;
assign Q_JMP2_temp = reset ? Q_JMP1 : 1'b0;
assign stall_pm_temp = reset ? stall : 1'b0;

//Sequential circuit for flipflops
always@(posedge clk)
begin
	stall_pm <= stall_pm_temp;
	Q_LD <= Q_LD_temp;
	Q_JMP1 <= Q_JMP1_temp;
	Q_JMP2 <= Q_JMP2_temp;
end


//Assigning value to stall
assign stall = Load | HLT | Jump;

endmodule
