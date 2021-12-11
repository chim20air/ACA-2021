`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Adrian Evaraldo
// 
// Create Date: 09/26/2021 04:18:03 PM
// Design Name: 
// Module Name: ControlUnit
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

import Imm_pkg::*;
import ALU_pkg::*;
import PCsource_pkg::*;
import ALUsource_pkg::*;
import ALUSrcA_pkg::*;
import ResultSource_pkg::*;

module ControlUnit(
    input  logic          zero,
    input  logic [6 : 0]  opcode, funct7,
    input  logic [2 : 0]  funct3,
    output logic          MemWrite, RegWrite,
    output PCsource_t     PCSrc,
    output ALUsource_t    ALUSrc,
    output ALUSrcA_t      ALUSrcA,
    output ResultSource_t ResultSrc,
    output IMM_t          ImmSrc,
    output ALUop_t        ALUControl
    );

    always_comb begin
        PCSrc      = NEXT;
        ResultSrc  = RESULT_FROM_ALU;
        ALUSrc     = ALU_RD2;
        ALUSrcA    = FROM_REGFILE;
        ImmSrc     = IMM_TypeB;
        ALUControl = ALU_ADD;
        MemWrite   = 1'b0;
        RegWrite   = 1'b0;

        case (opcode)
            7'b011_0111: //LUI
                begin
                    ImmSrc     = IMM_TypeU;
                    ALUSrc     = ALU_EXTEND;
                    ALUControl = ALU_SrB;
                    RegWrite   = 1'b1;
                end
            
            7'b001_0111: //AUIPC
                begin
                    ImmSrc     = IMM_TypeU;
                    ALUSrc     = ALU_EXTEND;
                    ALUControl = ALU_ADD;
                    ALUSrcA    = FROM_PC;
                    RegWrite   = 1'b1;
                end
            
            7'b110_0111: //JALR
                begin
                    if(funct3 == 0) begin
                        ImmSrc     = IMM_TypeI;
                        PCSrc      = INDJ;
                        ResultSrc  = RESULT_FROM_PC4;
                        ALUSrc     = ALU_EXTEND;
                        ALUControl = ALU_ADD;
                        RegWrite   = 1'b1;
                    end
                end

            7'b110_1111: //JAL
                begin
                    ImmSrc    = IMM_TypeJ;
                    PCSrc     = JUMP;
                    ResultSrc = RESULT_FROM_PC4;
                    RegWrite  = 1'b1;
                end
            7'b110_0011:
                begin
                    ImmSrc = IMM_TypeB;
                    
                    case (funct3)
                        3'b000: //BEQ
                            begin
                                ALUControl = ALU_SUB;
                                if (zero) begin
                                    PCSrc = JUMP;
                                end
                            end
                        
                        3'b001: //BNE
                            begin
                                ALUControl = ALU_SUB;
                                if(~zero) begin
                                    PCSrc = JUMP;
                                end
                            end
                        
                        3'b100: //BLT
                            begin
                                ALUControl = ALU_SLT;
                                if (~zero) begin
                                    PCSrc = JUMP;
                                end
                            end
                        
                        3'b110: //BLTU
                            begin
                                ImmSrc     = IMM_TypeBu;
                                ALUControl = ALU_SLTU;
                                if (~zero) begin
                                    PCSrc = JUMP;
                                end
                            end
                        
                        3'b101: //BGE
                            begin
                                ALUControl = ALU_SLT;
                                if (zero) begin
                                    PCSrc = JUMP;
                                end
                            end
                        
                        3'b111: //BGEU
                            begin
                                ImmSrc     = IMM_TypeBu;
                                ALUControl = ALU_SLTU;
                                if (zero) begin
                                    PCSrc = JUMP;
                                end
                            end

                        default: 
                            begin
                                PCSrc = NEXT;
                            end
                    endcase

                end
            
            7'b000_0011:
                begin
                    ImmSrc = IMM_TypeI;

                    case (funct3)
                        3'b000, 3'b001, 3'b010, //LB, LH, LW
                        3'b100, 3'b101: //LBU, LHU
                            begin
                                ALUSrc    = ALU_EXTEND;
                                ResultSrc = RESULT_FROM_MEM;
                                RegWrite  = 1'b1;
                            end
                        default: 
                            begin
                                ResultSrc = RESULT_FROM_ALU;
                            end
                    endcase
                end
            
            7'b010_0011:
                begin
                    ImmSrc = IMM_TypeS;
                    case (funct3)
                        3'b000, 3'b001, 3'b010: //SB, SH, SW
                            begin
                                ALUSrc     = ALU_EXTEND;
                                ALUControl = ALU_ADD;
                                MemWrite   = 1'b1;
                            end

                        default:
                            begin
                                ALUSrc     = ALU_EXTEND;
                            end 
                    endcase
                end
            
            7'b001_0011:
                begin
                    ImmSrc    = IMM_TypeI;
                    ALUSrc    = ALU_EXTEND;
                    RegWrite  = 1'b1;
                    ResultSrc = RESULT_FROM_ALU;

                    case (funct3)
                        3'b000: //ADDI
                            begin
                                ALUControl = ALU_ADD;
                            end 
                        
                        3'b010: //SLTI
                            begin
                                ALUControl = ALU_SLT;
                            end
                        
                        3'b011: //SLTIU
                            begin
                                ImmSrc     = IMM_TypeIu;
                                ALUControl = ALU_SLTU;
                            end

                        3'b100: //XORI
                            begin
                                ALUControl = ALU_XOR;
                            end 
                        
                        3'b110: //ORI
                            begin
                                ALUControl = ALU_OR;
                            end
                        
                        3'b111: //ANDI
                            begin
                                ALUControl = ALU_AND;
                            end
                        
                        3'b001: //SLLI
                            begin
                                ALUControl = ALU_SLL;
                            end

                        3'b101: //SRLI, SRAI
                            if (funct7 == '0) begin
                                ALUControl = ALU_SRL;
                            end
                            else begin
                                ALUControl = ALU_SRA;
                            end

                        default: 
                            RegWrite = 1'b0;
                    endcase
                end

            7'b011_0011:
                begin
                    ResultSrc = RESULT_FROM_ALU;
                    ALUSrc    = ALU_RD2;
                    RegWrite  = 1'b1;

                    case ({funct7, funct3})
                        10'b000_0000_000: //ADD
                            begin
                                ALUControl = ALU_ADD;
                            end
                        
                        10'b010_0000_000: //SUB
                            begin
                                ALUControl = ALU_SUB;
                            end
                        
                        10'b000_0000_001: //SLL
                            begin
                                ALUControl = ALU_SLL;
                            end

                        10'b000_0000_010: //SLT
                            begin
                                ALUControl = ALU_SLT;
                            end
                        
                        10'b000_0000_011: //SLTU
                            begin
                                ALUControl = ALU_SLTU;
                            end

                        10'b000_0000_100: //XOR
                            begin
                                ALUControl = ALU_XOR;
                            end
                        
                        10'b000_0000_101: //SRL
                            begin
                                ALUControl = ALU_SRL;
                            end
                        
                        10'b010_0000_101: //SRA
                            begin
                                ALUControl = ALU_SRA;
                            end

                        10'b000_0000_110: //OR
                            begin
                                ALUControl = ALU_OR;
                            end
                        
                        10'b000_0000_111: //AND
                            begin
                                ALUControl = ALU_AND;
                            end

                        default: 
                            begin
                                RegWrite = 1'b0;
                            end
                    endcase
                end
            default: 
                begin
                    PCSrc      = NEXT;
                    ResultSrc  = RESULT_FROM_ALU;
                    ALUSrc     = ALU_RD2;
                    ImmSrc     = IMM_TypeB;
                    ALUControl = ALU_ADD;
                    MemWrite   = 1'b0;
                    RegWrite   = 1'b0;
                end
        endcase
    end
    
endmodule
