module ControlUnit(
	input wire [17:0] ir, // select last 8 bits
	input wire z,
	input wire start_sig, 
	input wire clk,
	
	output reg [3:0] mux_sig,
	output reg [3:0] alu_sig,
	output reg iram_fetch,
    output reg dram_read,
    output reg dram_write,
    output reg [7:0] load_decode_sig,
    output reg incac,
    output wire [2:0] PC_SIG // 
    
	);
	// Initial State
    reg [6:0] state = 7'd1;
    
    
    reg [2:0] pc_sig;
    assign PC_SIG = pc_sig;
    reg Z ;
    always @(posedge clk)begin
         Z<= z ;
    end
    
    
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
                  RESET    = 4'b1011,
                  ADD256_ALU = 4'b1100,
                  SUB256_ALU = 4'b1101,
                  MUL        = 4'b1110;	
                  
    // MUX parameters
	localparam   R1_M   = 4'b1000,
                  R2_M    = 4'b1001,
                  R3_M     = 4'b0101,
                  R4_M     = 4'b0100,
                  L_M  = 4'b0011,
                  E_M    = 4'b0010,
                  MDR_M   = 4'b0001,
                  none_M= 4'b0000;
                 
   //Decoder parameters
	localparam    MAR_D     = 8'b10000000,
                 MDR_D     = 8'b01000000,
                 L_D     = 8'b00100000,
                 R1_D       = 8'b00010000,
                 R2_D      = 8'b00001000,
                 R3_D      = 8'b00000100,
                 R4_D      = 8'b00000010,
                 E_D      = 8'b00000001,
                 none_D = 8'b00000000;
                
   //PC parameters
  localparam    pc_reset = 3'b000,
                pc_inc = 3'b001,
                pc_loop = 3'b010,
                pc_if = 3'b011,
                pc_default = 3'b100;
                 
  // AC increment
  localparam   inc_on= 1'b1,
               inc_off= 1'b0;
               
  // IRAM Read
  localparam   iram_fetch_on= 1'b1,
               iram_fetch_off=1'b0;
               
               
   //DRAM Read
   localparam   DRAM_read_on= 1'b1,
                DRAM_read_off=1'b0;
   //DRAM Write
   localparam   DRAM_write_on= 1'b1,
                DRAM_write_off=1'b0;
   
 
   
    
localparam     END1= 7'd1, FETCH0 = 7'd2, FETCH1 = 7'd3,FETCH2 = 7'd4, LDAC2=7'd5,STAC2 = 7'd6;
                
                 
//IR input parameters
localparam       NOP =8'd0, CLAC = 8'd1, LDAC = 8'd2, STAC=8'd3 , INAC=8'd4, DCAC=8'd5, ADD256=8'd6 , SUB256=8'd7 , SUBL=8'd8 , 
                 SUBBE=8'd9 , DIV2=8'd10 , DIV16=8'd11 , MUL2=8'd12 , MUL4=8'd13, MULL=8'd14, ADDR1=8'd15 , ADDR3=8'd16, ADDL=8'd17,
                 MVACL=8'd18, MVACE=8'd19 , MVACR1=8'd20 , MVACR2=8'd21 , MVACR3=8'd22, MVACR4=8'd23, MVACAR=8'd24, MVEAC=8'd25, 
                 MVR1AC=8'd26, MVR2AC=8'd27, MVR3AC=8'd28, MVR4AC=8'd29, JMPZ=8'd30, JMPN=8'd31, END=8'd32;
              


                 
always @(posedge clk)
     begin
     $monitor("The value of state has changed to %d",state);
                     case (state) 
                     FETCH1:
                          begin
                              mux_sig    <= none_M;
                              alu_sig    <= none_ALU;
                              load_decode_sig<= none_D;
                              incac      <= inc_off;
                              iram_fetch  <= iram_fetch_on;                         
                              dram_read  <= DRAM_read_off;
                              dram_write <= DRAM_write_off; 
                              pc_sig     <= pc_default;
                              state      <= FETCH2;                                           
                          end
                  
                     FETCH2:
                     begin
                                          
                        case(ir[7:0])
                        
                        NOP:
                        begin
                            mux_sig    <= none_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= none_ALU;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;                            
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1;
                        end
                        
                        CLAC:                            
                        begin
                            mux_sig    <= none_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= RESET;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off; 
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1;                          
                        end
                        
                        LDAC:
                        begin
                            mux_sig  <= none_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= none_ALU;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_on;
                            dram_write <= DRAM_write_off; 
                            state      <= LDAC2;
                        end
                        
                        STAC:
                        begin
                            mux_sig    <= none_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= none_ALU;
                            load_decode_sig<= MDR_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= STAC2 ;             
                        end
                        
                        INAC:
                        begin
                            mux_sig    <= none_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= none_ALU;
                            load_decode_sig<= none_D;
                            incac      <= inc_on;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1;
                        end
                        
                        DCAC:
                        begin
                            mux_sig    <= none_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= DECAC;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        ADD256:
                        begin
                            mux_sig    <= none_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= ADD256_ALU;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        SUB256:
                        begin
                            mux_sig    <= none_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= SUB256_ALU;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        SUBL:
                        begin
                            mux_sig    <= L_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= SUB;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        SUBBE:
                        begin
                            mux_sig    <= E_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= SUB;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        DIV2:
                        begin
                            mux_sig    <= none_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= RSHIFT1;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        DIV16:
                        begin
                            mux_sig    <= none_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= RSHIFT4;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        MUL2:
                        begin
                            mux_sig    <= none_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= LSHIFT1;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        MUL4:
                        begin
                            mux_sig    <= none_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= LSHIFT2;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        MULL:
                        begin
                            mux_sig    <= L_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= MUL;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        ADDR1:
                        begin
                            mux_sig    <= R1_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= ADD;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        ADDR3:
                        begin
                            mux_sig    <= R3_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= ADD;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        ADDL:
                        begin
                            mux_sig   <= L_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= ADD;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        MVACL:
                        begin
                            mux_sig    <= none_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= none_ALU;
                            load_decode_sig<= L_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        MVACE:
                        begin
                            mux_sig    <= none_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= none_ALU;
                            load_decode_sig<= E_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        MVACR1:
                        begin
                            mux_sig   <= none_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= none_ALU;
                            load_decode_sig<= R1_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        MVACR2:
                        begin
                            mux_sig    <= none_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= none_ALU;
                            load_decode_sig<= R2_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        MVACR3:
                        begin
                            mux_sig    <= none_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= none_ALU;
                            load_decode_sig<= R3_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        MVACR4:
                        begin
                            mux_sig    <= none_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= none_ALU;
                            load_decode_sig<= R4_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        MVACAR:
                        begin
                            mux_sig    <= none_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= none_ALU;
                            load_decode_sig<= MAR_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        MVEAC:
                        begin
                            mux_sig    <= E_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= PASSBTOC;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        MVR1AC:
                        begin
                            mux_sig    <= R1_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= PASSBTOC;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        MVR2AC:
                        begin
                            mux_sig    <= R2_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= PASSBTOC;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        MVR3AC:
                        begin
                            mux_sig    <= R3_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= PASSBTOC;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        MVR4AC:
                        begin
                            mux_sig    <= R4_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= PASSBTOC;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        
                        JMPZ:
                        begin
                        case(Z)
                        1:
                        begin
                            mux_sig    <= none_M;
                            pc_sig  <= pc_inc;
                            alu_sig    <= none_ALU;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ;
                        end 
                        0:
                        begin
                            mux_sig    <= none_M;
                            pc_sig     <= pc_loop;
                            alu_sig    <= none_ALU;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        endcase
                        end
                        
                        JMPN:
                        begin
                        case(Z)
                        1:
                        begin
                            mux_sig    <= none_M;
                            pc_sig     <= pc_inc;
                            alu_sig    <= none_ALU;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1 ; 
                        end
                        0:
                        begin
                            mux_sig    <= none_M;
                            pc_sig     <= pc_if;
                            alu_sig    <= none_ALU;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= FETCH1;
                        end
                        
                        endcase
                        end
                        
                        END:
                        begin
                            mux_sig    <= none_M;
                            pc_sig     <= pc_default;
                            alu_sig    <= none_ALU;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            state      <= END1;
                       end
                                      
                        endcase
                     end                    
                      
                     LDAC2:
                     begin
                            mux_sig    <= MDR_M;
                            alu_sig    <= PASSBTOC;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;                            
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_off; 
                            pc_sig     <= pc_default;
                            state      <= FETCH1;                      
                     end
                     
                     STAC2:
                     begin
                            mux_sig    <= none_M;
                            alu_sig    <= none_ALU;
                            load_decode_sig<= none_D;
                            incac      <= inc_off;
                            iram_fetch  <= iram_fetch_off;
                            dram_read  <= DRAM_read_off;
                            dram_write <= DRAM_write_on; 
                            pc_sig     <= pc_default;
                            state      <= FETCH1;
                     end
                     
                     END1:
                     begin
                        mux_sig <= none_M;
                        alu_sig <= none_ALU;
                        load_decode_sig<= none_D;
                        incac<= inc_off;
                        iram_fetch <= iram_fetch_off;
                        
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
                                     state <= END1;
                                 end
                      end
                      endcase
end


                     
                      
endmodule