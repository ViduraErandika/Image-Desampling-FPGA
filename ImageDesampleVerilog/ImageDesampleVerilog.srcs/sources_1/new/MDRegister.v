module MDRegister(
input wire clk,
    input wire [17:0] DramIn,
    input wire [17:0] Din,
    output wire [17:0] Dout,
    output wire [17:0] DramOut
);

reg [17:0] d;
assign DramOut = d;

reg [17:0] Bbus;
assign Dout = Bbus;

always @(DramIn) begin
    Bbus<=DramIn;
end

always @(negedge clk) begin
    d<=Din;
end
endmodule 
