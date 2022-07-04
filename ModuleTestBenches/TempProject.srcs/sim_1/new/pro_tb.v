`timescale 1ns / 100ps

module pro_tb();
//inputs
 reg start;
 reg clk;
 

 localparam  clock_period = 10;
 initial begin
        clk = 0;
        forever #(clock_period/2) clk <= ~clk;
    end
 TopModule test(
 .clk(clk),
 .start(start)
 );
 
 initial begin
 start <= 0; 
 #50;
 start <= 1;
 #50;
 start <= 0; 
 #30_500_000;
 $finish;
 end
 
endmodule
