`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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
    input  logic        clk, rst, PCWrite,
    output logic [31:0] PC_out
    );

    always_ff @( posedge clk ) begin
        if (rst) begin
            PC_out <= 32'h0000_0020;
        end
        else begin
            if (PCWrite) begin
                PC_out <= PC_next;
            end
        end
    end

endmodule
