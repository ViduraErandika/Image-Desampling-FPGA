module ALU(
	input wire clk,
	input wire [15:0] A,
	input wire [15:0] B,
	input wire [2:0] operation,
	output reg z,
	output wire [15:0] C
	);
	
	localparam pass   = 3'd1,
			     add    = 3'd2,
				  sub    = 3'd3,
				  lshift = 3'd4,
				  rshift = 3'd5,
				  orOp 	= 3'd6;
	
	reg d;
	reg counter;
	reg [15:0] data;
	assign C=data;
	
//	initial begin
//		counter =0;
//	end
	
	always @(posedge clk) begin
		z = (B==0)? 1'b1:1'b0;
	end
		
	always @(A or B or operation) begin
		case(operation)
			pass: data = A; 
			add: data = A+B;
			sub: begin
				data = B-A;
//				d=~|data;
//				if (~|data) begin
//					if (~counter) z=~|data;
//					counter = counter+1;
//				end
				
				end
			lshift: data = B<<1;
			rshift: data = (B[1]==1)? ((B>>2)+1):B>>2;
			orOp : data = A|B;
			default: data=data;
		endcase
	end
endmodule	
	
	