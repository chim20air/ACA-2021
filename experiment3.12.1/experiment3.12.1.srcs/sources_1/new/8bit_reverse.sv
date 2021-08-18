`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/17/2021 08:52:59 PM
// Design Name: 
// Module Name: 8bit_reverse
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


module bit8_reverse(
    input [7:0] in,
    output [7:0] out
    );
    
    generate
    	genvar i;
    	
    	for(i = 0;i < 8; i++) begin
    		assign out[i] = in[7 - i];
    	end
    endgenerate
endmodule
