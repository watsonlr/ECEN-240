`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/02/2022 06:21:03 PM
// Design Name: 
// Module Name: Lab8_ALU_FF_tb
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


module Lab8_ALU_FF_tb();
    reg [3:0] A;
    reg [3:0] B;
    wire [3:0] alu_out;
    reg [1:0] S;
    reg clk;
    wire [6:0] seg;
    wire [3:0] an;
    wire dp;
    
    // Instantiated module
    Lab8_ALU_FF FF(A, B, alu_out, S, clk, seg, an, dp);
    
    always #1 clk = ~clk;
    
    initial begin
        clk = 1'b0;
        A = 4'b0000;
        B = 4'b0000;
        S = 2'b00;
        
        #10 S = 00;     // XOR
        A = 4'b1001;    // Output: 0000
        B = 4'b1001;
        
        #10 S = 01;     // AND
        A = 4'b1001;    // Output: 1001
        B = 4'b1001;
        
        #10 S = 10;     // OR
        A = 4'b1001;    // Output: 1001
        B = 4'b1001;
        
        #10 S = 11;     // ADD
        A = 4'b1001;    // Output: 0010
        B = 4'b1001;
        
        #20 $finish;
    end
    
endmodule
