`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Adrian Evaraldo
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

    logic [31 : 0] DATA_MEM [32];

    initial begin
        $readmemh("dataMemory.mem", DATA_MEM);
    end
    
    assign rd = DATA_MEM[ a[31 : 2] ];

    always_ff @( posedge clk ) begin
        if (we) begin
            DATA_MEM[ a[31 : 2] ] <= wd;
        end
    end
endmodule
