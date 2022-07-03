module SRegister(
	input wire clk,
	input wire inc,
	input wire [17:0] Din,
	input wire LDsignal,
	input wire reset,
	output wire [17:0] Dout
	);
	reg [17:0] d;
	assign Dout = d;
	
	always @(posedge clk) begin
		if(reset) d=18'b0;
		else if (LDsignal) d=Din;
		else if (inc) d = d+18'd1;
	end
	
endmodule
