`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Group : A11
//Members : Heet Gorakhiya, Kartavya Bhatt, Sahil Panchal
//Code : For Jump Control Block
//Description : To check of all types of jumps and to give jump location
//////////////////////////////////////////////////////////////////////////////////
module JumpControlBlock(pc_mux_sel, jmp_loc, ins, clk, interrupt, current_address, flag_ex, reset);

//Declaring inputs
input[19:0] ins;
input clk, interrupt, reset;
input[7:0] current_address;
input[3:0] flag_ex;


//Declaring outputs
output pc_mux_sel;
output[7:0] jmp_loc;

//Declaring wires
wire JC, JNC, JZ, JNZ, JMP, RET, interrupt_reg_temp;
wire[7:0] jump_adr, jump_adr_mux, current_adr_mux, current_adr_reg_temp;
wire[1:0] final_flag, flag_in_reg, flag_reg_temp;

//Declaring regs
reg interrupt_reg;
reg[1:0] flag_reg;
reg[7:0] current_adr_reg;



assign JC = ins[19:15] == 5'b11100 ? 1'b1 : 1'b0;         //Output of AND gate named JC
assign JNC = ins[19:15] == 5'b11101 ? 1'b1 : 1'b0;        //Output of AND gate named JNC
assign JZ = ins[19:15] == 5'b11110 ? 1'b1 : 1'b0;         //Output of AND gate named JZ
assign JNZ = ins[19:15] == 5'b11111 ? 1'b1 : 1'b0;        //Output of AND gate named JNZ
assign JMP = ins[19:15] == 5'b11000 ? 1'b1 : 1'b0;        //Output of AND gate named JMP
assign RET = ins[19:15] == 5'b10000 ? 1'b1 : 1'b0;        //Output of AND gate named RET
assign jump_adr = ins[7:0];                         		 //Assigning value of jump address

assign jump_adr_mux = interrupt_reg ? 8'hf0 : jump_adr;                		//Output of mux whose selection line is interrupt_reg
assign current_adr_mux = interrupt ? current_address : current_adr_reg;    //Output of mux whose selection line is interrupt 
assign flag_in_reg = interrupt ? flag_ex[1:0] : flag_reg;                  //Output of mux whose selection line is interrupt
assign final_flag = RET ? flag_reg : flag_ex[1:0];                         //Output of mux whose selection line is RET


//Output of mux whose selection line is RET
assign jmp_loc = RET ? current_adr_reg : jump_adr_mux;

//Output of OR gate whose inputs are combinations of AND of instructions and final flag
assign pc_mux_sel = (JC & final_flag[0]) | (JNC & (~final_flag[0])) | (JZ & final_flag[1]) | (JNZ & (~final_flag[1])) | JMP | interrupt_reg | RET;


//Assigning values to variables which are inputs to sequential circuit and outputs of mux with reset as selection line to avoid combinational logic in sequential block
assign interrupt_reg_temp = reset ? interrupt : 1'b0;
assign current_adr_reg_temp = reset ? current_adr_mux : 8'b0;
assign flag_reg_temp = reset ? flag_in_reg : 4'b0;

//Sequential block
always@(posedge clk)
begin
		interrupt_reg <= interrupt_reg_temp;
		current_adr_reg <= current_adr_reg_temp;
		flag_reg <= flag_reg_temp;
end

endmodule
