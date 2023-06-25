`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2021 08:35:46 AM
// Design Name: 
// Module Name: Counters
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


module Counters(
    input reset,
    input down,
    output logic [2:0] Gray_out,
    output logic [2:0] Ring_out,
    output logic [2:0] UpDn_out,
    output [6:0] seg,
    output [3:0] an,
    output dp,
    input clk_100MHz
    );
    
    clk_div U0 (clk_100MHz, clk_slow, seg, an, dp);  
endmodule
