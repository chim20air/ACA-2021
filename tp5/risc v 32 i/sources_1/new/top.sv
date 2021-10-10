`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2021 04:21:33 PM
// Design Name: 
// Module Name: top
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


module top(
        input logic clk, rst
    );

    logic          PCSrc, ResultSrc, ALUSrc, RegWrite;
    logic [ 2 : 0] ALUControl;
    logic [ 2 : 0] ImmSrc;
    logic [31 : 0] Instr, ReadData;
    logic          zero, MemWrite;
    logic [ 2 : 0] funct3;
    logic [ 6 : 0] opcode, funct7;
    logic [31 : 0] ProgramCounter, ALUResult, rd2;

    ControlUnit U_control(.*);

    DataPath D_Path(.*);

    InstructionMemory 
        Instrucciones(
                      .a(ProgramCounter),
                      .rd(Instr)
    );

    DataMemory ram(
                   .clk(clk),
                   .we(MemWrite),
                   .a(ALUResult),
                   .wd(rd2),
                   .rd(ReadData)
    );
endmodule