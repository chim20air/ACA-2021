`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Adrian Evaraldo
// 
// Create Date: 09/26/2021 04:18:03 PM
// Design Name: 
// Module Name: ALU
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

import ALU_pkg::*;

module ALU(
    input  logic [31 : 0] SrcA, SrcB,
    input  ALUop_t        ALUControl,
    output logic          Zero,
    output logic [31 : 0] ALUResult
    );

    logic [31 : 0] auxALU;
    // 000 Add
    // 001 Subtract
    // 010 AND
    // 011 OR
    // 101 SLT

    assign Zero = (ALUResult == '0) ? 1'b1 : 1'b0;
    assign ALUResult = auxALU;
    // assign ALUResult = (ALUControl == ALU_SLT) ? { { 31{1'b0} } , auxALU[31] } :
    //                    (ALUControl == ALU_SrB) ? SrcB : auxALU;

    // ALUbase BaseOps(
    //         .SrcA(SrcA),
    //         .SrcB(SrcB),
    //         .ALUControl(ALUControl),
    //         .ALUResult(auxALU)
    // );

    always_comb begin
        case (ALUControl)
            ALU_ADD: 
                begin
                    auxALU = SrcA + SrcB;
                end
            
            ALU_SUB: //SUB
                begin
                    auxALU = SrcA - SrcB;
                end
            
            ALU_SLTU:
                begin
                    auxALU = SrcA < SrcB;
                end

            ALU_SLT:
                begin
                    auxALU = signed'(SrcA) < signed'(SrcB);
                end
            
            ALU_AND: //AND
                begin
                    auxALU = SrcA & SrcB;
                end
            
            ALU_OR: //OR
                begin
                    auxALU = SrcA | SrcB;
                end
            
            ALU_SrB:
                begin
                    auxALU = SrcB;
                end
            
            ALU_XOR:
                begin
                    auxALU = SrcA ^ SrcB;
                end
            ALU_SLL:
                begin
                    auxALU = SrcA <<  SrcB[4 : 0];
                end
                
            ALU_SRL:
                begin
                    auxALU = SrcA >>  SrcB[4 : 0];
                end

            ALU_SRA:
                begin
                    auxALU = SrcA >>> SrcB[4 : 0];
                end

            default: 
                begin
                    auxALU = '0;
                end
        endcase
    end

    // always_comb begin
    //     case (ALUControl)
    //         ALU_SLT: 
    //             begin
    //                 ALUResult = { { 31{1'b0} } , auxALU[31] };
    //             end
    //         default: 
    //             begin
    //                 ALUResult = auxALU;
    //             end
    //     endcase
    // end
endmodule
