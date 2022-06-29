module Register(
	input wire clk,
	input wire LDsignal,
	input wire [15:0] Din,
	output wire [15:0] Dout
	);
	
	reg [15:0] d;
	assign Dout = d;
	
	always @(posedge clk) begin
		if (LDsignal) d<=Din;
	end
endmodule 