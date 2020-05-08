function [31:0] sign_Extension;

	input [15:0] dataIn;//Input to be concatenated
	
	
	//Concatenate the input's MSB 16 times to the front of the input and return
	//the result out of the function.
	begin
		sign_Extension = {{16{dataIn[15]}}, dataIn};
	end

endfunction
