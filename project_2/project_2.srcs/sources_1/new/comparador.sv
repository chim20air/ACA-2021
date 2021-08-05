`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/05/2021 01:38:18 PM
// Design Name: 
// Module Name: comparador
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


module comparador(
    input logic a,
    input logic b,
    output logic out
    );

    logic comp1, comp2;

    assign comp1 = a & b;
    assign comp2 = ~a & ~b;

    assign out = comp1 | comp2;
endmodule
