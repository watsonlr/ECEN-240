`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2021 10:24:50 PM
// Design Name: 
// Module Name: Register_File
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


module Register_File(
    input [3:0] Data_in,
    input [2:0] WAddr,
    input [2:0] RAddr,
    input WE,
    input clk_100MHz,
    output [3:0] Data_out,
    output [6:0] seg,
    output [3:0] an,
    output dp
    );
    
    logic [3:0] RegFile [8];
    logic clk;
    
    assign Data_out = RegFile[RAddr];
    
    always_ff @ (posedge clk)
       if (WE)
         RegFile[WAddr] <= Data_in;
         
    clk_div U0(clk_100MHz, clk, seg, an, dp); 
endmodule
