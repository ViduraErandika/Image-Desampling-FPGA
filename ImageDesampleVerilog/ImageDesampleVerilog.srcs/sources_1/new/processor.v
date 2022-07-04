module processor(
	input wire [17:0] iram,dram, //data from iram and dram
	input wire start,
	input wire clk,
	output wire read,write,
	output wire [17:0] pcout,  // address to the Iram.
	output wire [17:0] marOut, //address to the Dram
	output wire[17:0] mdrOut,   //data input to the Dram
	output wire fetch
	);
	wire negclk;
	assign negclk  = ~clk;
	
	wire [17:0] A, B, C;
	wire [3:0] M_select ;
	wire [7:0] D_select;
	wire [17:0] Mr1, Mr2, Mr3, Mr4, Ml, Me, Mmdr;
	wire  lr1, lr2, lr3, lr4, ll, le, lmdr, lmar;
	wire incac;
	wire [2:0] PC_select;
	wire z;
	wire [3:0] operation;
	wire [17:0] aluOut;
	wire [17:0] mar,pc,mdr_out, iramIn, dramIn;
	wire [17:0] irCU;
	
	Register R1(.clk(negclk), .LDsignal(lr1), .Din(C), .Dout(Mr1));
	Register R2(.clk(negclk), .LDsignal(lr2), .Din(C), .Dout(Mr2));
	Register R3(.clk(negclk), .LDsignal(lr3), .Din(C), .Dout(Mr3));
	Register R4(.clk(negclk), .LDsignal(lr4), .Din(C), .Dout(Mr4));
	Register L(.clk(negclk), .LDsignal(ll), .Din(C), .Dout(Ml));
	Register E(.clk(negclk), .LDsignal(le), .Din(C), .Dout(Me));
	
	Register MAR(.clk(negclk), .LDsignal(lmar), .Din(C), .Dout(mar));
	PCRegister PC(.clk(clk),.Din(PC_select), .Dout(pc));
	MOutRegister mbru(.Din(iramIn),.Dout(irCU));
    MDRegister mdr(.clk(negclk),.DramIn(dramIn),.Din(C), .Dout(Mmdr), .DramOut(mdr_out));
	
	SRegister AC(.clk(clk), .Din(aluOut), .Dout(C), .inc(incac));
	
	ALU ALU(.A(C), .B(B), .C(aluOut), .z(z), .operation(operation), .clk(clk));
	
	Mux MUX(.select(M_select), .out(B), .r1(Mr1), .r2(Mr2), .r3(Mr3), .r4(Mr4), .l(Ml), .e(Me), .mdr(Mmdr));
					
	Decoder Decoder(.select(D_select), .r1(lr1), .r2(lr2), .r3(lr3), .r4(lr4), .l(ll),
								.e(le), .mdr(lmdr), .mar(lmar));
								
	
	ControlUnit CU(.ir(irCU), .z(z), .clk(clk), .start(start), .mux_sig(M_select), .alu_sig(operation),
							.iram_fetch(fetch), .dram_read(read), .dram_write(write), .load_decode_sig(D_select), .incac(incac),
							.pc_sig(PC_select));
							
						
	assign marOut = mar;   //address to the Dram.
	assign pcout = pc;     // address to the Iram.
	assign mdrOut = mdr_out;   //data input to the Dram
	assign iram = iramIn;  //data from iram
	assign dram = dramIn;  //data from dram
	
endmodule
	