`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Adrian Evaraldo
// 
// Create Date: 10/04/2021 10:24:37 PM
// Design Name: 
// Module Name: ALUsource_pkg
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


package ALUsource_pkg;
    
    // localparam ALU_RD2    = 1'b0;
    // localparam ALU_EXTEND = 1'b1;

    typedef enum logic { ALU_RD2    = 1'b0,
                         ALU_EXTEND = 1'b1 } ALUsource_t;

endpackage