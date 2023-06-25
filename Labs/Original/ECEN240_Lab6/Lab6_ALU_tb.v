`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Brigham Young University - Idaho
// Engineer: Celeste Popoca
// 
// Create Date: 04/29/2022 07:48:13 PM
// Design Name: 
// Module Name: Lab6_ALU_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: (From Lab 6's sheet)
//      Testing inputs: __A__|__B__
//                      1001 | 1001
//                      0000 | 1111
//                      1111 | 1111
//                      1010 | 0101
//                      0010 | 0111
//
//////////////////////////////////////////////////////////////////////////////////


module Lab6_ALU_tb();
    reg [3:0] in_A;
    reg [3:0] in_B;
    reg [1:0] select;
    wire [3:0] out;
    
    Lab6_ALU ALU(.A(in_A), .B(in_B), .S(select), .ALU_out(out));
    
    initial begin
        // Set values
        select = 2'b00;
        in_A = 4'b0000;
        in_B = 4'b0000;
        
        // INPUTS A and B = 1001
        #10 select = 2'b00;     // XOR
        in_A = 4'b1001;         // out = 0000
        in_B = 4'b1001;
        
        #10 select = 2'b01;     // AND
        in_A = 4'b1001;         // out = 1001
        in_B = 4'b1001;
        
        #10 select = 2'b10;     // OR
        in_A = 4'b1001;         // out = 1001
        in_B = 4'b1001;
        
        #10 select = 2'b11;     // ADD
        in_A = 4'b1001;         // out = 0010
        in_B = 4'b1001;
        
        
        // INPUTS: A = 0000 and B = 1111
        #15 select = 2'b00;     // XOR
        in_A = 4'b0000;         // out = 1111
        in_B = 4'b1111;
        
        #10 select = 2'b01;     // AND
        in_A = 4'b0000;         // out = 0000
        in_B = 4'b1111;
        
        #10 select = 2'b10;     // OR
        in_A = 4'b0000;         // out = 1111
        in_B = 4'b1111;
        
        #10 select = 2'b11;     // ADD
        in_A = 4'b0000;         // out = 1111
        in_B = 4'b1111;
        
        
        // INPUTS: A and B = 1111
        #15 select = 2'b00;     // XOR
        in_A = 4'b1111;         // out = 0000
        in_B = 4'b1111;
        
        #10 select = 2'b01;     // AND
        in_A = 4'b1111;         // out = 1111
        in_B = 4'b1111;
        
        #10 select = 2'b10;     // OR
        in_A = 4'b1111;         // out = 1111
        in_B = 4'b1111;
        
        #10 select = 2'b11;     // ADD
        in_A = 4'b1111;         // out = 1110
        in_B = 4'b1111;
        
        
        // INPUTS: A = 1010 and B = 0101
        #15 select = 2'b00;     // XOR
        in_A = 4'b1010;         // out = 1111
        in_B = 4'b0101;
        
        #10 select = 2'b01;     // AND
        in_A = 4'b1010;         // out = 0000
        in_B = 4'b0101;
        
        #10 select = 2'b10;     // OR
        in_A = 4'b1010;         // out = 1111
        in_B = 4'b0101;
        
        #10 select = 2'b11;     // ADD
        in_A = 4'b1010;         // out = 1111
        in_B = 4'b0101;
        
        
        // INPUTS A = 0010 and B = 0011
        #15 select = 2'b00;     // XOR
        in_A = 4'b0010;         // out = 0001
        in_B = 4'b0011;
        
        #10 select = 2'b01;     // AND
        in_A = 4'b0010;         // out = 0010
        in_B = 4'b0011;
        
        #10 select = 2'b10;     // OR
        in_A = 4'b0010;         // out = 0011
        in_B = 4'b0011;
        
        #10 select = 2'b11;     // ADD
        in_A = 4'b0010;         // out = 0101
        in_B = 4'b0011;
        
        #20 $finish;
    end
    
endmodule
