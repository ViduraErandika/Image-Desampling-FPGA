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
        clk = 0;
        forever #(clock_period/2) clk <= ~clk;
    end
    
 reg LDsignal;
 reg inc;
 reg reset;
 reg [17:0] Din;
 //outputs
 wire [17:0] Dout;
 
 SRegister test(
    .clk(clk),
    .LDsignal(LDsignal),
    .Din(Din),
    .inc(inc),
    .reset(reset),
    .Dout(Dout)
    );
    
 initial begin
 
 LDsignal<= 1;
 reset <=0;
 inc <= 0;
 Din <= 17'd64;
 #10;
 
  LDsignal<= 0;
  reset <=0;
  inc <= 1;
 #10;
 
  LDsignal<= 0;
 reset <=1;
 inc <= 0;
//Din <= 17'd16;
#10;
 
 end
endmodule
