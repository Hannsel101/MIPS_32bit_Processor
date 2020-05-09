module Cache_Controller(
	input clk,
	input [7:0] tag,
	input [2:0] index,
	input readFlag, writeFlag,
	output reg stall, hit);

	localparam VALID = 1;
	localparam INVALID = 0;
	
	reg [2:0] state;//Current state of the control machine
	reg [8:0] cache_Table [0:7];//Table for searching the data.

	integer i = 0;
	initial
	begin
		state = 0;
		for(i=0; i<8; i=i+1)
		begin
			cache_Table[i] = INVALID;
		end
	end


	always @(negedge clk)
	begin
		case(state)
			3'b000://Wait for read or write request
			begin
				if(readFlag || writeFlag)
				begin
					state = state+1;
				end
			end
			3'b001://Check Table
			begin
				if((cache_Table[index][7:0] == tag)
				    &&(cache_Table[index][8]))//Check that the tag fields match
				begin
					hit <= 1;
				end
				else
				begin
					stall <= 1;
				end
			end
			3'b010:
			begin

			end
		endcase

	end

endmodule
