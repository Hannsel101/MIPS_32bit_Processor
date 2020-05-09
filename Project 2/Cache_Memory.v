module Cache_Memory(
	input clk,
	input [2:0] index,
	input [1:0] offSet, controlBits,
	input [12:0] writeData,
	input [38:0] mainMemoryIn,
	output reg [12:0] readData);

	integer i = 0;
	reg [12:0] Data [0:7];//8x13 bits of cache storage space

	initial
	begin
		for(i=0; i<8; i=i+1)
		begin
			Data[i] = 0;//Initialize memory
		end		
	end


	always @(negedge clk)
	begin
		case(controlBits)
			2'b00://IDLE
				$display("Cache Memory is Idling");
			2'b01://READ
				begin
					readData <= Data[index];
				end
			2'b10://WRITE
				begin
					Data[index] <= writeData;
				end
			2'b11://PULL_FROM_MAIN_MEMORY
				$display("Pulling a block of data from Main Memory");
			default://Handle High impedance and unknowns
				$display("In Default for Cache Memory\n");
		endcase
	end
	

endmodule
