`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Adrian Evaraldo
// 
// Create Date: 09/26/2021 04:18:03 PM
// Design Name: 
// Module Name: InstructionMemory
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


module InstructionMemory(
    input  logic [31 : 0] a,
    output logic [31 : 0] rd
    );

    logic [31 : 0] ROM [64];

    initial begin
        $readmemh("base_programm.mem", ROM);
    end

    assign rd = ROM[ a[31 : 2] ];
endmodule
