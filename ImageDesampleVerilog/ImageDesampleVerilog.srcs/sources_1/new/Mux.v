module Mux(
	input wire [3:0] select,
	input wire [17:0] r1,r2,r3,r4,l,e,mbru,pc,mdr,
	output wire [17:0] out
	);
	
	localparam    R1   = 4'b0110,
				  R2   = 4'b0111,
				  R3   = 4'b1000,
				  R4   = 4'b1001,
				  L    = 4'b0101,
				  E    = 4'b0100,
				  MBRU = 4'b0011,
				  PC   = 4'b0010,
				  MDR  = 4'b0001,
				  none_M= 4'b0000;
				  
				  
	reg [17:0] data;
	assign out = data;
	
	always @(select or r1 or r2 or r3 or r4 or l or e or mbru or pc or mdr)begin
		case(select)
			R1 : data = r1;
			R2 : data = r2;
			R3 : data = r3;
			R4 : data = r4;
			L : data = l;
			E : data = e;
			MBRU : data = mbru;
			PC : data = pc;
			MDR : data = mdr;
			none_M : data = 4'b0000;
			default : data = 4'b0000;
		endcase
		end
				  
endmodule		
	