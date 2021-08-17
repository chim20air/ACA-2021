`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2021 09:22:28 PM
// Design Name: 
// Module Name: MUX_2_to_1_8bit
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


module MUX_2_to_1_8bit(
    input  logic [7:0] a,b,
    input  logic sel,
    output logic [7:0] out
    );

    assign out = (sel == 1'b1) ? a : b;
endmodule
