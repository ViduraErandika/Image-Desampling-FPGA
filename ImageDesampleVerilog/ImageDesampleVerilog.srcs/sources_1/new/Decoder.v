module Decoder(
	input wire [8:0] select,
	output wire r1,r2,r3,r4,l,e,pc,mdr,mar
	);
	
	localparam    MAR     = 9'b100000000,
                  MDR     = 9'b010000000,
                  PC      = 9'b001000000,
                  L       = 9'b000100000,
                  R1      = 9'b000010000,
                  R2      = 9'b000001000,
                  R3      = 9'b000000100,
                  R4      = 9'b000000010,
                  E       = 9'b000000001;
				  
				  
				  
	assign r1 = (select == R1)? 1'b1 : 0;
	assign r2 = (select == R2)? 1'b1 : 0;
	assign r3 = (select == R3)? 1'b1 : 0;
	assign r4 = (select == R4)? 1'b1 : 0;
	assign l = (select == L)? 1'b1 : 0;
	assign e = (select == E)? 1'b1 : 0;
	assign pc = (select == PC)? 1'b1 : 0;
	assign mdr = (select == MDR)? 1'b1 : 0;
	assign mar = (select == MAR)? 1'b1 : 0;
	
endmodule
	
	