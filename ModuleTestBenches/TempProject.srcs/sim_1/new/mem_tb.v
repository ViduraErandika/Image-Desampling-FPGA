`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/03/2022 05:45:01 PM
// Design Name: 
// Module Name: mem_tb
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


module mem_tb();
 localparam  clock_period = 10;
   reg clk;
   initial begin
       clk = 0;
       forever #(clock_period/2) clk <= ~clk;
   end
  //input
 reg fetch;
 reg [17:0] address;
 //output
 wire [17:0] Dout;
 
 Memory test(
 .clk(clk),
 .fetch(fetch),
 .address(address),
 .Dout(Dout)
 );
 

 initial begin
 
 fetch <= 1;
 address <= 18'd0; 
 #10;
 
  fetch <= 1;
 address <= 18'd5; 
 #10;
 
  fetch <= 1;
 address <= 18'd10; 
 #10;
 
  fetch <= 1;
 address <= 18'd20; 
 #10;
 
  fetch <= 1;
 address <= 18'd134; 
 #10;
 
 
 end
 
endmodule
