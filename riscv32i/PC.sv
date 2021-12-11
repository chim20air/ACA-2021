`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Adrian Evaraldo
// 
// Create Date: 09/26/2021 04:18:03 PM
// Design Name: 
// Module Name: PC
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


module PC(
    input  logic [31:0] PC_next,
    input  logic        clk, rst,
    output logic [31:0] PC_out
    );

    always_ff @( posedge clk ) begin
        if (rst) begin
            PC_out <= '0;
        end
        else begin
            PC_out <= PC_next;
        end
    end

endmodule
