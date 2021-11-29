`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2021 04:18:03 PM
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
    input  logic          clk, we,
    input  logic [31 : 0] a, wd,
    output logic [31 : 0] rd
    );

    logic [7 : 0] DATA_MEM [32][4];

    initial begin
        $readmemh("dataMemory.mem", DATA_MEM);
    end
    
    assign rd = DATA_MEM[ a[31 : 2] ][ a[1 : 0] ];

    always_ff @( posedge clk ) begin
        if (we) begin
            DATA_MEM[ a[31 : 2] ][ a[1 : 0] ] <= wd;
        end
    end
endmodule
