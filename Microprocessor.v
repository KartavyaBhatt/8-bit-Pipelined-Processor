`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Group : A11
//Members : Heet Gorakhiya, Kartavya Bhatt, Sahil Panchal
//Code : For top module Microprocessor
//Description : To assemble all the blocks and complete the architecture 
//////////////////////////////////////////////////////////////////////////////////

module Microprocessor(ins, A, B, current_address, ans_ex, mux_ans_dm, ans_wb, data_out, data_in, interrupt, clk, reset);
//Declaring inputs
input [7:0] data_in;
input clk;
input interrupt;
input reset;

//Declaring outputs
output [7:0] data_out;
output [19:0] ins;
output [7:0] A;
output [7:0] B;
output [7:0] current_address;
output [7:0] ans_ex;
output [7:0] mux_ans_dm;
output [7:0] ans_wb;


//Declaring wires which will connect blocks
wire[19:0] ins_pm;
wire[4:0] RW_dec, RW_dm, RW_ex, op_dec;
wire[7:0] jmp_loc, B_Bypass, Imm;
wire pc_mux_sel, stall, stall_pm, mem_en_ex, mem_rw_ex, mem_mux_sel_ex, imm_sel, mem_en_dec, mem_rw_dec, mem_mux_sel_dec;
wire[1:0] mux_sel_A, mux_sel_B;
wire[3:0] flag_ex;


//Calling instance of each block
DM inst0(mux_ans_dm, RW_dm, ans_ex, B_Bypass, RW_ex, mem_en_ex, mem_rw_ex, mem_mux_sel_ex, clk, reset);
DependencyCheckBlock inst1(mux_sel_A, mux_sel_B, imm_sel, Imm, mem_en_dec, mem_rw_dec, mem_mux_sel_dec, RW_dec, op_dec, ins, clk, reset);
ExecutionBlock inst2(flag_ex, ans_ex, data_out, B_Bypass, mem_en_ex, mem_rw_ex, mem_mux_sel_ex, RW_ex, A, B, data_in, op_dec, clk, mem_en_dec, mem_rw_dec, mem_mux_sel_dec, RW_dec, reset);
JumpControlBlock inst3(pc_mux_sel, jmp_loc, ins, clk, interrupt, current_address, flag_ex, reset);
PCandIM inst4(ins, ins_pm, current_address, jmp_loc, pc_mux_sel, stall, stall_pm, reset, clk);
RB inst5(A, B, ins, RW_dm, ans_ex, mux_ans_dm, ans_wb, Imm, mux_sel_A, mux_sel_B, imm_sel, clk, reset);
StallControlBlock inst6(stall, stall_pm, ins_pm, clk, reset);
WriteBackBlock inst7(ans_wb, mux_ans_dm, clk, reset);

endmodule
