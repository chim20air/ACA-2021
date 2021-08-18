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
    input  logic [7 : 0] sw,
    input  logic [2 : 0] amt,
    input  logic sel,
    output logic [7 : 0] led
    );
    
    //paso 1
//    logic [7:0] out_rrl, out_rrr;
    
//    rotate_left 	rrl (.in(sw), .amt(amt), .out(out_rrl));
//    rotate_right	rrr (.in(sw), .amt(amt), .out(out_rrr));
    
//    MUX_2_to_1_8bit	out_rotate (.a(out_rrl),
//    							.b(out_rrr),
//    							.sel(sel),
//    							.out(led));
	
	//con el rotate
	logic [7:0] out_pre, out_rrr_rev, out_pos, out_rrr;
	
	//Rotate left
	bit8_reverse preReversing (.in(sw), .out(out_pre));
	rotate_right rrrReverse (.in(out_pre), .amt(amt), .out(out_rrr_rev));
	bit8_reverse posReversing (.in(out_rrr_rev), .out(out_pos));
	
	//rotate right
	rotate_right	rrr (.in(sw), .amt(amt), .out(out_rrr));
	
	MUX_2_to_1_8bit	out_rotate (.a(out_pos),
    							.b(out_rrr),
    							.sel(sel),
    							.out(led));
endmodule
