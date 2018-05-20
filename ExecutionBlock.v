`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Group : A11
//Members : Heet Gorakhiya, Kartavya Bhatt, Sahil Panchal
//Code : For Excution Block
//Description : To create ALU which gives almost all outputs on positive clock edge
//////////////////////////////////////////////////////////////////////////////////
module ExecutionBlock(flag_ex, ans_ex, data_out, B_Bypass, mem_en_ex, mem_rw_ex, mem_mux_sel_ex, RW_ex, A, B, data_in, op_dec, clk, mem_en_dec, mem_rw_dec, mem_mux_sel_dec, RW_dec, reset);

//Defining inputs
input[7:0] A, B, data_in;
input[4:0] op_dec, RW_dec;
input clk, mem_en_dec, mem_rw_dec, mem_mux_sel_dec, reset;


//Defining outputs
output reg[7:0] ans_ex, data_out, B_Bypass;
output reg[4:0] RW_ex;
output [3:0] flag_ex;
output reg mem_en_ex, mem_rw_ex, mem_mux_sel_ex;


//Defining variables for inputs of Sequential circuit
wire[7:0] ans_ex_reg, B_Bypass_reg, data_out_reg;// data_out_buff_reg;
wire[4:0] RW_ex_reg;
wire mem_en_ex_reg, mem_rw_ex_reg, mem_mux_sel_ex_reg;

//Defining temperary variables
wire[7:0] ans_temp;
wire[7:0] data_out_buff;
reg[3:0] flag_ex_clk;


//Defingin variables which will store answers of different operations
wire[7:0] temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9, temp10, temp11, temp12, temp13, temp14, temp15, temp16, temp17, temp18, temp19, temp20, temp21, temp22, temp23, temp24, temp25, temp26, temp27, temp28;

//Difining variables which will store flags for each instruction
wire[3:0] f_temp1, f_temp2, f_temp3, f_temp4;

//Some temp flags
wire P, Z, C, V;

//Defining variables to duplicate operands for avoiding bloking statements
wire[7:0] A_temp;
wire[2:0] shiftAmt;

assign A_temp = A;
assign shiftAmt = B[2:0];


//Defining variables helpful in Arithmatic Shift
wire[7:0] retain1, retain2, retain3, retain4, retain5, retain6, retain7, retain8;

assign retain1 = {A[7], 7'b0000000};
assign retain2 = {A[7], A[7], 6'b000000};
assign retain3 = {A[7], A[7], A[7], 5'b00000};
assign retain4 = {A[7], A[7], A[7], A[7], 4'b0000};
assign retain5 = {A[7], A[7], A[7], A[7], A[7], 3'b000};
assign retain6 = {A[7], A[7], A[7], A[7], A[7], A[7], 2'b00};
assign retain7 = {A[7], A[7], A[7], A[7], A[7], A[7], A[7], 1'b0};
assign retain8 = {A[7], A[7], A[7], A[7], A[7], A[7], A[7], A[7]};


//---------------------------------Combinational Circuits for add and substract-----------------------------------------

//Declaring useful variables for deciding variables
wire[7:0] Sum_temp1, Sum_temp2, B_SUB;
wire temp_carry, temp_carry1, C_temp1, C_temp2, V_temp1, V_temp2;

//Assigning value to variable which will act like (-B)
assign B_SUB = ~B + 8'b00000001;


//Combinational circuit for addition
assign {temp_carry , Sum_temp1[6:0] } = A[6:0] + B[6:0];
assign { C_temp1 ,Sum_temp1[7] } = A[7] + B[7] + temp_carry;
assign V_temp1 = temp_carry ^ C_temp1;



//Combinational circuit for substraction
assign {temp_carry1 , Sum_temp2[6:0] } = A[6:0] + B_SUB[6:0];
assign { C_temp2 ,Sum_temp2[7] } = A[7] + B_SUB[7] + temp_carry1;
assign V_temp2 = temp_carry1 ^ C_temp2;



//------------------------------------Creating combinational cloud----------------------------------------


//Evaluating instructions as per op_dec
assign temp1 = (op_dec == 5'b00000) ? Sum_temp1 : 8'b00000000;
assign temp2 = (op_dec == 5'b00001) ? Sum_temp2 : 8'b00000000;
assign temp3 = (op_dec == 5'b00010) ? B : 8'b00000000;
assign temp4 = (op_dec == 5'b00100) ? (A & B) : 8'b00000000;
assign temp5 = (op_dec == 5'b00101) ? (A | B) : 8'b00000000;
assign temp6 = (op_dec == 5'b00110) ? (A ^ B) : 8'b00000000;
assign temp7 = (op_dec == 5'b00111) ? (~B) : 8'b00000000;
assign temp8 = (op_dec == 5'b01000) ? Sum_temp1 : 8'b00000000;
assign temp9 = (op_dec == 5'b01001) ? Sum_temp2 : 8'b00000000;
assign temp10 = (op_dec == 5'b01010) ? B : 8'b00000000;
assign temp11 = (op_dec == 5'b01100) ? (A & B) : 8'b00000000;
assign temp12 = (op_dec == 5'b01101) ? (A | B) : 8'b00000000;
assign temp13 = (op_dec == 5'b01110) ? (A ^ B) : 8'b00000000;
assign temp14 = (op_dec == 5'b01111) ? (~B) : 8'b00000000;
assign temp15 = (op_dec == 5'b10000) ? (ans_ex) : 8'b00000000;
assign temp16 = (op_dec == 5'b10001) ? (ans_ex) : 8'b00000000;
assign temp17 = (op_dec == 5'b10100) ? A : 8'b00000000;
assign temp18 = (op_dec == 5'b10101) ? A : 8'b00000000;
assign temp19 = (op_dec == 5'b10110) ? data_in : 8'b00000000;
assign temp20 = (op_dec == 5'b10111) ? (ans_ex) : 8'b00000000;
assign temp21 = (op_dec == 5'b11000) ? (ans_ex) : 8'b00000000;
assign temp22 = (op_dec == 5'b11001) ? (A_temp << shiftAmt) : 8'b00000000;
assign temp23 = (op_dec == 5'b11010) ? (A_temp >> shiftAmt) : 8'b00000000;
assign temp24 = (op_dec == 5'b11011) ? (shiftAmt == 3'b000 ? A_temp : (shiftAmt == 3'b001 ? ((A_temp >> 3'b001) | retain1) : (shiftAmt == 3'b010 ? ((A_temp >> 3'b010) | retain2) : (shiftAmt == 3'b011 ? ((A_temp >> 3'b011) | retain3) : (shiftAmt == 3'b100 ? ((A_temp >> 3'b100) | retain4) : (shiftAmt == 3'b101 ? ((A_temp >> 3'b101) | retain5) : (shiftAmt == 3'b110 ? ((A_temp >> 3'b110) | retain6) : (shiftAmt == 3'b111 ? ((A_temp >> 3'b111) | retain7) : retain8)))))))) : 8'b00000000;
assign temp25 = (op_dec == 5'b11100) ? (ans_ex) : 8'b00000000;
assign temp26 = (op_dec == 5'b11101) ? (ans_ex) : 8'b00000000;
assign temp27 = (op_dec == 5'b11110) ? (ans_ex) : 8'b00000000;
assign temp28 = (op_dec == 5'b11111) ? (ans_ex) : 8'b00000000;




//Assigning operated result to ans_temp to send it to register
assign ans_temp = (temp1 | temp2 | temp3 | temp4 | temp5 | temp6 | temp7 | temp8 | temp9 | temp10 | temp11 | temp12 | temp13 | temp14 | temp15 | temp16 | temp17 | temp18 | temp19 | temp20 | temp21 | temp22 | temp23 | temp24 | temp25 | temp26 | temp27 | temp28);


//Checking flag status
assign P = (ans_temp[7] ^ ans_temp[6] ^ ans_temp[5] ^ ans_temp[4] ^ ans_temp[3] ^ ans_temp[2] ^ ans_temp[1] ^ ans_temp[0]); 
assign Z = ~(ans_temp[7] | ans_temp[6] | ans_temp[5] | ans_temp[4] | ans_temp[3] | ans_temp[2] | ans_temp[1] | ans_temp[0]);
assign C = (op_dec == 5'b00000 || op_dec == 5'b01000) ? C_temp1 : ((op_dec == 5'b01001 || op_dec == 5'b00001) ? C_temp2 : 1'b0);
assign V = (op_dec == 5'b00000 || op_dec == 5'b01000) ? V_temp1 : ((op_dec == 5'b01001 || op_dec == 5'b00001) ? V_temp2 : 1'b0);

//Assigning values to temperary flags which will behave as states 
assign f_temp1 = (op_dec == 5'b00000 || op_dec == 5'b00001 || op_dec == 5'b01000 || op_dec == 5'b01001) ? ({P, V, Z, C}) : 4'b0000;
assign f_temp2 = (op_dec == 5'b00010 || op_dec == 5'b00100 || op_dec == 5'b00101 || op_dec == 5'b00110 || op_dec == 5'b00111 || op_dec == 5'b01010 || op_dec == 5'b01100 || op_dec == 5'b01101 || op_dec == 5'b01110 || op_dec == 5'b01111 || op_dec == 5'b10110 || op_dec == 5'b11001 || op_dec == 5'b11010 || op_dec == 5'b11011) ? ({P, 1'b0, Z, 1'b0}) : 4'b0000;
assign f_temp3 = 4'b0000;
assign f_temp4 = (op_dec == 5'b10100 || op_dec == 5'b10101 || op_dec == 5'b10111 || op_dec == 5'b11000 || op_dec == 5'b11100 || op_dec == 5'b11101 || op_dec == 5'b11110 || op_dec == 5'b11111) ? flag_ex_clk : 4'b0000;


//Handeling flag as per op_dec
assign flag_ex = f_temp1 | f_temp2 | f_temp3 | f_temp4;


//Assigning values to variables which are inputs to sequential circuit and outputs of mux with reset as selection line to avoid combinational logic in sequential block
assign ans_ex_reg = reset ? ans_temp : 8'b0;
assign data_out_reg = reset ? data_out_buff : 8'b0;
assign B_Bypass_reg = reset ? B : 8'b0;
assign mem_en_ex_reg = reset ? mem_en_dec : 1'b0;
assign mem_rw_ex_reg = reset ? mem_rw_dec : 1'b0;
assign RW_ex_reg = reset ? RW_dec : 5'b0;
assign mem_mux_sel_ex_reg = reset ? mem_mux_sel_dec : 1'b0;

//Assigning amd holding value of data_out_buff
assign data_out_buff = (op_dec==5'b10111) ? A : data_out;


//--------------------------------------------End of Combinational cloud-----------------------------------------------------





//-------------------------------------------------Sequential Circuit----------------------------------------------

//Implimenting negative level triggered and clock synchronous reset
always@(posedge clk)
begin 
	ans_ex <= ans_ex_reg;
	data_out <= data_out_reg;
	B_Bypass <= B_Bypass_reg;
	mem_en_ex <= mem_en_ex_reg;
	mem_rw_ex <= mem_rw_ex_reg;
	RW_ex <= RW_ex_reg;
	mem_mux_sel_ex <= mem_mux_sel_ex_reg;
	flag_ex_clk <= flag_ex;
end

//-----------------------------------------End of sequential circuit---------------------------------------------	
	

endmodule
