`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/04/2022 03:35:46 PM
// Design Name: 
// Module Name: pc_tb
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


module pc_tb();
localparam  clock_period = 10;
    reg clk;
    initial begin
        clk = 0;
        forever #(clock_period/2) clk <= ~clk;
    end
    
    reg [2:0] Din;
    wire [17:0] Dout;
    
    PCRegister test(
    .clk(clk),
    .Din(Din),
    .Dout(Dout)
    );
    
       //PC parameters
   localparam    pc_reset = 3'b000,
                 pc_inc = 3'b001,
                 pc_loop = 3'b010,
                 pc_if = 3'b011,
                 pc_default = 3'b100;
    initial begin
    $monitor("The value of Din has changed to %d",Din);      
    Din <= pc_reset; #10;
    Din <= pc_inc; #10;
    Din <= pc_loop; #10;
    Din <= pc_if; #10;
    Din <= pc_default; #10;
    end
    
endmodule
