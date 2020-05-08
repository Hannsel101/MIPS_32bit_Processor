module Control(
	input clk, //Synchronizes the state machine with the rest of the system
	input [5:0] opCode, //Operation bits of an instructio
	output reg RegDst, //Select for destination register selection in register file
	output reg Branch, //Control for initiating branch operation (input to an AND gate)
	output reg MemRead, // Read from memory?????
	output reg MemToReg, //Selector for writing from memory into a register or directly writing from register to register
	output reg [5:0] ALUOp, //Control signal for ALU controller.
	output reg MemWrite, //Control signal for writing ALU result directly into memory(store command)
	output reg ALUSrc, //Selector between Register2 and Immediate as second input into ALU. 
	output reg RegWrite); //Enable bit for writing back the ALU result into the destination register.
	
	reg [2:0] state; //Stores current state of state machine
	
	
	initial
	begin
		state = 0;
		RegDst = 0;
		Branch = 0;
		MemRead = 0;
		MemToReg = 0;
		ALUOp = 0;
		MemWrite = 0;
		ALUSrc = 0;
		RegWrite = 0;
	end
	
	always@(opCode)
	begin
		
	end
	
	always @(posedge clk)
	begin	
		casex(opCode)
			6'b000000://R-Type Instruction
				begin
					case(state)
						3'b000://Instruction Fetch
							begin
								state <= state + 1;//wait for fetch to finish
							end
						3'b001://Decode
							begin
								RegDst <= 1;//Select Rd as write register
								state <= state + 1;
							end
						3'b010://Execute
							begin
								Branch <= 0;
								ALUOp <= 6'b000000;//R-type instruction sent to ALU Controller
								ALUSrc <= 1'b0;//Choose read data2 as ALU source register2
								state <= state + 1;
							end
						3'b011://Memory
							begin
								state <= state + 1;
								MemToReg <= 0;//Skip Data Memory
							end
						3'b100://Write Back
							begin
								RegWrite <= 1;//Write back into destination register
								state <= state + 1;
							end
						default:
							begin
								state <= 0;
								RegWrite <= 0;
								$display("Hey im in default for R-Type");
							end
					endcase
				end
			6'b00001x: //J-Type Instruction
				begin
					case(state)
						3'b000://Fetch
							begin
								state <= state + 1;
							end
						3'b001://Decode
							begin
								state <= state + 1;
							end
						3'b010://Execute
							begin
								ALUOp <= opCode;
								state <= state + 1;
							end
						3'b011://Memory
							begin
								MemRead <= 0;
								MemWrite <= 0;
								RegWrite <= 0;
								Branch <= 1;//Signal to send branching branching instruction instead of PC+4
								state <= state + 1;
							end
						3'b100://Write Back
							begin
								RegWrite <= 0;
								state <= state + 1;
							end
						default
							begin
								state <= 0;
							end
					endcase
				end
			6'b0100xx: //Coprocessor instructions
				begin
					$display("No Coprocessor Instructions Currently Exist!");
				end
			default: //I-Type Instructions
				begin
					case(state)
						3'b000: //Fetch
							begin
								state <= state + 1;
							end
						3'b001: //Decode
							begin
								RegDst <= 0;
								state <= state + 1;
							end
						3'b010: //Execute
							begin
								Branch <= 1;
								ALUSrc <= 1;
								ALUOp <= opCode;
								state <= state + 1;
							end
						3'b011: //Memory
							begin
								if(ALUOp == 6'b101011)//if instruction is SW
									begin
										MemWrite <= 1;
									end
								else if(ALUOp == 6'b100011)//If instruction is LW
									begin
										MemRead <= 1;
									end
								else
									begin
										MemWrite <= 0;
									end
						
								state <= state + 1;
							end
						3'b100: //Write Back
							begin			
								if((ALUOp == 6'b001000) || (ALUOp == 6'b001100))//Addi, ANDi
									begin
										RegWrite <= 1;
										MemToReg <= 0;
									end
								else if(ALUOp == 6'b100011)//LW
									begin
										RegWrite <= 1;
										MemToReg <= 1;
									end
								else
									begin
										RegWrite <= 0;
									end
								state <= state + 1;
							end
						default:
							begin
								state <= 0;
								RegWrite <= 0;
								MemRead <= 0;
								MemWrite <= 0;
							end
					endcase
				end
		endcase
	end
	
endmodule