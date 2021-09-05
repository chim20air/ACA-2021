`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/25/2021 07:12:19 PM
// Design Name: 
// Module Name: clkEn
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


module clkEn
    #(
        parameter N = 20,
        parameter M = 1_000_000
    )
    (
        input  logic clk, rst,
        output logic tick
    );

    logic [N - 1 : 0] count_reg;

    always_ff @( posedge clk, posedge rst ) begin 
        if(rst) begin
            count_reg <= '0;
        end
        else begin
            count_reg <= (count_reg == M - 1) ? '0 : count_reg + 1;
        end
    end

    always_comb begin
        tick = (count_reg == M - 1);
    end
endmodule
