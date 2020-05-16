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
	wire [32:0] dataOut;
	wire hit, stall;
	
	Cache cacheMem(clk, reset, readRequest, writeRequest, tag, index, offset, dataFromMain, dataFromProg,
	      doneLoading, load, loadIndex, dataOut, hit, stall);
	
	
	initial
	begin
	mainMemory [0] <= 32'hAAAAFFFF;
	mainMemory [1] <= 32'hFFFFAAAA;
	mainMemory [2] <= 32'hAAAAFFFF;
	mainMemory [3] <= 32'hFFFFAAAA;
	mainMemory [4] <= 32'hAAAAFFFF;
	mainMemory [5] <= 32'hFFFFAAAA;
	mainMemory [6] <= 32'hAAAAFFFF;
	mainMemory [7] <= 32'hFFFFAAAA;
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
	#40 dataFromMain = {mainMemory[loadIndex+1], mainMemory[loadIndex]};
	doneLoading = 1;
	#10
	reset = 0;
	#80 $finish;
	end
	
	always #1 clk = ~clk;


endmodule
