`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/03/2022 04:50:53 PM
// Design Name: 
// Module Name: reg_tb
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


module reg_tb();

//inputs
 localparam  clock_period = 10;
    reg clk;
    initial begin
        clk = 0;
        forever #(clock_period/2) clk <= ~clk;
    end
 reg LDsignal;
 reg [17:0] Din;
 //outputs
 wire [17:0] Dout;
 
 Register test(
    .clk(clk),
    .LDsignal(LDsignal),
    .Din(Din),
    .Dout(Dout)
    );
    
 initial begin
 
 LDsignal<= 1;
 Din <= 17'd64;
 #10;
 
  LDsignal<= 1;
 Din <= 17'd32;
 #10;
 
 end
    
endmodule
