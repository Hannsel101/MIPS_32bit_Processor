module ALU(
	input [1:0] Instr_Type,
	input [5:0] funct,
	input [31:0] readData1, readData2,
	output reg Zero,
	output reg [31:0] result);
	
	initial
	begin
		Zero = 0;
		//result = 0;
	end

	always @(*)
	begin
		case(Instr_Type)
			2'b00://R-type
				begin
					Zero <= 0; //Zero not needed in R-type
					case(funct)
						6'b100000://Add
							begin
								result <= readData1 + readData2;
							end
						6'b011010://Div 
							begin
								result <= readData1/readData2;
							end
						6'b011000://Mult 
							begin
								result <= readData1 * readData2;
							end
						6'b100010://Sub
							begin
								result <= readData1 - readData2;
							end
						default:
							$display("No function to handle current input");
							
					endcase
				end
			2'b01://I-type
				begin
					Zero <= 0;
					casex(funct)
						6'b001000://Addi 
							begin
								result <= readData1 + readData2;
							end
						6'b001100://Andi
							begin
								result <= readData1 & readData2;
							end
						6'b000100://BEQ
							begin
								Zero <= (readData1 == readData2);
							end
						6'b000101://BNE
							begin
								Zero <= (readData1 != readData2);
							end
						6'b10x011://LW and SW
							begin
								result <= readData1 + readData2;
							end
						default:
								$display("No function to handle current input");
					endcase
				end
			2'b10://J-type
				begin
					case(funct)
						6'b000010://Jump
							begin
								Zero <= 1;
							end
						default:
								$display("No function to handle current input");
					endcase
				end
			default:
				$display("Error: Invalid Instruction Type");
		endcase
	end

endmodule