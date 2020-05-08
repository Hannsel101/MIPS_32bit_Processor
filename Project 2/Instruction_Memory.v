module Instruction_Memory(
	input [31:0] PC,
	output [31:0] instruction);
	
	
	reg [7:0] memory [0:1023];
	
	initial
		begin
			//Byte addressable memory
			memory[0] = 8'b00100000;//ShiftAmt=0; Function=Add // Add r2, r0, r1
			memory[1] = 8'b00010000;// Rd = 2;
			memory[2] = 8'b00000001;//Rs = 0; Rt = 1
			memory[3] = 8'b00000000;//R-type; //-----MSB Instruction 0-----//
			memory[4] = 8'b00100010;//LSB Instruction 1
			memory[5] = 8'b00010000;
			memory[6] = 8'b01000010; //Sub R1, R1, R1
			memory[7] = 8'b00000000;//R-type sub instruction //-----MSB Instruction 1-----//
			memory[8] = 8'b00010000;//----------------
			memory[9] = 8'b00000000;
			memory[10] = 8'b01000010; // Addi R2, R2, 16
			memory[11] = 8'b00100000;//----------------
			memory[12] = 8'b00000100;//----------------
			memory[13] = 8'b00000000;
			memory[14] = 8'b10100100; //LW R4, 4(R5)
			memory[15] = 8'b10001100;//----------------
			memory[16] = 8'b00000000;//----------------
			memory[17] = 8'b00000000;
			memory[18] = 8'b10100100; //SW R4, 0(R5)
			memory[19] = 8'b10101100;//----------------
			memory[20] = 8'b00100100;//----------------
			memory[21] = 8'b00000000;
			memory[22] = 8'b00000000; //J PC+16
			memory[23] = 8'b00001000;//----------------
			memory[36] = 8'b00001000;//----------------
			memory[37] = 8'b00000000;
			memory[38] = 8'b01000001;//BNE R2, R1, 8
			memory[39] = 8'b00010100;//----------------
		end
	
	//Each instruction is composed of 1-word or 4-bytes of the memory array
	assign instruction = {memory[PC+3], memory[PC+2], memory[PC+1], memory[PC]};
	
endmodule