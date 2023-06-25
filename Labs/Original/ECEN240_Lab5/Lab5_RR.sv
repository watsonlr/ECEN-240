`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2021 07:33:11 AM
// Design Name: 
// Module Name: Lab5_RR
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

module Lab5_RR_top(
    input logic S,
    input logic L,
    input logic R,
    input logic clk100MHz,
    output logic [3:0] an,
    output logic segA, segB, segC, segD, segE, segF, segG,
    output logic dp
    );
    
    logic clk;
    logic LF, LB, RF, RB;
    
    Lab5_RR U0 (S, L, R, clk, LF, LB, RF, RB);
    clk_gen U1 (clk100MHz, clk);
    
    assign an = 4'b1110; // 1110 only turns on the Right 7-segment display
    assign dp = 1'b1;   // a logic 1 means off
    assign segA = 1'b1; // a logic 1 means off
    assign segB = !RF;
    assign segC = !RB;
    assign segD = 1'b1;
    assign segE = !LB;
    assign segF = !LF;
    assign segG = 1'b0; // Turn on the middle segment to represent the car
    
endmodule

module Lab5_RR(
    input logic Stop,
    input logic Left,
    input logic Right,
    input logic Clock,
    output logic L_Front,
    output logic L_Back,
    output logic R_Front,
    output logic R_Back
    );
    logic ; //put your list of internal signals here
    
    not ();
    not ();
    
    and ();
    and ();
    and ();
    and ();
    and ();
    and ();
    
    or ();
    or ();
endmodule

module clk_gen(
     input logic clk100MHz,
     output logic clk
     );
     
     logic [25:0] count;
     
     assign clk = count[25];
     always_ff @(posedge clk100MHz)
       count <= count + 1;    
endmodule
