module MIPS_Datapath(
	input clk);
	
	//Wires for PC
	wire [31:0] PCcurr;//Address of the Current instruction to decode
	wire [31:0] PCnext;//Address of the Next instruction to decode
	wire PCselect;//Selector for Next_Instruction Mux (handles jump, branch, pc+4)
	
	//Wires for Incrementing PC and IF
	wire [31:0] currentInstruction;//The 32-bit MIPS instruction to decode
	
	//Wires for ID
	wire RegDst, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite;//Control Signals
	wire [5:0] ALUOp;//Operation for control statemachine and ALU_Control
	wire [31:0] readData, readData1, readData2, inData2;//Output bus from register file to ALU/Memory
	wire [31:0] writeData;//Data to write back into the register file
	wire [4:0] writeReg;//Rs, Rt, Rd
	wire [31:0] immediateOffset;//input source to ALU and also used for branching
	
	//Wires for EX
	wire [1:0] Instr_Type;//Signal traveling from ALU_Control --> ALU. Determines instruction type to execute (R,J,I)
	wire [5:0] Instr_Code;//Signals the specific instruction to execute in the ALU. (add, addi, etc...)
	wire Zero;//Signal for branching
	wire [31:0] result;//ALU output from arithmetic operation
	//wire [31:0] shiftedOffset;//immediate offset shifted two to the left for use in branching instructions
	wire [31:0] branchALU_Result; //The result of the branching ALU function
	
	//Function and Task Files
	`include "sign_Extension.v"
	`include "shifter.v"
	`include "branchALU.v"
	
	
	//Program Counter for keeping track of which instructions to execute
	PC Program_Counter (clk, PCnext, PCcurr);
	
	//Select next location of the program counter based on "Zero" & "Branch" signals
	Mux_2to1 #(32) Next_Instruction(PCcurr+4, branchALU_Result, PCselect, PCnext);
	
	//IF: Fetch the instruction required for the next 4 clock cycles
	Instruction_Memory IM(PCcurr, currentInstruction);
	
	//ID: Decode the current instruction
	Control controller(clk, currentInstruction[31:26], RegDst, Branch, MemRead, MemToReg, ALUOp, MemWrite, ALUSrc, RegWrite);
	Mux_2to1 #(5) Write_Register_Selection(currentInstruction[20:16], currentInstruction[15:11], RegDst, writeReg);
	
	Register_File registers(RegWrite, clk, currentInstruction[25:21], currentInstruction[20:16], writeReg, writeData, readData1, readData2);
	
	assign immediateOffset = sign_Extension(currentInstruction[15:0]);//Sign extend the last 16bits of the instruction
	Mux_2to1 #(32) ALU_Input2(readData2, immediateOffset, ALUSrc, inData2);//Mux for selecting the input to ALU's second data input
	
	//EX: Execute the current instruction
	ALU_Control ALU_Controller(ALUOp, currentInstruction[5:0], Instr_Type, Instr_Code);
	ALU Algorithmic_Logic_Unit(Instr_Type, Instr_Code, readData1, inData2, Zero, result);
	
	//assign shiftedOffset = shifter(immediateOffset);//Dont need the shiftedOffset since I made memory addresses byte aligned and not word aligned
	assign branchALU_Result = branchALU(immediateOffset[27:0], PCnext[31:28]);
	
	//MEM: Store results into memory or load from memory.
	Data_Memory Main_Memory(MemWrite, MemRead, clk,	result, readData2, readData);
	Mux_2to1 #(32) Write_Back_Mux(result, readData, MemToReg, writeData);
	
	//Branching
	and Next_Instr_AND(PCselect, Zero, Branch); 
	
endmodule
