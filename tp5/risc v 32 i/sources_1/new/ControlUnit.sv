`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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
import ResultSource_pkg::*;

module ControlUnit(
    input  logic         zero,
    input  logic [6 : 0] opcode, funct7,
    input  logic [2 : 0] funct3,
    output logic         PCSrc, MemWrite, ALUSrc, RegWrite,
    output logic [1 : 0] ResultSrc,
    output logic [2 : 0] ImmSrc,
    output logic [2 : 0] ALUControl
    );

    always_comb begin
        PCSrc      = NEXT;
        ResultSrc  = RESULT_FROM_ALU;
        ALUSrc     = ALU_RD2;
        ImmSrc     = IMM_TypeB;
        ALUControl = ALU_ADD;
        MemWrite   = 1'b0;
        RegWrite   = 1'b0;

        case (opcode)
            7'b110_1111: //JAL
                begin
                    if(funct3 == 0) begin
                        ImmSrc    = IMM_TypeJ;
                        PCSrc     = JUMP;
                        ResultSrc = RESULT_FROM_PC4;
                        RegWrite  = 1'b1;
                    end                    
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
                        3'b010: //LW
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
                        3'b010: //SW
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
                    ImmSrc = IMM_TypeI; //guarda que no todas son type I
                    ALUSrc = ALU_EXTEND;
                    case (funct3)
                        3'b000: //ADDI
                            begin
                                ALUControl = ALU_ADD;
                                ResultSrc  = RESULT_FROM_ALU;
                                RegWrite   = 1'b1;
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
                        
                        10'b000_0000_010: //SLT
                            begin
                                ALUControl = ALU_SLT;
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
