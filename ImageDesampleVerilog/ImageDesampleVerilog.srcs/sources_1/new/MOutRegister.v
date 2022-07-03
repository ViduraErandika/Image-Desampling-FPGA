module MOutRegister(
    input wire [17:0] Din,
	output wire [17:0] Dout
	);
	
	reg [17:0] d;
	assign Dout = d;
	
	always @(Din) begin
		d<=Din;
	end
endmodule 
