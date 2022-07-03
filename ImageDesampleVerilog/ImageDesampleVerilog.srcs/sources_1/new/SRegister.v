module SRegister(
	input wire clk,
	input wire inc,
	input wire [17:0] Din,
	output wire [17:0] Dout
	);
	reg [17:0] d;
	assign Dout = d;
	
	always @(posedge clk) begin
        if (inc) d = d+18'd1;
	end
	always @(Din) begin
        d=Din;
    end
	
	
endmodule
