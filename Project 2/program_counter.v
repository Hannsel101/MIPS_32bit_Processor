module PC(
	input clk,//Used to count clock cycles before starting next instruction
	input [31:0] PCin,//Next instruction
	output reg [31:0] PCout);//Current instruction to execute
	
	reg [2:0] clockCycles;
	
	initial
	begin
		clockCycles = 0;
		PCout = 0;
	end
	
	always @(posedge clk)
	begin
		case(clockCycles)
			3'b000: clockCycles <= clockCycles + 1;
			3'b001: clockCycles <= clockCycles + 1;
			3'b010: clockCycles <= clockCycles + 1;
			3'b011: clockCycles <= clockCycles + 1;
			3'b100: clockCycles <= clockCycles + 1;
			default:
				begin
					clockCycles <= 0;
					PCout <= PCin;
				end
		endcase
	end
		  
endmodule