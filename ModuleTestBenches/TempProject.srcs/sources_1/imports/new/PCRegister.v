module PCRegister(
	input wire clk,
    input wire [2:0] Din,
    output wire [17:0] Dout
);
reg [17:0] d;
assign Dout = d;

   //PC parameters
  localparam    pc_reset= 3'b000,
                pc_inc= 3'b001,
                pc_loop= 3'b010,
                pc_if=3'b011,
                pc_default=3'b100;


always @(posedge clk) begin
    case(Din)
    pc_reset: d<= 18'd0;
    pc_inc: d<= d+ 18'd1;
    pc_loop: d<= 18'd35;
    pc_if: d<= 18'd126 ;
    pc_default: d <= d;

endcase
end


endmodule
