`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Adrian Evaraldo
// 
// Create Date: 10/30/2021 05:38:46 PM
// Design Name: 
// Module Name: Data_reg
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


module Data_reg(
    input  logic        clk,
    input  logic [31:0] ReadData,
    output logic [31:0] Data
    );

    always_ff @( posedge clk ) begin
        Data <= ReadData;
    end
    
endmodule
