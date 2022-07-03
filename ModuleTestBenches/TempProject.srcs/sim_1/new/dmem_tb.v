`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/03/2022 06:35:25 PM
// Design Name: 
// Module Name: dmem_tb
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


module dmem_tb();

 localparam  clock_period = 10;
   reg clk;
   initial begin
       clk = 0;
       forever #(clock_period/2) clk <= ~clk;
   end
  //input
 reg write;
 reg read;
 reg [17:0] Din;
 reg [17:0] address;
 //output
 wire [17:0] Dout;
 
 DMemory test(
 .clk(clk),
 .write(write),
 .read(read),
 .Din(Din),
 .address(address),
 .Dout(Dout)
 );
 
  initial begin
 
 read <= 1;
 write <= 0;
 address <= 18'd0; 
 #10;
 
 read <= 1;
 write <= 0;
 address <= 18'd5; 
 #10;
 
 read <= 0;
 write <= 1;
 Din <= 18'd10;
 address <= 18'd66566; 
 #10;
 
 read <= 1;
 write <= 0;
 address <= 18'd264; 
 #10;
 
 read <= 0;
 write <= 1;
 Din <= 18'd20;
 address <= 18'd66567; 
 #10;
 
 read <= 1;
 write <= 0;
 address <= 18'd264; 
 #10;
 
 
 end
endmodule
