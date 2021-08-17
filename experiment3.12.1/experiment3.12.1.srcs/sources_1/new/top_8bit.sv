`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2021 09:25:11 PM
// Design Name: 
// Module Name: top_8bit
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


module top_8bit(
    input  logic [7:0] sw,
    input  logic sel,
    output logic [7:0] led
    );
    
    logic [7:0] out_rrl, out_rrr;
    
    rotate_left 	rrl (.in(sw), .out(out_rrl));
    rotate_right	rrr (.in(sw), .out(out_rrr));
    
    MUX_2_to_1_8bit	out_rotate (.a(out_rrl),
    							.b(out_rrr),
    							.sel(sel),
    							.out(led));
endmodule
