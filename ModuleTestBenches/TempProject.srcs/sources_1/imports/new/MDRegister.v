module MDRegister(
input wire clk,
    input wire [17:0] DramIn, //input from dram
    input wire [17:0] Din, //input from the C bus
    input wire LDsignal,
    output wire [17:0] Dout, //data to B bus
    output wire [17:0] DramOut //data output to the dram
);

reg [17:0] d;
assign DramOut = d;

reg [17:0] Bbus;
assign Dout = Bbus;

always @(DramIn) begin
    Bbus<=DramIn;
end

always @(posedge clk) begin
    if (LDsignal) d<=Din;
end
endmodule 
