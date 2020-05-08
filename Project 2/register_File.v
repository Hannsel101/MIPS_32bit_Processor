module Register_File(
	input regWrite,//Control Signal to write into a register
	input clk, //Synchronizes read and writes to avoid conflicts
	input [4:0] readReg1, readReg2, writeReg,//Input register rs, rt, rd
	input [31:0] writeData,//writeback into a registers memory space 
	output reg [31:0] readData1, readData2);//output registers rs and rt
	
	integer i = 0;
	reg [31:0] register [0:31];
	
	initial
	begin
		register[0] = 3;
		register[1] = 2;
		register[2] = 1;
		for(i = 3; i < 32; i = i+1)
		begin
			register[i] = 32'b0;
		end
	end
		
	always @(posedge clk)
	begin
		if(regWrite)
			begin
				register[writeReg] <= writeData;//Store a value into the register	
			end
		else
			begin
				readData1 <= register[readReg1];
				readData2 <= register[readReg2];
			end
	end
endmodule
