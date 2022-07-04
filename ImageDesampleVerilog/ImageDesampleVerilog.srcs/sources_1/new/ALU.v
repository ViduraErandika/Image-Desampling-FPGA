module ALU(
	input wire clk,
	input wire [17:0] A,
	input wire [17:0] B,
	input wire [3:0] operation,
	output wire z,
	output wire [17:0] C
	);
	
	localparam    none     = 4'b0000,
	              ADD      = 4'b0001,
			      SUB      = 4'b0010,
				  PASSBTOC = 4'b0011,
				  DECAC    = 4'b0100,
				  LSHIFT1  = 4'b0101,
				  LSHIFT2  = 4'b0110,
				  LSHIFT8  = 4'b0111,
				  RSHIFT1  = 4'b1000,
				  RSHIFT4  = 4'b1001,
				  RESET    = 4'b1011;

	reg [17:0] data;
	reg Z;
	assign z = Z;
	assign C=data;
	
		
	always @(B) begin
		case(operation)
			ADD: data = A+B;
			SUB: begin
			     data = (A>B)? (A - B): (B - A);
			     Z = (data == 0)? 1'b1:1'b0;
			     end
			PASSBTOC: data = B;
			DECAC: data = A-1; 
			LSHIFT1: data = A<<1;
			LSHIFT2: data = A<<2;
			LSHIFT8: data = A<<8;
			RSHIFT1: data = A>>1;
			RSHIFT4: data = A>>4;
			RESET:   data = 18'd0;
			none: data=data;
		endcase
	end
endmodule	
	
	