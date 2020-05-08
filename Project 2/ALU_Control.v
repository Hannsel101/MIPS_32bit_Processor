module ALU_Control(
	input [5:0] ALUOp, Funct,
	output reg [1:0] Instr_Type,
	output reg [5:0] Instr_Code);
	
	localparam R_Type = 0;
	localparam I_Type = 1;
	localparam J_Type = 2;
	
	initial
	begin
		Instr_Type = 0;
	end
	
	always @(*)
	begin
		casex(ALUOp)
			6'b000000: //R-Type Instructions
				begin
					Instr_Type <= R_Type;
					Instr_Code <= Funct;
				end
			6'b00001x: //J-Type Instructions
				begin
					Instr_Type <= J_Type;
					Instr_Code <= ALUOp;
				end
			6'b0100xx: //Coprocessor Instructions
				begin
					$display("Coprocessor Instructions Have not been added");//Floating point
				end
			default: //I-Type Instructions
				begin
					Instr_Type <= I_Type;
					Instr_Code <= ALUOp;
				end
		endcase
	end
	
endmodule
