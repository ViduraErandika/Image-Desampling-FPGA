module Memory(
	input wire clk,
	input wire write,
	input wire read,
	input wire [15:0] Din,
	input wire [15:0] address,
	output wire [15:0] Dout
	); 
	
	reg [7:0] memory [0:255];
	reg [15:0] d;
	
	assign Dout = d;
	
	always @(posedge clk) begin
		if (read) d = {8'd0,memory[address]};
		else if (write) memory[address] = Din[7:0];
	end
	
	initial begin
memory[0] = 8'd1;
memory[1] = {4'd1,4'd11};
memory[2] = {4'd2,4'd11};
memory[3] = {4'd3,4'd11};
memory[4] = {4'd4,4'd11};
memory[5] = 8'd3;
memory[6] = 8'd2;
memory[7] = {4'd5,4'd11};
memory[8] = 8'd3;
memory[9] = 8'd254;
memory[10] = {4'd3,4'd13};
memory[11] = 8'd5;
memory[12] = 8'd23;
memory[13] = 8'd1;
memory[14] = {4'd3,4'd11};
memory[15] = {4'd2,4'd10};
memory[16] = {4'd5,4'd12};
memory[17] = {4'd2,4'd11};
memory[18] = {4'd4,4'd10};
memory[19] = 8'd4;
memory[20] = {4'd4,4'd11};
memory[21] = 8'd9;
memory[22] = 8'd51;
memory[23] = {4'd2,4'd10};
memory[24] = {4'd6,4'd11};
memory[25] = 8'd2;
memory[26] = {4'd1,4'd11};
memory[27] = {4'd2,4'd10};
memory[28] = 8'd4;
memory[29] = {4'd6,4'd11};
memory[30] = 8'd2;
memory[31] = 8'd6;
memory[32] = {4'd1,4'd12};
memory[33] = {4'd1,4'd11};
memory[34] = {4'd2,4'd10};
memory[35] = {4'd5,4'd12};
memory[36] = {4'd6,4'd11};
memory[37] = 8'd2;
memory[38] = {4'd1,4'd12};
memory[39] = 8'd7;
memory[40] = {4'd1,4'd11};
memory[41] = {4'd2,4'd10};
memory[42] = {4'd6,4'd11};
memory[43] = {4'd1,4'd10};
memory[44] = 8'd8;
memory[45] = {4'd3,4'd10};
memory[46] = 8'd4;
memory[47] = {4'd3,4'd11};
memory[48] = {4'd2,4'd10};
memory[49] = 8'd4;
memory[50] = {4'd2,4'd11};
memory[51] = 8'd3;
memory[52] = 8'd255;
memory[53] = 8'd4;
memory[54] = {4'd4,4'd13};
memory[55] = 8'd5;
memory[56] = 8'd8;
memory[57] = 8'd1;
memory[58] = {4'd1,4'd11};
memory[59] = {4'd2,4'd11};
memory[60] = {4'd3,4'd11};
memory[61] = {4'd4,4'd11};
memory[62] = 8'd3;
memory[63] = 8'd254;
memory[64] = {4'd3,4'd13};
memory[65] = 8'd5;
memory[66] = 8'd77;
memory[67] = 8'd1;
memory[68] = {4'd3,4'd11};
memory[69] = {4'd2,4'd10};
memory[70] = {4'd5,4'd12};
memory[71] = {4'd2,4'd11};
memory[72] = {4'd4,4'd10};
memory[73] = 8'd4;
memory[74] = {4'd4,4'd11};
memory[75] = 8'd9;
memory[76] = 8'd110;
memory[77] = {4'd2,4'd10};
memory[78] = {4'd6,4'd11};
memory[79] = 8'd2;
memory[80] = {4'd1,4'd11};
memory[81] = 8'd3;
memory[82] = 8'd255;
memory[83] = 8'd4;
memory[84] = {4'd2,4'd12};
memory[85] = {4'd6,4'd11};
memory[86] = 8'd2;
memory[87] = 8'd6;
memory[88] = {4'd1,4'd12};
memory[89] = {4'd1,4'd11};
memory[90] = 8'd3;
memory[91] = 8'd255;
memory[92] = 8'd4;
memory[93] = 8'd6;
memory[94] = {4'd2,4'd12};
memory[95] = {4'd6,4'd11};
memory[96] = 8'd2;
memory[97] = {4'd1,4'd12};
memory[98] = 8'd7;
memory[99] = {4'd1,4'd11};
memory[100] = {4'd2,4'd10};
memory[101] = {4'd6,4'd11};
memory[102] = {4'd1,4'd10};
memory[103] = 8'd8;
memory[104] = {4'd3,4'd10};
memory[105] = 8'd4;
memory[106] = {4'd3,4'd11};
memory[107] = {4'd2,4'd10};
memory[108] = 8'd4;
memory[109] = {4'd2,4'd11};
memory[110] = 8'd3;
memory[111] = 8'd254;
memory[112] = {4'd4,4'd13};
memory[113] = 8'd5;
memory[114] = 8'd62;
memory[115] = 8'd1;
memory[116] = {4'd1,4'd11};
memory[117] = {4'd2,4'd11};
memory[118] = {4'd3,4'd11};
memory[119] = {4'd4,4'd11};
memory[120] = {4'd5,4'd11};
memory[121] = {4'd2,4'd10};
memory[122] = {4'd6,4'd11};
memory[123] = 8'd2;
memory[124] = {4'd5,4'd11};
memory[125] = {4'd1,4'd10};
memory[126] = {4'd6,4'd11};
memory[127] = {4'd5,4'd10};
memory[128] = 8'd8;
memory[129] = 8'd3;
memory[130] = 8'd2;
memory[131] = {4'd2,4'd12};
memory[132] = {4'd2,4'd11};
memory[133] = {4'd1,4'd10};
memory[134] = 8'd4;
memory[135] = {4'd1,4'd11};
memory[136] = {4'd3,4'd10};
memory[137] = 8'd4;
memory[138] = {4'd3,4'd11};
memory[139] = 8'd3;
memory[140] = 8'd128;
memory[141] = {4'd3,4'd13};
memory[142] = 8'd5;
memory[143] = 8'd121;
memory[144] = 8'd3;
memory[145] = 8'd255;
memory[146] = 8'd4;
memory[147] = {4'd2,4'd12};
memory[148] = {4'd2,4'd11};
memory[149] = 8'd1;
memory[150] = {4'd3,4'd11};
memory[151] = {4'd4,4'd10};
memory[152] = 8'd4;
memory[153] = {4'd4,4'd11};
memory[154] = 8'd3;
memory[155] = 8'd128;
memory[156] = {4'd4,4'd13};
memory[157] = 8'd5;
memory[158] = 8'd121;
memory[159] = 8'd15;
		end
	
endmodule
	