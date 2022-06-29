module Decoder(
	input wire [3:0] select,
	output wire r1,r2,r3,r4,r5,ac,pc,ir,ar
	);
	
	localparam R1 = 4'd1,
				  R2 = 4'd2,
				  R3 = 4'd3,
				  R4 = 4'd4,
				  R5 = 4'd5,
				  AR = 4'd6,
				  AC = 4'd7,
				  IR = 4'd8,
				  PC = 4'd9;
				  
				  
				  
	assign r1 = (select == R1)? 1'b1 : 0;
	assign r2 = (select == R2)? 1'b1 : 0;
	assign r3 = (select == R3)? 1'b1 : 0;
	assign r4 = (select == R4)? 1'b1 : 0;
	assign r5 = (select == R5)? 1'b1 : 0;
	assign ac = (select == AC)? 1'b1 : 0;
	assign pc = (select == PC)? 1'b1 : 0;
	assign ir = (select == IR)? 1'b1 : 0;
	assign ar = (select == AR)? 1'b1 : 0;
	
endmodule
	
	