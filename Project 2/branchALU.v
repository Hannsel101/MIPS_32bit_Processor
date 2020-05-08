function [31:0] branchALU;
	
	input [27:0] shiftedOffset; 
	input [3:0] PC;
	begin
		branchALU = {PC, shiftedOffset};//Concatenate the 4 MSB bits of PC with the 28 LSB bits of offset
	end

endfunction
