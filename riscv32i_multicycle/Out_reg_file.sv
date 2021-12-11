`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Adrian Evaraldo
// 
// Create Date: 10/30/2021 05:38:46 PM
// Design Name: 
// Module Name: Out_reg_file
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


module Out_reg_file(
    input  logic        clk,
    input  logic [31:0] rd1_in, rd2_in,
    output logic [31:0] rd1_out, rd2_out
    );

    always_ff @( posedge clk ) begin
        rd1_out <= rd1_in;
        rd2_out <= rd2_in;
    end
    
endmodule
