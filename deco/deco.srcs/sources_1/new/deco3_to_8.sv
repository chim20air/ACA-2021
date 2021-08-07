`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/07/2021 04:44:47 PM
// Design Name: 
// Module Name: deco3_to_8
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


module deco3_to_8(
    input logic  [2:0] a,
    input logic 	   en,
    output logic [7:0] out
    );
    
    logic en_low, en_high;
    
    assign en_low  = en & ~a[2];
    assign en_high = en &  a[2];
    
    deco2_to_4 deco_low (.a(a[1:0]),
    					.en(en_low),
    					.out(out[3:0]));
    					
    deco2_to_4 deco_high(.a(a[1:0]),
    					.en(en_high),
    					.out(out[7:4]));
endmodule
