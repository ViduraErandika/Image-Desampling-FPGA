module Register(
	input wire clk,
	input wire LDsignal,
	input wire [17:0] Din,
	output wire [17:0] Dout
	);
	
	reg [17:0] d;
	assign Dout = d;
	
	always @(negedge clk) begin
		if (LDsignal) d<=Din;
	end
endmodule 