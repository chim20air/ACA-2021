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

// import Imm_pkg::*;
// import ALU_pkg::*;
// import PCsource_pkg::*;
// import ALUsource_pkg::*;
// import ALUSrcA_pkg::*;
// import ResultSource_pkg::*;
import DataTypes_pkg::*;

module ControlUnit(
    input  logic          zero, clk, rst,
    input  logic [6 : 0]  opcode, funct7,
    input  logic [2 : 0]  funct3,
    output logic          MemWrite, RegWrite, PCWrite, IRWrite,
    output AdrSrc_t       AdrSrc,
    // output PCsource_t     PCSrc,
    output ALUsource_t    ALUSrc,
    output ALUSrcA_t      ALUSrcA,
    output ResultSource_t ResultSrc,
    output IMM_t          ImmSrc,
    output ALUop_t        ALUControl
    );

    

    typedef enum logic [3 : 0] { FETCH,
                                 DECODE,
                                 EXEC_LS, //LOAD STORE
                                 EXEC_TR, //R-TYPE
                                 EXEC_TI, //I-TYPE
                                 EXEC_JA, //JAL
                                 EXEC_JR, //JALR
                                 EXEC_LU, //LUI
                                 EXEC_AU, //AUIPC
                                 EXEC_BR, //BREAK instructions
                                 MEM_RD,
                                 MEM_WR,
                                 ALU_WB,
                                 MEM_WB } micro_step_t;
    
    
    micro_step_t state_reg, state_next;

    always_ff @( posedge clk ) begin
        if (rst) begin
            state_reg <= FETCH;
        end
        else begin
            state_reg <= state_next;
        end
    end

    always_comb begin : ControlPath
        state_next = state_reg;
        case(state_reg)
            FETCH:
                begin
                    state_next = DECODE;
                end

            DECODE:
                casez({funct3, opcode})
                    10'b???_011_0111: //LUI
                        begin
                            state_next = EXEC_LU;
                        end

                    10'b???_001_0111: //AUIPC
                        begin
                            state_next = EXEC_AU;
                        end
                    
                    10'b???_110_1111: //JAL
                        begin
                            state_next = EXEC_JA;
                        end
                         
                    10'b???_110_0111: //JALR
                        begin
                            state_next = EXEC_JR;
                        end

                    10'b???_110_0011: //BREAK instruction
                        begin
                            state_next = EXEC_BR;
                        end
                    
                    10'b???_000_0011, 10'b???_010_0011: //LOAD or STORE instruction
                        begin
                            state_next = EXEC_LS;
                        end
                    
                    10'b???_011_0011, 10'b?01_001_0011: //R-TYPE instruction
                        begin
                            state_next = EXEC_TR;
                        end
                    
                    10'b?00_001_0011, 10'b?10_001_0011, 10'b?11_001_0011: //I-TYPE instruction
                        begin
                            state_next = EXEC_TI;
                        end
                endcase      
                                 
                                 
                                 
            EXEC_LS: //LOAD STORE
                begin
                    if (opcode == 7'b000_0011) begin //LOAD
                        state_next = MEM_RD;
                    end
                    else begin //STORE
                        state_next = MEM_WR;
                    end
                end

            EXEC_TR, EXEC_TI, EXEC_JA, EXEC_JR, EXEC_LU, EXEC_AU: //R-TYPE, I-TYPE, JAL, JALR, LUI, AUIPC
                begin
                    state_next = ALU_WB;
                end

            EXEC_BR: //BREAK instructions
                begin
                    state_next = FETCH;
                end

            MEM_RD:
                begin
                    state_next = MEM_WB;
                end

            MEM_WR, ALU_WB, MEM_WB:
                begin
                    state_next = FETCH;
                end
            
            default:
                begin
                    state_next = FETCH;
                end
        endcase

    end

    always_comb begin : DataPath
        ResultSrc  = RESULT_FROM_ALU;
        ALUControl = ALU_ADD;
        ALUSrcA    = ALU_RD1;
        ALUSrc     = ALU_RD2;
        ImmSrc     = IMM_TypeI;
        AdrSrc     = PC;
        MemWrite   = 1'b0;
        RegWrite   = 1'b0;
        PCWrite    = 1'b0;
        IRWrite    = 1'b0;

        case(state_reg)
            FETCH:
                begin
                    ResultSrc  = RESULT_FROM_PC4;
                    ALUSrcA    = ALU_PC;
                    ALUSrc     = ALU_PLUS_4;
                    ALUControl = ALU_ADD;
                    IRWrite    = 1'b1;
                    PCWrite    = 1'b1;
                end
                
            DECODE:
                begin
                    
                    // Calculate next PC in case of BRANCH
                    if (opcode == 7'b110_0011) begin
                        ResultSrc   = RESULT_FROM_PC4;
                        ALUSrcA     = ALU_OLD_PC;
                        ALUSrc      = ALU_EXTEND;
                        ALUControl  = ALU_ADD;
                        ImmSrc      = IMM_TypeB;
                    end
                end
                
            EXEC_LS: //LOAD STORE
                begin
                    ALUSrcA     = ALU_RD1;
                    ALUSrc      = ALU_EXTEND;
                    ALUControl  = ALU_ADD;
                    // AdrSrc      = ALU;

                    if(opcode == 7'b000_0011) begin
                        ImmSrc = IMM_TypeI;

                        case (funct3)
                            3'b000, 3'b001, 3'b010, //LB, LH, LW
                            3'b100, 3'b101: //LBU, LHU
                                begin
                                    ALUSrc    = ALU_EXTEND;
                                    ResultSrc = RESULT_FROM_MEM;
                                    // RegWrite  = 1'b1;
                                end
                            default: 
                                begin
                                    ResultSrc = RESULT_FROM_ALU;
                                end
                        endcase
                    end
                    else begin
                        ImmSrc = IMM_TypeS;
                        case (funct3)
                            3'b000, 3'b001, 3'b010: //SB, SH, SW
                                begin
                                    ALUSrc     = ALU_EXTEND;
                                    ALUControl = ALU_ADD;
                                    // MemWrite   = 1'b1;
                                end

                            default:
                                begin
                                    ALUSrc     = ALU_EXTEND;
                                end 
                        endcase
                    end
                end
                
            EXEC_TR: //R-TYPE
                begin
                    ALUSrcA = ALU_RD1;
                    ALUSrc  = ALU_RD2;

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
                
            EXEC_TI: //I-TYPE
                begin
                    ALUSrcA = ALU_RD1;
                    ALUSrc  = ALU_EXTEND;
                    ImmSrc  = IMM_TypeI;

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
                
            EXEC_JA: //JAL
                begin
                    ResultSrc   = RESULT_FROM_ALU;
                    ALUSrcA     = ALU_OLD_PC;
                    ALUSrc      = ALU_PLUS_4;
                    ALUControl  = ALU_ADD;
                    ImmSrc      = IMM_TypeJ;
                    PCWrite     = 1'b1;
                end
                
            EXEC_JR: //JALR
                begin
                    
                end
                
            EXEC_LU: //LUI
                begin
                    
                end
                
            EXEC_AU: //AUIPC
                begin
                    
                end
                
            EXEC_BR: //BREAK instructions
                begin
                    ResultSrc = RESULT_FROM_ALU;
                    ALUSrcA   = ALU_RD1;
                    ALUSrc    = ALU_RD2;
                    ImmSrc    = IMM_TypeB;
                    
                    
                    case (funct3)
                        3'b000: //BEQ
                            begin
                                ALUControl = ALU_SUB;
                                if (zero) begin
                                    PCWrite   = 1'b1;
                                end
                            end
                        
                        3'b001: //BNE
                            begin
                                ALUControl = ALU_SUB;
                                if(~zero) begin
                                    PCWrite   = 1'b1;
                                end
                            end
                        
                        3'b100: //BLT
                            begin
                                ALUControl = ALU_SLT;
                                if (~zero) begin
                                    PCWrite   = 1'b1;
                                end
                            end
                        
                        3'b110: //BLTU
                            begin
                                ImmSrc     = IMM_TypeBu;
                                ALUControl = ALU_SLTU;
                                if (~zero) begin
                                    PCWrite   = 1'b1;
                                end
                            end
                        
                        3'b101: //BGE
                            begin
                                ALUControl = ALU_SLT;
                                if (zero) begin
                                    PCWrite   = 1'b1;
                                end
                            end
                        
                        3'b111: //BGEU
                            begin
                                ImmSrc     = IMM_TypeBu;
                                ALUControl = ALU_SLTU;
                                if (zero) begin
                                    PCWrite   = 1'b1;
                                end
                            end

                        default: 
                            begin
                                PCWrite   = 1'b0;
                            end
                    endcase
                end
                
            MEM_RD:
                begin
                    ResultSrc = RESULT_FROM_ALU;
                    AdrSrc    = ALU;
                    // MemWrite  = 1'b1;
                end
                
            MEM_WR:
                begin
                    ResultSrc = RESULT_FROM_ALU;
                    AdrSrc    = ALU;
                    MemWrite   = 1'b1;
                end
                
            ALU_WB:
                begin
                    ResultSrc = RESULT_FROM_ALU;
                    AdrSrc    = ALU;
                    RegWrite  = 1'b1;
                end
                
            MEM_WB:
                begin
                    ResultSrc = RESULT_FROM_MEM;
                    RegWrite  = 1'b1;
                    AdrSrc    = ALU;
                end
                
        endcase
    end
    
endmodule
