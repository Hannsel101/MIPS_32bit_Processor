module Cache(
	input clk, reset,
	input readRequest,writeRequest,//CPU request an operation
	input [2:0] tag,//used to create a unique identifier along with index for a location in memory
	input [1:0] index,//index to search for memory in cache
	input offset,//Last bit of memory address to load
	input [63:0] dataFromMain,//Block being fetched from main memory
	input [31:0] dataFromProg,//Data being updated by the program
	input doneLoading,//Main memory indicates it is done loading
	output reg load,//Asserts a load from main memory
	output reg [3:0] loadIndex,//Index to load from in main memory
	output reg[32:0] dataOut,//Data being read from cache
	output reg hit, stall);//Status flags to either stall the cpu or indicate a hit has occurred
	
	localparam IDLE = 0;
	localparam SEARCH_CACHE = 1;
	localparam READ_BLOCK_FROM_MEM = 2;
	localparam WRITE_TO_CACHE = 3;
	localparam READ_FROM_CACHE = 4;
	localparam UPDATE_MAIN_MEMORY = 5;
	
	reg validTable [0:3]; //Table holding the valid bit for each index
	reg [2:0] tagTable [0:3]; //table holding the tags for each index 
	reg [63:0] cacheMemory [0:3]; //The data stored in the cache. two words per block
	reg [2:0] cacheState;//Keeps track of what cache is currently doing
	
	
	always @(posedge clk or reset or doneLoading)
	begin
		if(reset)//Load the initial instructions from memory to fill the first index
			begin
				validTable [0] <= 1;//Load initial instructions from main memory
				validTable [1] <= 0;//**
				validTable [2] <= 0;//Clear other valid bits
				validTable [3] <= 0;//**
				loadIndex <= 4'b0;//Load first index from main memory
				dataOut <= 0;//Output no data
				cacheState <= IDLE;//Initialize the cacheState to idle
				hit <= 0;
				
				load = 1;//Initiate a load from main memory
				stall = 1;//Stall CPU until load is complete
				
				if(doneLoading)
				begin
					cacheMemory[index] = {dataFromMain[31:0], dataFromMain[63:32]};
					tagTable[index] = tag;//The 4th, 3rd, and 2nd bits of the location in main memory are used as the tag
					stall = 0;
					load = 0;
				end
			end
		else
			begin
				case(cacheState)
					IDLE: //waiting for instructions
					begin
						stall <= 0;
						if(readRequest)
						begin
							cacheState <= SEARCH_CACHE;
						end
						else if(writeRequest)
						begin
							cacheState <= WRITE_TO_CACHE;
						end
					end
					SEARCH_CACHE: //Searching cache tables for requested data
					begin
						if(tag == tagTable[index])//Compare tags
						begin
							if(validTable[index])//Check Valid bit
							begin
								cacheState <= READ_FROM_CACHE;
							end
						end
					end
					READ_BLOCK_FROM_MEM: //Read a block from main memory
					begin
					
					end
					WRITE_TO_CACHE: //Update cache tables and data
					begin
					
					end
					READ_FROM_CACHE: //Send out data from cache
					begin
						//Select which word to send inside the specified block
						dataOut <= offset ? cacheMemory[index][63:32] : cacheMemory[index][31:0];
						hit <= 1;
					end
					UPDATE_MAIN_MEMORY: //Keep main memory consistent with changes in cache while cpu continues execution
					begin
					
					end
					default:
					begin
					hit <= 0;
					stall <= 0;
					cacheState <= IDLE;
					end
				endcase
			end
		
	end
	
endmodule
	
