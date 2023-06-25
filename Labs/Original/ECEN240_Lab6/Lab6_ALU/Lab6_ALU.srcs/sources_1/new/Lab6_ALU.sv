`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2021 11:19:05 PM
// Design Name: 
// Module Name: Lab6_ALU
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


module Lab6_ALU(
    input logic [3:0] A,
    input logic [3:0] B,
    input logic [1:0] S,
    output logic [3:0] ALU_out
    );
    //Declare the logic signals that you are using as internal signals to interconnect the modules
    logic [3:0] ADD_out; //Example declaration for the Adder output
    logic [3:0] AND_out, OR_out, XOR_out;
    
    ADD4 U0 (A, B, ADD_out);   //Module instantiation for the adder.  "ADD4" is the mdule name, U0 is the instance name
    AND4 U1 (A, B, AND_out);   //Module instantiation for the AND circuit.
    OR4  U2 (A, B, OR_out);   //Module instantiation for the OR circuit
    XOR4 U3 (A, B, XOR_out);   //Module instantiation for the XOR circuit
    MUX4bit_4to1 U4 (S, XOR_out, AND_out, OR_out, ADD_out, ALU_out);  //Module instantiation for the MUX circuit
endmodule

module ADD4(
  input logic [3:0] A,
  input logic [3:0] B,
  output logic [3:0] out
  );
  assign out = A + B;
  
endmodule

module AND4(
  input logic [3:0] A,
  input logic [3:0] B,
  output logic [3:0] out
  );
  //Put your assign statement here 
  assign out = A & B;
endmodule

module OR4(
  input logic [3:0] A,
  input logic [3:0] B,
  output logic [3:0] out
  );
  //Put your assign statement here 
  assign out = A | B;
endmodule

module XOR4(
  input logic [3:0] A,
  input logic [3:0] B,
  output logic [3:0] out
  );
  //Put your assign statement here 
  assign out = A ^ B;
endmodule

module MUX4bit_4to1(
  input logic [1:0] S,
  input logic [3:0] in0,
  input logic [3:0] in1,
  input logic [3:0] in2,
  input logic [3:0] in3,
  output logic [3:0] out
  );
  // Put your logic signals here
  logic [3:0] out1, out2;
  //Put your assign statements here 
  assign out1 = S[1]?in2:in0;
  assign out2 = S[1]?in3:in1;
  assign out = S[0]?out2:out1;
endmodule
