module Decoder(
	input wire [7:0] select,
	output wire r1,r2,r3,r4,l,e,mdr,mar
	);
	
	localparam    MAR     = 8'b10000000,
                  MDR     = 8'b01000000,
                  L      = 8'b00100000,
                  R1       = 8'b00010000,
                  R2      = 8'b00001000,
                  R3      = 8'b00000100,
                  R4      = 8'b00000010,
                  E      = 8'b00000001,
                  none_D = 8'b00000000;
				  
				  
				  
	assign r1 = (select == R1)? 1'b1 : 0;
	assign r2 = (select == R2)? 1'b1 : 0;
	assign r3 = (select == R3)? 1'b1 : 0;
	assign r4 = (select == R4)? 1'b1 : 0;
	assign l = (select == L)? 1'b1 : 0;
	assign e = (select == E)? 1'b1 : 0;
	assign mdr = (select == MDR)? 1'b1 : 0;
	assign mar = (select == MAR)? 1'b1 : 0;
	
endmodule
	
	