module cacheTB();

	//Cache Controller signals
	reg clk, reset;
	reg readRequest, writeRequest;
	reg [2:0] tag;
	reg [1:0] index;
	reg offset;
	reg [63:0] dataFromMain;
	reg [31:0] dataFromProg;
	reg doneLoading;
	
	reg [31:0] mainMemory [0:7];//main memory simulation
	
	wire load;
	wire [3:0] loadIndex;
	wire [31:0] dataOut;
	wire hit, stall;
	wire [63:0] updateMain
	
	Cache cacheMem(clk, reset, readRequest, writeRequest, tag, index, offset, dataFromMain, dataFromProg,
	      doneLoading, load, loadIndex, dataOut, hit, stall, updateMain);
	
	
	initial
	begin
	mainMemory [0] <= 32'hAAAAFFFF;
	mainMemory [1] <= 32'hFFFFAAAA;
	mainMemory [2] <= 32'hAFAFAFAF;
	mainMemory [3] <= 32'hFAFAFAFA;
	mainMemory [4] <= 32'hFFAAAAFF;
	mainMemory [5] <= 32'hAAFFFFAA;
	mainMemory [6] <= 32'hFFFAAAFA;
	mainMemory [7] <= 32'hAAAFFFAF;
	end
	
	initial
	begin
	#2
	reset = 1;
	clk = 0;
	readRequest = 0;
	writeRequest = 0;
	tag = 0;
	index = 0;
	offset = 0;
	dataFromProg = 0;
	doneLoading = 0;
	dataFromMain = 0;
	#10
	reset = 0;
	readRequest = 1;
	offset = 1;
	#80
	index = 1;
	doneLoading = 0;
	readRequest = 0;
	tag = 1;
	readRequest = 1;
	#40
	doneLoading = 0;
	#80 $finish;
	end
	
	always #1 clk = ~clk;

	always @(load or reset) 
		begin
		if(reset | load)
		begin
			#40 dataFromMain = {mainMemory[loadIndex+1], mainMemory[loadIndex]};
			doneLoading = 1;
		end
		end

endmodule
