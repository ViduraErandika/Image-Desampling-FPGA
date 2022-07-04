`timescale 1ns / 100ps
module TopModule(
	input wire clk,
	input wire start
	);
	 wire [17:0] iram,dram;    //data from iram and dram
     wire read,write;
     wire [17:0] pcout; // address to the Iram.
     wire [17:0] marOut;    //address to the Dram
     wire [17:0] mdrOut;   //data input to the Dram
     wire fetch;
     
     wire start_sig;
     assign start_sig = start;

	
	DMemory Dram(.clk(clk), .read(read), .write(write), .Din(mdrOut), .Dout(dram), .address(marOut));
	Memory Iram(.clk(clk), .fetch(fetch), .Dout(iram), .address(pcout));
	
	processor Pro(.iram(iram), .dram(dram), .start(start_sig), .clk(clk), .read(read), .write(write),
					.pcout(pcout), .marOut(marOut), .mdrOut(mdrOut), .fetch(fetch));
	
	

					
endmodule	