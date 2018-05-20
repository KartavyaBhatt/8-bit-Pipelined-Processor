`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Group : A11
//Members : Heet Gorakhiya, Kartavya Bhatt, Sahil Panchal
//Code : For Program Counter and Instruction memory block
//Description : To generate instruction and current address of instruction
//////////////////////////////////////////////////////////////////////////////////
module PCandIM(ins, ins_pm, current_address, jmp_loc, pc_mux_sel, stall, stall_pm, reset, clk);

//Declaring inputs
input[7:0] jmp_loc;
input pc_mux_sel, stall, stall_pm, reset, clk;

//Declaring outputs
output[19:0] ins, ins_pm;
output[7:0] current_address;

//Declaring wires and regs for the circuit
wire[7:0] current_address_temp, new_current_address, increment_address, address_hold_reg, next_address_reg;
reg[7:0] next_address, address_hold;
wire[19:0] ins_reg, ins_pm_temp;
reg[19:0] ins_temp;
reg reset_FF;

//Assigning values to outputs of mux
assign current_address_temp = stall ? address_hold : next_address;							//To choose between current and next address
assign new_current_address = (pc_mux_sel==1'b1) ? jmp_loc : current_address_temp;		//To choose between current and jump address
assign current_address = reset_FF ? new_current_address : 8'b0;									//To take care of initial build-up

//Incrementer
assign increment_address = current_address + 8'b00000001;

//Assigning values to variables which are inputs to sequential circuit and outputs of mux with reset as selection line to avoid combinational logic in sequential block
assign ins_reg = reset ? ins : 20'b0;
assign address_hold_reg = reset ? current_address : 8'b0;
assign next_address_reg = reset ? increment_address : 8'b0;

//Creating register with posedge clock and clock synchronous negative level reset
always@(posedge clk)
begin
		address_hold <= address_hold_reg;
		next_address <= next_address_reg;
		ins_temp <= ins_reg;
		reset_FF <= reset;
end


//Calling instance of IP core
ProgramMemory progMem (
  .clka(clk), // input clka
  .ena(1'b1), // input ena
  .addra(current_address), // input [7 : 0] addra
  .douta(ins_pm_temp) // output [19 : 0] douta
);


//Assigning value of instruction and ins_pm
assign ins = stall_pm ? ins_temp : ins_pm_temp;
assign ins_pm = reset_FF ? ins : 20'b0;


endmodule
