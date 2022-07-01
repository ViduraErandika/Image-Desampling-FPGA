 //`timescale 1ns/100ps 

module TopModule(
	input wire clk,
	input wire start,
	output wire end1,
	output wire [7:0] s
	);
	
	wire readp,writep,endp;
	wire read,write;
	wire [15:0] pram,dram,acout,arout,pcout;
	wire [15:0] address;
	reg startp = 0;
	reg startt = 0;
	wire [15:0] din;
	
	wire s_tick;
	wire [15:0] addr;
	reg readu = 0;
	reg writeu = 1;
	
	reg [16:0] count  = 0;
	reg [16:0] countn = 0;
	reg [1:0] state   = 2'b00;
	reg [1:0] staten  = 2'b00;
	
	localparam nope  = 2'b11,
	           pros  = 2'b01;
	
	assign address = arout;
    assign read    = readp;
    assign write   = writep;
    assign din     = acout;
	
	DMemory Dram(.clk(clk), .read(read), .write(write), .Din(din), .Dout(dram), .address(address));
	Memory Iram(.clk(clk), .read(read), .write(0), .Din(0), .Dout(pram), .address(pcout));
	
	processor Pro(.pram(pram), .dram(dram), .start(startp), .clk(clk), .read(readp), .write(writep),
					.acout(acout), .arout(arout), .pcout(pcout), .endp(endp));
	
	
	
	assign addr = count;
	
	//assign s=acout;
	assign end1=endp;
	
always @(posedge clk) begin
	//s = acout;
	state = staten;
	count = countn;
	case (state) 
		pros : begin
			if(endp) begin
				writeu = 0;
				readu  = 1;
				startp = 0;
				startt = 1;
				countn = 0;
				count  = 0;
			end
		end
		
		nope : staten = nope;
	endcase

end

					
endmodule	