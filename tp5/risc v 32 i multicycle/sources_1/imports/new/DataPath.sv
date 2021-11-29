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

// import PCsource_pkg::*;
// import ALUsource_pkg::*;
// import ALUSrcA_pkg::*;
// import ResultSource_pkg::*;
import DataTypes_pkg::*;

module DataPath(
        input  logic          clk, rst, RegWrite, IRWrite, PCWrite,
        input  AdrSrc_t       AdrSrc,
        // input  PCsource_t     PCSrc,
        input  ALUsource_t    ALUSrc,
        input  ALUSrcA_t      ALUSrcA,
        input  ResultSource_t ResultSrc,
        input  ALUop_t        ALUControl, 
        input  IMM_t          ImmSrc,
        input  logic [31 : 0] ReadData,
        output logic          zero, 
        output logic [ 2 : 0] funct3,
        output logic [ 6 : 0] opcode, funct7,
        output logic [31 : 0] Adr, WriteData
    );

    /////////////////////////////////////////////////////////////////
    //
    // Signals declaration
    //
    /////////////////////////////////////////////////////////////////

    logic [31 : 0] ProgramCounter_Next, rd1, rd2, i_ALU_SrcA;
    logic [31 : 0] i_ALU_SrcB, ProgramCounter;
    logic [31 : 0] PCmas4, PCtarget;
    logic [31 : 0] o_extend, Result_to_RegMem;
    logic [31 : 0] ALUResult, ALUOut;
    logic [ 4 : 0] i_a1, i_a2, i_a3;

    logic [31 : 0] Instr, OldPC, Data;

    logic [31 : 0] rd1_reg, rd2_reg;

    /////////////////////////////////////////////////////////////////
    //
    // PC Signals
    //
    /////////////////////////////////////////////////////////////////

    PC ProgCount(
                 .PC_next(Result_to_RegMem),
                 .clk(clk),
                 .rst(rst),
                 .PCWrite(PCWrite),
                 .PC_out(ProgramCounter)
    );


    assign Adr = (AdrSrc == PC) ? ProgramCounter : Result_to_RegMem;

    PC_IR_reg PC_IR_register(
                             .clk(clk),
                             .IRWrite(IRWrite),
                             .PC(ProgramCounter),
                             .in_Instr(ReadData),
                             .OldPC(OldPC),
                             .out_Instr(Instr)
    );

    Data_reg data(
                  .clk(clk),
                  .ReadData(ReadData),
                  .Data(Data)
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

    Out_reg_file Out_reg(
                         .clk(clk),
                         .rd1_in(rd1),
                         .rd2_in(rd2),
                         .rd1_out(rd1_reg),
                         .rd2_out(rd2_reg)
    );

    assign WriteData = rd2_reg;

    /////////////////////////////////////////////////////////////////
    //
    // ALU
    //
    /////////////////////////////////////////////////////////////////

    always_comb begin : SourceA
        case(ALUSrcA)
            ALU_PC:
                begin
                    i_ALU_SrcA = ProgramCounter;
                end
            
            ALU_OLD_PC:
                begin
                    i_ALU_SrcA = OldPC;
                end
            
            ALU_RD1:
                begin
                    i_ALU_SrcA = rd1_reg;
                end
            
            default:
                begin
                    i_ALU_SrcA = rd1_reg;
                end
        endcase
    end

    always_comb begin : SourceB
        case(ALUSrc)
            ALU_RD2:
                begin
                    i_ALU_SrcB = rd2_reg;
                end

            ALU_EXTEND:
                begin
                    i_ALU_SrcB = o_extend;
                end

            ALU_PLUS_4:
                begin
                    i_ALU_SrcB = 32'h0000_0001;
                end
            
            default:
                begin
                    i_ALU_SrcB = rd2_reg;
                end
        endcase
    end

    ALU arithmetic(
                   .SrcA(i_ALU_SrcA),
                   .SrcB(i_ALU_SrcB),
                   .ALUControl(ALUControl),
                   .Zero(zero),
                   .ALUResult(ALUResult)
    );

    always_ff @( posedge clk ) begin : ALUOutReg
        ALUOut <= ALUResult;
    end

    always_comb begin : Mux_que_escribe_reg_file
        case (ResultSrc)
            RESULT_FROM_ALU:
                Result_to_RegMem = ALUOut;
            
            RESULT_FROM_MEM:
                Result_to_RegMem = Data;
            
            RESULT_FROM_PC4:
                Result_to_RegMem = ALUResult;
                
            default: 
                Result_to_RegMem = ALUOut;
        endcase
    end

endmodule
