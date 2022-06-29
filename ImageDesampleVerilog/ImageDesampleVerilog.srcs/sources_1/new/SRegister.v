module SRegister(
	input wire clk,
	input wire inc,
	input wire [15:0] Din,
	input wire LDsignal,
	input wire reset,
	output wire [15:0] Dout
	);
	reg [15:0] d;
	assign Dout = d;
	
	always @(posedge clk) begin
		if(reset) d=16'b0;
		else if (LDsignal) d=Din;
		else if (inc) d = d+16'd1;
	end
	
endmodule
