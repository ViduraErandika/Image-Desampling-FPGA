module DMemory(
	input wire clk,
	input wire write,
	input wire read,
	input wire [17:0] Din,
	input wire [17:0] address,
	output wire [17:0] Dout
	); 
	
	reg [7:0] memory [0:82950]; //128*128 + 66566
	reg [17:0] d;
	assign Dout = d;
	
	reg [17:0] ADDRESS;
	
	initial
	begin
	$readmemh("imageArrayhexfile.txt",memory);
	end
	
	always @(address)begin
        ADDRESS <= address;	
	end
	
	always @(posedge clk) begin
		if (read) d = {10'd0,memory[ADDRESS]};
		else if (write) memory[ADDRESS] = Din[7:0];
	end
	
	
endmodule
	