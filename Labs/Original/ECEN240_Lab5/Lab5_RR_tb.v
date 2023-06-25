`timescale 1ms / 1us
//////////////////////////////////////////////////////////////////////////////////
// Company: Brigham Young University - Idaho
// Engineer: Celeste Popoca
// 
// Create Date: 04/27/2022 04:44:36 PM
// Design Name: Lab 5 - Road Ripper Test Bench
// Module Name: Lab5_RR_tb
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


module Lab5_RR_tb();
    reg Clock, Stop, Left, Right;
    wire L_Front, L_Back, R_Front, R_Back;
    
    
    // Instantiated top module
    Lab5_RR TB(.Stop(Stop), .Left(Left), .Right(Right), .Clock(Clock), .L_Front(L_Front), .L_Back(L_Back), .R_Front(R_Front), .R_Back(R_Back));
    
    // Clock
    always #335 Clock = !Clock; //change clock level every 335ms
    
    // Test
    initial begin
        Clock = 1'b0;
        // Input: 000
        Stop = 1'b0;  Left = 1'b0;  Right = 1'b0;
        // Input: 001,  wait 2000ms then set the signal levels
        #2000 Stop = 1'b0;  Left = 1'b0;  Right = 1'b1;
        // Input: 010,  wait an additional 2000ms before updating levels
        #2000 Stop = 1'b0;  Left = 1'b1;  Right = 1'b0;
        // Input: 011
        #2000 Stop = 1'b0;  Left = 1'b1;  Right = 1'b1;
        // Input: 100
        #2000 Stop = 1'b1;  Left = 1'b0;  Right = 1'b0;
        // Input: 101
        #2000 Stop = 1'b1;  Left = 1'b0;  Right = 1'b1;
        // Input: 110
        #2000 Stop = 1'b1;  Left = 1'b1;  Right = 1'b0;
        // Input: 111
        #2000 Stop = 1'b1;  Left = 1'b1;  Right = 1'b1;
        
        #2000 $finish;
    end
    
endmodule
