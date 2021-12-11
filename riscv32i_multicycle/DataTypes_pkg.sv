`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Adrian Evaraldo
// 
// Create Date: 10/30/2021 05:56:30 PM
// Design Name: 
// Module Name: DataTypes_pkg
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

package DataTypes_pkg;

    typedef enum logic [1 : 0] { NEXT,                  //siguiente instruccion
                                 JUMP,                  //salto
                                 INDJ } PCsource_t;     //para el JALR salto indirecto (que parto de un registro)

    typedef enum logic { PC,
                         ALU } AdrSrc_t;

    typedef enum logic [2 : 0] { IMM_TypeI,
                                 IMM_TypeIu,
                                 IMM_TypeS,
                                 IMM_TypeB,
                                 IMM_TypeBu,
                                 IMM_TypeU,
                                 IMM_TypeJ } IMM_t;

    typedef enum logic [1 : 0] { ALU_RD1,
                                 ALU_OLD_PC,
                                 ALU_PC } ALUSrcA_t;
    
    typedef enum logic [1 : 0] { ALU_RD2,
                                 ALU_EXTEND,
                                 ALU_PLUS_4 } ALUsource_t;
    
    typedef enum logic [3 : 0] { ALU_ADD,
                                 ALU_SUB,
                                 ALU_AND,
                                 ALU_OR ,
                                 ALU_SLT,
                                 ALU_SLTU,
                                 ALU_SrB,
                                 ALU_XOR,
                                 ALU_SLL,
                                 ALU_SRL,
                                 ALU_SRA } ALUop_t;

    typedef enum logic [1 : 0] { RESULT_FROM_ALU = 2'b00,
                                 RESULT_FROM_MEM = 2'b01,
                                 RESULT_FROM_PC4 = 2'b10 } ResultSource_t;
    
    

endpackage

