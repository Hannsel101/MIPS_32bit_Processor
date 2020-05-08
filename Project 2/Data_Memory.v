module Data_Memory(
	input MemWrite, MemRead,//Control signals for reading and writing
	input clk, //clk for synchronization.
	input [31:0] address, writeData,//Address is the address to either read or write data to
	output reg [31:0] readData);
	
	
	integer i = 8;
	reg [7:0] data_Memory [0:1023];//1Kilo-bytes of total data memory.
	
	initial
		begin
			data_Memory[0] = 8'b00000000;//LSB Addr 0
			data_Memory[1] = 8'b00000000;
			data_Memory[2] = 8'b00000000;
			data_Memory[3] = 8'b00000000;
			data_Memory[4] = 8'b00000100;//LSB Addr 1
			data_Memory[5] = 8'b00000101;
			data_Memory[6] = 8'b00000110;
			data_Memory[7] = 8'b00000111;
			
			for(i = 8; i < 1024; i = i+1)
				begin
					data_Memory[i] = 32'b0;
				end
		end
		
		always @(posedge clk)
			begin
				if(MemWrite)//Writing to memory
					begin
						data_Memory[address] <= writeData[7:0];//LSB
						data_Memory[address + 1] <= writeData[15:8];
						data_Memory[address + 2] <= writeData[23:16];
						data_Memory[address + 3] <= writeData[31:24];//MSB
					end
				else if(MemRead)//Reading to memory
					begin
						readData <= {data_Memory[address + 3], data_Memory[address + 2], data_Memory[address + 1], data_Memory[address]};
					end
			end
		
endmodule
