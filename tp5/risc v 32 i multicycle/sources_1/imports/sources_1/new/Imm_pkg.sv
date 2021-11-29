`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2021 06:17:44 PM
// Design Name: 
// Module Name: Imm_pkg
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


package Imm_pkg;

    typedef enum logic [2 : 0] { IMM_TypeI,
                                 IMM_TypeIu,
                                 IMM_TypeS,
                                 IMM_TypeB,
                                 IMM_TypeBu,
                                 IMM_TypeU,
                                 IMM_TypeJ } IMM_t;

    // localparam IMM_TypeI = 3'b000;
    // localparam IMM_TypeS = 3'b001;
    // localparam IMM_TypeB = 3'b010;
    // localparam IMM_TypeU = 3'b011;
    // localparam IMM_TypeJ = 3'b100;

endpackage
