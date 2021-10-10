`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2021 10:06:25 PM
// Design Name: 
// Module Name: ALU_pkg
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


package ALU_pkg;
    
    // logic [2 : 0] ALU_ADD = 3'b000;
    // logic [2 : 0] ALU_SUB = 3'b001;
    // logic [2 : 0] ALU_AND = 3'b010;
    // logic [2 : 0] ALU_OR  = 3'b011;
    // logic [2 : 0] ALU_SLT = 3'b101;

    // typedef enum logic [2 : 0] { ADD = 3'b000,
    //                              SUB = 3'b001,
    //                              AND = 3'b010,
    //                              OR  = 3'b011,
    //                              SLT = 3'b101 } ALUop;

    localparam ALU_ADD = 3'b000;
    localparam ALU_SUB = 3'b001;
    localparam ALU_AND = 3'b010;
    localparam ALU_OR  = 3'b011;
    localparam ALU_SLT = 3'b101;
endpackage
