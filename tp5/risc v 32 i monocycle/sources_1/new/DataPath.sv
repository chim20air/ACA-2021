`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2021 08:09:22 PM
// Design Name: 
// Module Name: DataPath
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

import PCsource_pkg::*;
import ALUsource_pkg::*;
import ALUSrcA_pkg::*;
import ResultSource_pkg::*;

module DataPath(
        input  logic          clk, rst, RegWrite,
        input  PCsource_t     PCSrc,
        input  ALUsource_t    ALUSrc,
        input  ALUSrcA_t      ALUSrcA,
        input  ResultSource_t ResultSrc,
        input  ALUop_t        ALUControl, 
        input  IMM_t          ImmSrc,
        input  logic [31 : 0] Instr, ReadData,
        output logic          zero,
        output logic [ 2 : 0] funct3,
        output logic [ 6 : 0] opcode, funct7,
        output logic [31 : 0] ProgramCounter, ALUResult, rd2
    );

    /////////////////////////////////////////////////////////////////
    //
    // Signals declaration
    //
    /////////////////////////////////////////////////////////////////

    logic [31 : 0] ProgramCounter_Next, rd1, i_ALU_SrcA, i_ALU_SrcB;
    logic [31 : 0] PCmas4, PCtarget;
    logic [31 : 0] o_extend, Result_to_RegMem;
    logic [ 4 : 0] i_a1, i_a2, i_a3;

    /////////////////////////////////////////////////////////////////
    //
    // PC Signals
    //
    /////////////////////////////////////////////////////////////////

    assign PCmas4 = ProgramCounter + 32'h0000_0004;
    assign PCtarget = ProgramCounter + o_extend;

    // assign ProgramCounter_Next = (PCSrc == JUMP) ? PCtarget : PCmas4;
    always_comb begin : SaltoPC
        case (PCSrc)
            NEXT: ProgramCounter_Next = PCmas4;
            JUMP: ProgramCounter_Next = PCtarget;
            INDJ: ProgramCounter_Next = ALUResult;
            default: 
                ProgramCounter_Next = PCmas4;
        endcase
    end

    PC ProgCount(
                 .PC_next(ProgramCounter_Next),
                 .clk(clk),
                 .rst(rst),
                 .PC_out(ProgramCounter)
    );


    /////////////////////////////////////////////////////////////////
    //
    // Instruction Decoding
    //
    /////////////////////////////////////////////////////////////////


    assign opcode = Instr[ 6 :  0];
    assign funct3 = Instr[14 : 12];
    assign funct7 = Instr[31 : 25];
    assign i_a1   = Instr[19 : 15];
    assign i_a2   = Instr[24 : 20];
    assign i_a3   = Instr[11 :  7];

    /////////////////////////////////////////////////////////////////
    //
    // Fetching Registers
    //
    /////////////////////////////////////////////////////////////////


    RegisterFile RegFile(
                         .clk(clk),
                         .a1(i_a1),
                         .a2(i_a2),
                         .a3(i_a3),
                         .we3(RegWrite),
                         .wd3(Result_to_RegMem),
                         .rd1(rd1),
                         .rd2(rd2)
    );

    Extend extensor(
                    .ImmSrc(ImmSrc),
                    .in(Instr),
                    .out(o_extend)
    );

    /////////////////////////////////////////////////////////////////
    //
    // ALU
    //
    /////////////////////////////////////////////////////////////////

    assign i_ALU_SrcA = (ALUSrcA == FROM_PC) ? ProgramCounter : rd1;

    assign i_ALU_SrcB = (ALUSrc == ALU_RD2) ? rd2 : o_extend;

    ALU arithmetic(
                   .SrcA(i_ALU_SrcA),
                   .SrcB(i_ALU_SrcB),
                   .ALUControl(ALUControl),
                   .Zero(zero),
                   .ALUResult(ALUResult)
    );

    always_comb begin : Mux_que_escribe_reg_file
        case (ResultSrc)
            RESULT_FROM_ALU:
                Result_to_RegMem = ALUResult;
            
            RESULT_FROM_MEM:
                Result_to_RegMem = ReadData;
            
            RESULT_FROM_PC4:
                Result_to_RegMem = PCmas4;
                
            default: 
                Result_to_RegMem = ALUResult;
        endcase
    end

    // assign Result_to_RegMem = (ResultSrc == RESULT_FROM_MEM) ? ReadData : ALUResult;

endmodule
