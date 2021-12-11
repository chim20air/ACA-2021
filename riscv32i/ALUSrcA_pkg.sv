`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Adrian Evaraldo
// 
// Create Date: 10/14/2021 03:04:54 PM
// Design Name: 
// Module Name: ALUSrcA_pkg
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


package ALUSrcA_pkg;
    typedef enum logic { FROM_REGFILE = 1'b0,
                         FROM_PC      = 1'b1 } ALUSrcA_t;
endpackage
