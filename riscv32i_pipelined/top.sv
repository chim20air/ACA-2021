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

    logic          RegWrite;
    PCsource_t     PCSrc;
    ALUsource_t    ALUSrc;
    ALUSrcA_t      ALUSrcA;
    ResultSource_t ResultSrc;
    ALUop_t        ALUControl;
    IMM_t          ImmSrc;
    logic [31 : 0] InstrF, ReadData;
    logic          MemWrite, MemWriteM, Jump, Branch, Indj, InvZero;
    logic [ 2 : 0] funct3;
    logic [ 6 : 0] opcode, funct7;
    logic [31 : 0] ProgramCounter, ALUResult, rd2;

    (* DONT_TOUCH = "true" *)
    ControlUnit U_control(.*);

    DataPath D_Path(
                    .clk(clk),
                    .rst(rst),
                    .RegWriteD(RegWrite),
                    .JumpD(Jump),
                    .BranchD(Branch),
                    .IndjD(Indj),
                    .InvZeroD(InvZero),
                    // .PCSrcD(PCSrc),
                    .ALUSrcD(ALUSrc),
                    .ALUSrcAD(ALUSrcA),
                    .ResultSrcD(ResultSrc),
                    .ALUControlD(ALUControl),
                    .ImmSrcD(ImmSrc),
                    .InstrF(InstrF),
                    .ReadDataM(ReadData),
                    .MemWriteD(MemWrite),
                    .MemWriteM(MemWriteM),
                    .funct3(funct3),
                    .opcode(opcode),
                    .funct7(funct7),
                    .ProgramCounterF(ProgramCounter),
                    .ALUResultM(ALUResult),
                    .rd2M(rd2)
    );

    InstructionMemory
        Instrucciones(
                      .a(ProgramCounter),
                      .rd(InstrF)
    );

    DataMemory ram(
                   .clk(clk),
                   .we(MemWriteM),
                   .a(ALUResult),
                   .wd(rd2),
                   .rd(ReadData)
    );
endmodule
