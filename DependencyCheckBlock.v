`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Group : A11
//Members : Heet Gorakhiya, Kartavya Bhatt, Sahil Panchal
//Code : For Dependency Check Block
//Description : To check dependency between all the blocks to avoid hazards and outputs selection lines to the solution muxes
//////////////////////////////////////////////////////////////////////////////////

module DependencyCheckBlock(mux_sel_A, mux_sel_B, imm_sel, Imm, mem_en_dec, mem_rw_dec, mem_mux_sel_dec, RW_dec, op_dec, ins, clk, reset);

//Declaring inputs
input[19:0] ins;
input clk, reset;


//Declaring outputs
output[1:0] mux_sel_A, mux_sel_B;
output reg imm_sel, mem_en_dec, mem_rw_dec;
output mem_mux_sel_dec;
output reg[7:0] Imm;
output reg[4:0] op_dec;
output[4:0] RW_dec;


//Declaring variables
wire Jump, Con_Jump, Load, Clear_adr, inter_imm, Ld_St, Ld_reg_input, mem_rw_dec_reg_input;
wire[14:0] register_adr;
wire sel_a_input1, sel_a_input2, sel_a_input3, sel_b_input1, sel_b_input2, sel_b_input3;
wire aEqualw2, aEqualw3, aEqualw4, bEqualw2, bEqualw3, bEqualw4;
wire[4:0] reset5bit;

reg[4:0] Ra, Rb, Rw1, Rw2, Rw3, Rw4;
reg [0:0] Load_reg;

//Variable which is 5 bit version of reset
assign reset5bit = {reset, reset, reset, reset, reset};

//Assigning values to variables
assign Jump = ins[19:15] == 5'b11000 ? 1'b1 : 1'b0;                          //Output of AND gate for detecting Jump instruction
assign Con_Jump = ins[19:17] == 3'b111 ? 1'b1 : 1'b0;                        //Output of AND gate for detecting Jumps
assign Load = (ins[19:15] == 5'b10100)&&(~Load_reg) ? 1'b1 : 1'b0;           //Output of AND gate for detecting Load instruction and previous presence of load
assign Clear_adr = ~(Jump | Con_Jump | Load_reg);                            //Output of NOR gate for checking if any of Jump or load instruction is not present
assign register_adr = Clear_adr ? ins[14:0] : 15'b0;                         //Output of AND gate which decides wether to give register address or not
assign inter_imm = (~ins[19]) & ins[18];                                     //Output of AND to check if to get immidiate number or not
assign Ld_St = ins[19:16] == 4'b1010 ? 1'b1 : 1'b0;                          //Output of AND gate to check for Load and store instruction
assign Ld_reg_input = Ld_St & (~mem_en_dec);                                 //Output of AND gate which is input to D-FF of mem_rw_dec
assign mem_rw_dec_reg_input = ins[0] & (~mem_rw_dec);                        //Output of AND gate which is input to D-FF of mem_en_dec
assign mem_mux_sel_dec = (~mem_rw_dec) & mem_en_dec;                         //Output of AND gate which gives mem_mux_sel_dec


//Assigning values to outputs of registers and flipflops
always@(posedge clk)
begin
		Load_reg <= Load & reset;          						//FF to hold previous value of load
		imm_sel <= inter_imm & reset;            				//FF to give select line of mux to select immidiate value or not 
		Imm[4:0] <= ins[4:0] & reset5bit;						//Register to give Immidiate value
		Imm[7:5] <= 3'b000;
		mem_en_dec <= Ld_reg_input & reset;						//FF to get value of mem_en_dec
		mem_rw_dec <= mem_rw_dec_reg_input & reset;			//FF to get value of mem_rw_dec 
		op_dec <= ins[19:15] & reset5bit;                  //Register to get op_dec
		Rw1 <= register_adr[14:10] & reset5bit;            //Register to store value of destination address register
		Rw2 <= Rw1 & reset5bit;                            //Register to store value of destination address register
		Rw3 <= Rw2 & reset5bit;                            //Register to store value of destination address register
		Rw4 <= Rw3 & reset5bit;                            //Register to store value of destination address register
		Rb <= register_adr[4:0] & reset5bit;               //Register to store value of destination address register
		Ra <= register_adr[9:5] & reset5bit;               //Register to store value of destination address register
end

assign RW_dec = Rw1;                         //Getting value of RW_dec
		

//Outputs of comparator
assign aEqualw2 = Ra == Rw2 ? 1'b1 : 1'b0;
assign aEqualw3 = Ra == Rw3 ? 1'b1 : 1'b0;
assign aEqualw4 = Ra == Rw4 ? 1'b1 : 1'b0;

assign bEqualw2 = Rb == Rw2 ? 1'b1 : 1'b0;
assign bEqualw3 = Rb == Rw3 ? 1'b1 : 1'b0;
assign bEqualw4 = Rb == Rw4 ? 1'b1 : 1'b0;


//Outputs of AND gates which are input lines of priority encoder
assign sel_a_input1 = aEqualw2;
assign sel_a_input2 = (~aEqualw2) & (aEqualw3); 
assign sel_a_input3 = (~aEqualw2) & (~aEqualw3) & (aEqualw4);


assign sel_b_input1 = bEqualw2;
assign sel_b_input2 = (~bEqualw2) & (bEqualw3); 
assign sel_b_input3 = (~bEqualw2) & (~bEqualw3) & (bEqualw4);


//Priority encoders
assign mux_sel_A[0] = sel_a_input3 | ((~sel_a_input2) & sel_a_input1);
assign mux_sel_A[1] = sel_a_input3 | sel_a_input2;

assign mux_sel_B[0] = sel_b_input3 | ((~sel_b_input2) & sel_b_input1);
assign mux_sel_B[1] = sel_b_input3 | sel_b_input2;

endmodule


