`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/03/2022 02:46:15 PM
// Design Name: 
// Module Name: alu_tb
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


module alu_tb();

    localparam  clock_period = 10;
    reg clk;
    initial begin
        clk = 0;
        forever #(clock_period/2) clk <= ~clk;
    end
    
     //inputs
     reg [17:0] A;
     reg [17:0] B;
     reg [3:0] operation;
     //output
     wire z;
     wire [17:0] C;
    
    ALU test(
        .clk(clk),
        .A(A),
        .B(B),
        .operation(operation),
        .z(z),
        .C(C)
    );
    integer i;
    
    initial begin
    A <= 18'd64;
    B <= 18'd32;
    operation <= 4'b0000;
    
   
    
    for( i=0; i<10 ; i=i+1)begin
    operation = operation + 4'b0001;
    B = B + 18'd1;
    #10; //delay
    end
    end
     
    
    
        
    
    
endmodule :alu_tb
