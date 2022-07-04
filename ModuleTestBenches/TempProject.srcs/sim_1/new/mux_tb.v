`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/03/2022 05:21:57 PM
// Design Name: 
// Module Name: mux_tb
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


module mux_tb();

//inputs
 localparam  clock_period = 10;
    reg clk;
    initial begin
        clk = 0;
        forever #(clock_period/2) clk <= ~clk;
    end
    
 reg [3:0] select;
 reg [17:0] r1;
 reg [17:0] r2;
 reg [17:0] r3;
 reg [17:0] r4;
 reg [17:0] l;
 reg [17:0] e;
 reg [17:0] mdr;
 //outputs
 wire [17:0] out;
 
 Mux test(
    .select(select),
    .r1(r1),
    .r2(r2),
    .r3(r3),
    .r4(r4),
    .l(l),
    .e(e),
    .mdr(mdr),
    .out(out)
    );
    
 integer i;
 initial begin
 r1 <= 18'd1;
 r2 <= 18'd2;
 r3 <= 18'd3;
 r4 <= 18'd4;
 l <= 18'd5;
 mdr <= 18'd9;
 e <= 18'd6;

 select = 4'b0000;
 #10;
 for(i=0;i<5;i=i+1)begin
 select = select + 4'd1;
  #10;
 end
 
 select = 4'b1000; #10;
 select = 4'b1001; #10;
 
 end   
 
endmodule
