`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Adrian Evaraldo
// 
// Create Date: 08/05/2021 02:43:27 PM
// Design Name: 
// Module Name: deco2_to_4
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


module deco2_to_4(
    input  logic [1:0] a,
    input  logic en,
    output logic [3:0]out
    );

    assign out[0] = ~a[1] & ~a[0] & en;
    assign out[1] = ~a[1] &  a[0] & en;
    assign out[2] =  a[1] & ~a[0] & en;
    assign out[3] =  a[1] &  a[0] & en;

endmodule
