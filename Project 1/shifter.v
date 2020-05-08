function [31:0] shifter;

	input [31:0] immediateOffset;
	
	begin
		shifter = immediateOffset << 2;
	end

endfunction
