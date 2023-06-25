`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2017 04:22:07 PM
// Design Name: 
// Module Name: clk_div
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


module clk_div(
    input clk,        // This is the 100MHz clock from the Basys3
    output clk_slow,  // This is the slow clock used to clock Flip-Flops
    output [6:0] seg, // Selects specific LEDs in the 7-segment display
    output [3:0] an,  // Selects the column in the 7-segment display
    output dp         // Selects the decimal point in the 7-segment display
    );
    reg [27:0] counter;
    
    assign clk_slow = counter[27];
    assign an = 4'b0000;
    assign dp = 1'b1;
    assign seg = {3'b111,counter[27],2'b11,!counter[27]};
    
    always @ (posedge clk)
    begin
        counter <= counter + 1'b1;
    end
endmodule
