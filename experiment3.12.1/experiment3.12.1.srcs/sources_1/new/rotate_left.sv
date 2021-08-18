`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2021 08:32:25 PM
// Design Name: 
// Module Name: rotate_left
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


module rotate_left(
    input  logic [7 : 0] in,
    input  logic [2 : 0] amt,
    output logic [7 : 0] out
    );

    assign out = {in, in} << amt;
endmodule