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
			
<<<<<<< origin/main
endmodule 
=======
//endmodule 


module ControlUnit(
	input wire [17:0] ir, // select last 8 bits
	input wire z,
	input wire start_sig, 
	input wire clk,
	output reg [3:0] mux_sig,
	output reg [3:0] alu_sig,
	output reg iram_read,
    output reg iram_write,
    output reg dram_read,
    output reg dram_write,
    output reg [8:0] load_decode_sig,
    output reg incac,
    output reg [2:0] pc_sig // 
    
	);
	// Initial State
    reg [6:0] state = 7'd43; 
    
	// ALU parameters
    localparam   none_ALU    = 4'b0000,
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
                  
    // MUX parameters
    localparam   none_M = 4'b0000, 
                 R1_M  = 4'b0110,
                 R2_M  = 4'b0111,
                 R3_M  = 4'b1000,
                 R4_M   = 4'b1001,
                 L_M    = 4'b0101,
                 E_M    = 4'b0100,
                 MBRU_M = 4'b0011,
                 PC_M   = 4'b0010,
                 MDR_M  = 4'b0001;
                 
   //Decoder parameters
   localparam    none_D= 9'b000000000,
                MAR_D  = 9'b100000000,
                 MDR_D  = 9'b010000000,
                 PC_D   = 9'b001000000,
                 L_D    = 9'b000100000,
                 R1_D   = 9'b000010000,
                 R2_D   = 9'b000001000,
                 R3_D   = 9'b000000100,
                 R4_D   = 9'b000000010,
                 E_D    = 9'b000000001;
                
   //PC parameters
  localparam    pc_reset= 3'b000,
                 pc_inc= 3'b001,
                 pc_loop= 3'b010,
                 pc_if=3'b011,
                 pc_default=3'b100;
                 
  // AC increment
  localparam   inc_on= 1'b0,
               inc_off= 1'b1;
               
  // IRAM Read
  localparam   IRAM_read_on= 1'b0,
               IRAM_read_off=1'b1;
               
  //IRAM Write
  localparam   IRAM_write_on= 1'b0,
               IRAM_write_off=1'b1;
               
   //DRAM Read
   localparam   DRAM_read_on= 1'b0,
                DRAM_read_off=1'b1;
   //DRAM Write
     localparam   DRAM_write_on= 1'b0,
                  DRAM_write_off=1'b1;
   
   
    
 localparam     FETCH1 = 7'd1, FETCH2 = 7'd2,NOP = 7'd3,LDAC1= 7'd4,LDAC2= 7'd5,STAC1= 7'd6,STAC2= 7'd7,CLAC= 7'd8,MVACMAR = 7'd8,
                 MVACR1= 7'd9,MVACR2= 7'd10,MVACR3= 7'd11,MVACR4= 7'd12,MVACL= 7'd13,MVACE= 7'd14,MVR1AC= 7'd15,MVR2AC= 7'd16,
                 MVR3AC= 7'd17,MVR4AC= 7'd18,MVEAC= 7'd19,MVLAC= 7'd20,INAC= 7'd21,DCAC= 7'd22,ADD256= 7'd23,ADDR1= 7'd24,
                 ADDR3= 7'd25,ADDL= 7'd26,SUB256= 7'd27,SUBL= 7'd28,SUBE= 7'd29,DIV2= 7'd30,DIV16= 7'd31,MUL2= 7'd32,
                 MUL4= 7'd33,MULL= 7'd34, JMPZY1= 7'd35,JMPZY2 =7'd36,JMPZY3 =7'd37,JMPZX1=7'd38,
                 JMPNY1= 7'd39,JMPNY2 =7'd40,JMPNY3 =7'd41,JMPNX1=7'd42,END= 7'd43;
                 
 always @(posedge clk)
                 begin
                     case (state) 
                     FETCH1:
                     begin
                         mux_sig <= none_M;
                         alu_sig <= none_ALU;
                         load_decode_sig<= none_D;
                         incac<= inc_off;
                         iram_read <= IRAM_read_off;
                         iram_write <= IRAM_write_off;
                         dram_read <= DRAM_read_off;
                         dram_write <= DRAM_write_off; 
                         pc_sig <= pc_default;
                         state <= FETCH2;
                        
                        
                     end 
                     END:
                     begin
                        mux_sig <= none_M;
                        alu_sig <= none_ALU;
                        load_decode_sig<= none_D;
                        incac<= inc_off;
                        iram_read <= IRAM_read_off;
                        iram_write <= IRAM_write_off;
                        dram_read <= DRAM_read_off;
                        dram_write <= DRAM_write_off;    
                        if (start_sig)	
                                 begin
                                     pc_sig <= pc_reset;
                                     state <= FETCH1;
                                 end
                                 else 
                                 begin
                                     pc_sig <= pc_default;
                                     state <= END;
                                 end
                                 end
                      endcase
end

                     

                     
                      
endmodule            
>>>>>>> local
