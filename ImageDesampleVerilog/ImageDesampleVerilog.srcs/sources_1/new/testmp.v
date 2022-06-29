 //`timescale 1ns/100ps 

module testmp(
	input wire clk,
	input wire start,
	output wire end1,
	output wire [7:0] s,
	input wire rx,
	output wire tx
	);
	
	wire readp,writep,endp;
	wire [15:0] pram,dram,acout,arout,pcout;
	wire [15:0] address;
	reg startp = 0;
	reg startt = 0;
	wire [15:0] din;
	
	wire s_tick;
	wire tx_done_tick;
	wire rx_done_tick;
	wire [7:0] rxd;
	wire [15:0] addr;
	reg readu = 0;
	reg writeu = 1;
	
	reg [16:0] count  = 0;
	reg [16:0] countn = 0;
	reg [1:0] state   = 2'b00;
	reg [1:0] staten  = 2'b00;
	
	localparam recv  = 2'b00,
				  pros  = 2'b01,
				  trans = 2'b10,
				  nope  = 2'b11;
	
	
	DMemory Dram(.clk(clk), .read(read), .write(write), .Din(din), .Dout(dram), .address(address));
	Memory Pram(.clk(clk), .read(read), .write(0), .Din(0), .Dout(pram), .address(pcout));
	
	processor pro(.pram(pram), .dram(dram), .start(startp), .clk(clk), .read(readp), .write(writep),
					.acout(acout), .arout(arout), .pcout(pcout), .endp(endp));
	
	
	assign address = (staten==pros)? arout:addr;
	assign read    = (staten==pros)? readp:readu;
	assign write   = (staten==pros)? writep:writeu;
	assign din     = (staten==pros)? acout:rxd;
	
	assign addr = count;
	
	//assign s=acout;
	assign end1=endp;
	
always @(posedge clk) begin
	//s = acout;
	state = staten;
	count = countn;
	case (state) 
		recv : begin
			if(rx_done_tick) begin
				countn = countn+1;
				if(count==65535) begin
					staten = pros;
					startp = 1;
				end
			end
		end
		
		pros : begin
			if(endp) begin
				staten = trans;
				writeu = 0;
				readu  = 1;
				startp = 0;
				startt = 1;
				countn = 0;
				count  = 0;
			end
		end
		
		trans : begin
			if(~(tx_done_tick)) begin
				countn = countn+1;
				if(countn == 16384) begin
					startt = 0;
					staten = nope;
				end
			end
		end
		
		nope : staten = nope;
	endcase

end

					
endmodule	