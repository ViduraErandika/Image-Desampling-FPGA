module ControlUnit(
	input wire [15:0] ir,
	input wire z,
	input wire start,
	input wire clk,
	output reg [3:0] D_select,
	output reg [3:0] M_select,
	output reg [2:0] operation,
	output reg read,
	output reg write,
	output reg endp,
	output reg incac, incpc,
	output reg resetac,resetpc
	);
	
	reg [7:0] ins;
	reg [21:0] musec [0:23];
	reg [4:0] current_state;
	reg [4:0] next_state,mins;
	reg [3:0] instruction;
	
	localparam  NOPE    = 4'd0,
					CLAC    = 4'd1,
					LDAC    = 4'd2,
					LOADVAL = 4'd3,
					INC     = 4'd4,
					JPNZ    = 4'd5,
					LSHIFT  = 4'd6,
					RSHIFT  = 4'd7,
					STAC    = 4'd8,
					JUMP    = 4'd9,
					MOVE    = 4'd10,
					MOVEAC  = 4'd11,
					ADD     = 4'd12,
					SUB     = 4'd13,
					EOP     = 4'd15,
					OR		= 4'd14;
	
	
	
	initial begin
		musec[0]  = {4'd0,4'd0,3'd0,6'b000101,5'd1};
		musec[1]  = {4'd8,4'd0,3'd0,6'b100000,5'd2};
		musec[2]  = {4'd8,4'd0,3'd0,6'b000010,5'd23};
		musec[3]  = 22'd1;
		musec[4]  = {4'd0,4'd0,3'd0,6'b000100,5'd1};
		musec[5]  = {4'd0,4'd10,3'd1,6'b100000,5'd6};
		musec[6]  = {4'd7,4'd10,3'd1,6'b000000,5'd1};
		musec[7]  = {4'd0,4'd9,3'd1,6'b100000,5'd8};
		musec[8]  = {4'd7,4'd9,3'd1,6'b000010,5'd1};
		musec[9]  = {4'd0,4'd0,3'd0,6'b000010,5'd1};
		musec[10] = {4'd0,4'd9,3'd1,6'b100000,5'd11};
		musec[11] = {4'd9,4'd9,3'd1,6'b000000,5'd1};
		musec[12] = {4'd7,4'd7,3'd4,6'b000000,5'd1};
		musec[13] = {4'd7,4'd7,3'd5,6'b000000,5'd1};
		musec[14] = {4'd7,4'd0,3'd1,6'b000000,5'd1};
		musec[15] = {4'd0,4'd7,3'd1,6'b000000,5'd1};
		musec[16] = {4'd7,4'd0,3'd2,6'b000000,5'd1};
		musec[17] = {4'd7,4'd0,3'd3,6'b000000,5'd1};
		musec[18] = {4'd0,4'd0,3'd0,6'b001000,5'd1};
		musec[19] = {4'd0,4'd9,3'd1,6'b100000,5'd20};
		musec[20] = {4'd9,4'd9,3'd1,6'b000000,5'd1};
		musec[21] = {4'd0,4'd0,3'd0,6'b010000,5'd1};
		musec[22] = {4'd0,4'd0,3'd0,6'b000101,5'd22};
		musec[23] = {4'd0,4'd0,3'd0,6'b000000,5'd0};
		musec[24] = {4'd7,4'd0,3'd6,6'b000000,5'd1};
		next_state = 5'b0;
		endp = 1'd0;
	end
	
//	always @(posedge start) begin 
//		current_state = 5'd0;
//		//endp = 1'b0;
//	end

	always @(ir) ins=ir;
	
	always @(negedge clk) begin
		if(start) begin
			current_state = next_state;
			{D_select,M_select,operation,read,write,incac,resetac,incpc,resetpc,next_state} = musec[current_state];
			if (current_state == 5'd23) next_state = mins;
			else if (current_state == 5'd14 | current_state == 5'd16 | current_state == 5'd17 | current_state == 5'd24) M_select = ins[7:4];
			else if (current_state == 5'd15) D_select = ins[7:4];
			else if (current_state == 5'd22) begin
				endp = 1'b1;
				current_state = 0;
			end
			else next_state = next_state;
		end
	end
			
	always @(ins) begin
			instruction = ins[3:0];
			case (instruction)
				NOPE 	 : mins <= 5'd3;
				CLAC	 : mins <= 5'd4;
				LDAC	 : mins <= 5'd5;
				LOADVAL: mins <= 5'd7;
				JPNZ	 : mins <= (z)?5'd9:5'd10;
				LSHIFT : mins <= 5'd12;
				RSHIFT : mins <= 5'd13;
				MOVE   : mins <= 5'd14;
				MOVEAC : mins <= 5'd15;
				ADD    : mins <= 5'd16;
				SUB    : mins <= 5'd17;
				INC	 : mins <= 5'd18;
				JUMP	 : mins <= 5'd19;
				STAC 	 : mins <= 5'd21;
				EOP 	 : mins <= 5'd22;
				OR		 : mins <= 5'd24;
			endcase
	end
			
endmodule 