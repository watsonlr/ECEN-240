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
    
    ADD4 U0 (A, B, ADD_out);   //Example module instantiation for the adder.  "ADD4" is the mdule name, U0 is the instance name
    AND4 U1 ();   //Module instantiation for the AND circuit.
    OR4  U2 ();   //Module instantiation for the OR circuit
    XOR4 U3 ();   //Module instantiation for the XOR circuit
    MUX4bit_4to1 U4 ();  //Module instantiation for the MUX circuit
endmodule

module ADD4(
  input logic [3:0] A,
  input logic [3:0] B,
  output logic [3:0] out
  );
  assign out = A + B; //Example completion of the 4-bit adder
  
endmodule

module AND4(
  input logic [3:0] A,
  input logic [3:0] B,
  output logic [3:0] out
  );
  //Put your assign statement here 
  
endmodule

module OR4(
  input logic [3:0] A,
  input logic [3:0] B,
  output logic [3:0] out
  );
  //Put your assign statement here 
  
endmodule

module XOR4(
  input logic [3:0] A,
  input logic [3:0] B,
  output logic [3:0] out
  );
  //Put your assign statement here 
  
endmodule

module MUX4bit_4to1(
  input logic [1:0] S,
  input logic [3:0] in0,
  input logic [3:0] in1,
  input logic [3:0] in2,
  input logic [3:0] in3,
  output logic [3:0] out
  );
  // Declare your logic signals here
  
  //Put your assign statements here 
 
endmodule
