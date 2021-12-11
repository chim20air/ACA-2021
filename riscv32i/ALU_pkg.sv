`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Adrian Evaraldo
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

    typedef enum logic [3 : 0] { ALU_ADD,
                                 ALU_SUB,
                                 ALU_AND,
                                 ALU_OR ,
                                 ALU_SLT,
                                 ALU_SLTU,
                                 ALU_SrB,
                                 ALU_XOR,
                                 ALU_SLL,
                                 ALU_SRL,
                                 ALU_SRA } ALUop_t;

    // localparam ALU_ADD = 3'b000;
    // localparam ALU_SUB = 3'b001;
    // localparam ALU_AND = 3'b010;
    // localparam ALU_OR  = 3'b011;
    // localparam ALU_SLT = 3'b101;
    // localparam ALU_SrB = 3'b110;
endpackage
