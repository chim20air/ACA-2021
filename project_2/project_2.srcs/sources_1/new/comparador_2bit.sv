`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/05/2021 02:09:48 PM
// Design Name: 
// Module Name: comparador_2bit
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


module comparador_2bit(
    input logic [1:0] a, b,
    output out
    );
    
    logic c_low, c_high;
    
    comparador comp_low (.a(a[0]), .b(b[0]), .out(c_low));
    comparador comp_high (.a(a[1]), .b(b[1]), .out(c_high));
    
    assign out = c_low & c_high;
    
endmodule
