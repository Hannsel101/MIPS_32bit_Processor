module MIPS_TB();

	reg clk;//System clock for synchronization
	//reg [31:0] PC, address, writeData;
	//wire [31:0] testAddress, readData, readData1, readData2, PCout;
	//reg [4:0] testRegister1, testRegister2, writeRegister;
	//reg muxSelect;
	//wire [4:0] regOut;
	
	//Control signals for testing Data_Memory
	//reg MemWrite, MemRead;
	
	//Control signals for testing Register_File
	//reg regWrite;
	
	//`include "sign_Extension.v"
	
	//Mux_2to1 #(5) writeRegisterMux (testRegister1, testRegister2, muxSelect, regOut);
	//Instruction_Memory IM(PC, testAddress);
	//Data_Memory RAM(MemWrite, MemRead, clk, address, writeData, readData);
	//Register_File registers(regWrite, clk, testRegister1, testRegister2, writeRegister, writeData, readData1, readData2);
	//PC programCounter(clk, PC, PCout);
	
	MIPS_Datapath Processor(clk);
	
	initial
		begin
		//PC = 0;
		clk = 0;
		
		//-------------------------------------------------------------//
		//-------------------------------------------------------------//
		//-------------------------------------------------------------//
		//Block of code used to test Mux_2to1.
		/*
		testRegister1 = 3;
		testRegister2 = 0;
		muxSelect = 0;
		clk = 0;
		#5 muxSelect = 1;
		*/
		//-------------------------------------------------------------//
		//-------------------------------------------------------------//
		//-------------------------------------------------------------//
		//Block of code used to test 16 to 32 bit sign extender function
		/*
		testAddress = sign_Extension(16'hFFFF);
		#5 testAddress = sign_Extension(16'h010);
		*/
		//-------------------------------------------------------------//
		//-------------------------------------------------------------//
		//-------------------------------------------------------------//
		//Bloc of code used to test Instruction Memory
		/*
		PC = 0;
		#5 PC = PC + 4;
		#5 PC = PC + 4;
		*/
		//-------------------------------------------------------------//
		//-------------------------------------------------------------//
		//-------------------------------------------------------------//
		//Block of code to test Data_Memory
		/*
		MemRead = 0;
		MemWrite = 0;
		address = 0;
		writeData = 32'hFFFFFFFF;
		#6 
		MemRead = 1;
		#6 
		MemRead = 0;
		MemWrite = 1;
		#6
		MemWrite = 0;
		MemRead = 1;
		*/
		//-------------------------------------------------------------//
		//-------------------------------------------------------------//
		//-------------------------------------------------------------//
		//Block of code to test Register_File for writing and reading
		/*
		testRegister1 = 0;
		testRegister2 = 1;
		writeRegister = 2;
		writeData = 32'hF0F1F3F7;
		regWrite = 0;
		#6
		regWrite = 1;
		#6
		regWrite = 0;
		testRegister1 = 2;
		*/
		//-------------------------------------------------------------//
		//-------------------------------------------------------------//
		//-------------------------------------------------------------//
		//Block of code to test program_Counter for updating on the 6th clock cycle
		/*
		PC = PC + 4;
		#30
		PC = PC + 8;
		*/
		
		
		#160 $finish;
		
		end
		
	
	

	
	always
		#2 clk = !clk;

endmodule
