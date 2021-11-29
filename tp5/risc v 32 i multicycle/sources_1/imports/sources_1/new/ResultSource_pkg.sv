`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2021 10:29:17 PM
// Design Name: 
// Module Name: ResultSource_pkg
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


package ResultSource_pkg;
    
    // localparam RESULT_FROM_ALU = 2'b00;
    // localparam RESULT_FROM_MEM = 2'b01;
    // localparam RESULT_FROM_PC4 = 2'b10;
    
    typedef enum logic [1 : 0] { RESULT_FROM_ALU = 2'b00,
                                 RESULT_FROM_MEM = 2'b01,
                                 RESULT_FROM_PC4 = 2'b10 } ResultSource_t;
    
endpackage
