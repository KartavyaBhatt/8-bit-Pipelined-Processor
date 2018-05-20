`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:04:00 10/15/2016
// Design Name:   Microprocessor
// Module Name:   E:/Semester - 3/CO/Lab/Microprocessor/Microprocessor_tb.v
// Project Name:  Microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Microprocessor
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Microprocessor_tb;

	// Inputs
	reg [7:0] data_in;
	reg interrupt;
	reg clk;
	reg reset;

	// Outputs
	wire [19:0] ins;
	wire [7:0] A;
	wire [7:0] B;
	wire [7:0] current_address;
	wire [7:0] ans_ex;
	wire [7:0] mux_ans_dm;
	wire [7:0] ans_wb;
	wire [7:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	Microprocessor uut (
		.ins(ins), 
		.A(A), 
		.B(B), 
		.current_address(current_address), 
		.ans_ex(ans_ex), 
		.mux_ans_dm(mux_ans_dm), 
		.ans_wb(ans_wb), 
		.data_out(data_out), 
		.data_in(data_in), 
		.interrupt(interrupt), 
		.clk(clk), 
		.reset(reset)
	);

	initial
	begin
		data_in = 1'b0;
		interrupt = 1'b0;
		clk = 1'b0;
		reset = 1'b1;
		#200; reset = 1'b0;
		#500; reset = 1'b1;
	end
	
	always	#500 clk = ~clk;
	
endmodule

