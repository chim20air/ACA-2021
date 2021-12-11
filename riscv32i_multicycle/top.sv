`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Adrian Evaraldo
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

module top
    import DataTypes_pkg::*;
    (
        input logic clk, rst
    );

    logic          RegWrite, IRWrite, PCWrite;
    AdrSrc_t       AdrSrc;
    // PCsource_t     PCSrc;
    ALUsource_t    ALUSrc;
    ALUSrcA_t      ALUSrcA;
    ResultSource_t ResultSrc;
    ALUop_t        ALUControl;
    IMM_t          ImmSrc;
    logic [31 : 0] ReadData;
    logic          zero, MemWrite;
    logic [ 2 : 0] funct3;
    logic [ 6 : 0] opcode, funct7;
    logic [31 : 0] Adr, WriteData;

    ControlUnit U_control(.*);

    DataPath D_Path(.*);


    ///////////////////////////////////////////////////////////////////////////
    // Uniciclo
    ///////////////////////////////////////////////////////////////////////////

    // InstructionMemory 
    //     Instrucciones(
    //                   .a(ProgramCounter),
    //                   .rd(Instr)
    // );

    // DataMemory ram(
    //                .clk(clk),
    //                .we(MemWrite),
    //                .a(ALUResult),
    //                .wd(rd2),
    //                .rd(ReadData)
    // );

    ///////////////////////////////////////////////////////////////////////////
    // Multiciclo
    ///////////////////////////////////////////////////////////////////////////

    InstrDataMem memoria(
                         .clk(clk),
                         .we(MemWrite),
                         .a(Adr),
                         .wd(WriteData),
                         .rd(ReadData)
    );
endmodule
