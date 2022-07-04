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
				  RESET    = 4'b1011,
                  ADD256_ALU = 4'b1100,
                  SUB256_ALU = 4'b1101,	
                  MUL        = 4'b1110;			  

	reg [17:0] data;
	reg Z;
	assign z = Z;
	assign C=data;
	
		
	always @(B,operation) begin
		case(operation)
			ADD: begin data = A+B; Z = 1; end
			SUB: begin
			     if(A>B) begin
			     data =  (A - B); end
			      else begin data =  (B - A);
			      end
			     Z = (data == 0)? 1'b1:1'b0;
			     end
			PASSBTOC: begin data = B; Z = 1; end
			DECAC: begin data = A-1; Z = 1; end
			LSHIFT1:begin data = A<<1; Z = 1; end
			LSHIFT2: begin data = A<<2; Z = 1; end
			LSHIFT8:begin data = A<<8; Z = 1; end
			RSHIFT1: begin data = A>>1; Z = 1; end
			RSHIFT4:begin data = A>>4; Z = 1; end
			RESET: begin  data = 18'd0; Z = 1; end
			ADD256_ALU:begin  data = A + 18'd256; Z = 1; end
			SUB256_ALU:begin  data = A - 18'd256; Z = 1; end
			MUL:begin  data = A * B; Z = 1; end
			none:begin data=data; Z = 1; end
		endcase
	end
endmodule	
	
	