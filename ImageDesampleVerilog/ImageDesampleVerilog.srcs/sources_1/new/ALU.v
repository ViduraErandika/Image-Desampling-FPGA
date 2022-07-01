module ALU(
	input wire clk,
	input wire [15:0] A,
	input wire [15:0] B,
	input wire [2:0] operation,
	output reg z,
	output wire [15:0] C
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
				  RSHIFT4  = 4'b1001;
			
				  
				  
	
	reg d;
	reg counter;
	reg [15:0] data;
	assign C=data;
	
		
	always @(A or B or operation) begin
		case(operation)
			ADD: data = A+B;
			SUB: begin
			     data = (A>B)? (A - B): (B - A);
			     z = (data == 0)? 1'b1:1'b0;
			     end
			PASSBTOC: data = B;
			DECAC: data = A-1; 
			LSHIFT1: data = A<<1;
			LSHIFT2: data = A<<2;
			LSHIFT8: data = A<<8;
			RSHIFT1: data = A>>1;
			RSHIFT4: data = A>>4;
			none: data=data;
		endcase
	end
endmodule	
	
	