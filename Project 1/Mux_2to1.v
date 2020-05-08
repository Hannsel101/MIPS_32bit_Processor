module Mux_2to1 

	//Parameter to change the width of the input and output values
	//This allows for modularity when instantiating multiple Muxes in a top level design
	#(parameter WIDTH = 5)

	(input [WIDTH-1:0] in0, in1,
	 input select,
	 output [WIDTH-1:0] muxOut);
	
	assign muxOut = select ? in1: in0;
	
endmodule
