`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:35:04 08/11/2016
// Design Name:   execution_block
// Module Name:   C:/Users/admin/Desktop/LAB1/Lab1/execution_block_tb.v
// Project Name:  Lab1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: execution_block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ExecutionBlock_tb;

	// Inputs
	reg [7:0] A;
	reg [7:0] B;
	reg [7:0] data_in;
	reg [4:0] op_dec;
	reg clk;
	reg mem_en_dec;
	reg mem_rw_dec;
	reg mem_mux_sel_dec;
	reg [4:0] RW_dec;
	reg reset;

	// Outputs
	wire [3:0] flag_ex;
	wire [7:0] ans_ex;
	wire [7:0] data_out;
	wire mem_en_ex;
	wire mem_rw_ex;
	wire mem_mux_sel_ex;
	wire [4:0] RW_ex;
	wire [7:0] B_Bypass;

	// Instantiate the Unit Under Test (UUT)
	ExecutionBlock uut (
		.A(A), 
		.B(B), 
		.data_in(data_in), 
		.op_dec(op_dec), 
		.clk(clk), 
		.mem_en_dec(mem_en_dec), 
		.mem_rw_dec(mem_rw_dec), 
		.mem_mux_sel_dec(mem_mux_sel_dec), 
		.RW_dec(RW_dec), 
		.reset(reset), 
		.flag_ex(flag_ex), 
		.ans_ex(ans_ex), 
		.data_out(data_out), 
		.mem_en_ex(mem_en_ex), 
		.mem_rw_ex(mem_rw_ex), 
		.mem_mux_sel_ex(mem_mux_sel_ex), 
		.RW_ex(RW_ex),
		.B_Bypass(B_Bypass)
	);

	initial begin
	
		//Changing and assigning variables as per test vector
		clk=0;		
		reset=1;
		
		#200;	
		reset= 1'b0;
		
		#600;
		reset=1'b1;
		
		#200;		
		A = 16'h40;
		B = 16'hC0;
		data_in = 16'h08;
		op_dec = 5'b00000;
		mem_en_dec = 1'b0;
		mem_rw_dec = 1'b0;
		mem_mux_sel_dec = 1'b0;
		RW_dec = 5'b00101;
		
		#1000;	
		op_dec = 5'b00001;
		
		#1000;
		op_dec = 5'b00010;
		
		
		#1000;
		op_dec = 5'b00100;
		
		#1000;
		op_dec = 5'b00101;
		
		#1000;
		op_dec = 5'b00110;
		
		#1000;
		op_dec = 5'b00111;
		
		#1000;
		op_dec = 5'b01000;
		
		#1000;
		op_dec = 5'b01001;
		
		#1000;
		op_dec = 5'b01010;
		
		#1000;
		op_dec = 5'b01100;
		
		#1000;
		op_dec = 5'b01101;
		
		#1000;
		op_dec = 5'b01110;
		
		#1000;
		op_dec = 5'b01111;
		
		#1000;
		op_dec = 5'b10000;
		
		#1000;
		op_dec = 5'b10001;
		
		#1000;
		op_dec = 5'b10100;
		
		#1000;
		op_dec = 5'b10101;
		
		#1000;
		op_dec = 5'b10110;
		
		#1000;
		op_dec = 5'b10111;
		
		#1000;
		op_dec = 5'b11000;
		
		#1000;
		A = 16'hC0;
		B = 16'h01;
		data_in = 16'h08;
		op_dec = 5'b11001;
		mem_en_dec = 1;
		mem_rw_dec = 1;
		mem_mux_sel_dec = 1;
		RW_dec = 5'b01010;
		
		#1000;
		op_dec = 5'b11010;
		
		#1000;
		op_dec = 5'b11011;
		
		#1000;
		op_dec = 5'b11100;
		
		#1000;
		op_dec = 5'b11101;
		
		#1000;
		op_dec = 5'b11110;
		
	   #1000;
		op_dec = 5'b11111;
		
	end
      
//Generating clock frequency	
always #500 clk = ~clk;
		
endmodule
