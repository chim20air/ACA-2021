`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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
    input  logic [ 2 : 0] ALUControl,
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
    assign ALUResult = (ALUControl == ALU_SLT) ? { { 31{1'b0} } , auxALU[31] } : auxALU;

    ALUbase BaseOps(
            .SrcA(SrcA),
            .SrcB(SrcB),
            .ALUControl(ALUControl[1 : 0]),
            .ALUResult(auxALU)
    );

    // always_comb begin
    //     case (ALUControl)
    //         3'b000: //SUM
    //             begin
    //                 auxALU = SrcA + SrcB;
    //             end
            
    //         3'b001, 3'b101: //SUB and SLT use substract
    //             begin
    //                 auxALU = SrcA - SrcB;
    //             end
            
    //         3'b010: //AND
    //             begin
    //                 auxALU = SrcA & SrcB;
    //             end
            
    //         3'b011: //OR
    //             begin
    //                 auxALU = SrcA | SrcB;
    //             end

    //         default: 
    //             begin
    //                 auxALU = '0;
    //             end
    //     endcase
    // end

    // always_comb begin
    //     case (ALUControl)
    //         3'b101: //SLT
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
