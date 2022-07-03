module processor(
	input wire [15:0] pram,dram,
	input wire start,
	input wire clk,
	output wire read,write,
	output wire [15:0] acout,
	output wire [15:0] arout,pcout,
	output wire endp
	);
	
	wire [15:0] A, B, C;
	wire [3:0] M_select, D_select;
	wire [15:0] r1, r2, r3, r4, r5, ar, ac, ir, pc;
	wire [15:0] lr1, lr2, lr3, lr4, lr5, lar, lac, lir, lpc;
	wire incac, incpc, resetac, resetpc;
	wire z;
	wire [2:0] operation;
	
	Register R1(.clk(clk), .LDsignal(lr1), .Din(C), .Dout(r1));
	Register R2(.clk(clk), .LDsignal(lr2), .Din(C), .Dout(r2));
	Register R3(.clk(clk), .LDsignal(lr3), .Din(C), .Dout(r3));
	Register R4(.clk(clk), .LDsignal(lr4), .Din(C), .Dout(r4));
	Register R5(.clk(clk), .LDsignal(lr5), .Din(C), .Dout(r5));
	Register AR(.clk(clk), .LDsignal(lar), .Din(C), .Dout(ar));
	
	SRegister AC(.clk(clk), .LDsignal(lac), .Din(C), .Dout(ac), .inc(incac), .reset(resetac));
	SRegister PC(.clk(clk), .LDsignal(lpc), .Din(C), .Dout(pc), .inc(incpc), .reset(resetpc));
	
	ALU ALU(.A(A), .B(B), .C(C), .z(z), .operation(operation), .clk(clk));
	
	Mux MUX(.select(M_select), .out(A), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .ar(ar), .ac(ac), .ir(ir),
	            .pram(pram), .dram(dram));
					
	Decoder Decoder(.select(D_select), .r1(lr1), .r2(lr2), .r3(lr3), .r4(lr4), .r5(lr5),
								.ar(lar), .ac(lac), .ir(lir), .pc(lpc));
	
	ControlUnit CU(.ir(ir), .z(z), .clk(clk), .start(start), .D_select(D_select), .M_select(M_select),
							.operation(operation), .read(read), .write(write), .endp(endp), .incac(incac), .incpc(incpc),
							.resetac(resetac), .resetpc(resetpc));
							
	MBRURegister mbru(.Din(pram),.Dout(ir));						
	assign arout = ar; //address to the Dram.
	assign pcout = pc; // address to the Pram.
	assign acout = ac;//data input to the Dram
	assign B = ac;
	
endmodule
	