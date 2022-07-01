module Memory(
	input wire clk,
	input wire fetch,
	input wire [15:0] address,
	output wire [7:0] Dout
	); 
	
	reg [7:0] memory [0:255];
	reg [15:0] d;
	
	assign Dout = d;
	
	initial begin
    $readmemh("instructionhexfile.txt",memory);
    end
	
	always @(posedge clk) begin
		if (fetch) d = memory[address];
	end
	

	
endmodule
	