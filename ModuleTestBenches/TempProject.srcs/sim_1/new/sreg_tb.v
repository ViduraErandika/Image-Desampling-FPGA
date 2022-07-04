`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/03/2022 05:02:03 PM
// Design Name: 
// Module Name: sreg_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sreg_tb();
//inputs
 localparam  clock_period = 10;
    reg clk;
    initial begin
        clk = 1;
        forever #(clock_period/2) clk <= ~clk;
    end
  wire negclk;
  assign negclk = ~clk;
    
 reg inc;
 reg [17:0] Din;
 //outputs
 wire [17:0] Dout;
 
 SRegister test(
    .clk(negclk),
    .Din(Din),
    .inc(inc),
    .Dout(Dout)
    );
    
 initial begin
 
 inc <= 0;
 Din <= 17'd64;
 #10;
 
  inc <= 1;
 #10;

 inc <= 0;
Din <= 17'd16;
#10;
 
 end
endmodule
