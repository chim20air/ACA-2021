`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2021 01:30:07 PM
// Design Name: 
// Module Name: ALUbase
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

module ALUbase(
    input  logic [31 : 0] SrcA, SrcB,
    input  ALUop_t        ALUControl,
    output logic [31 : 0] ALUResult
    );


    always_comb begin
        case (ALUControl[1 : 0])
            2'b00: //ADD
                begin
                    ALUResult = SrcA + SrcB;
                end
            
            2'b01: //SUB
                begin
                    ALUResult = SrcA - SrcB;
                end
            
            2'b10: //AND
                begin
                    ALUResult = SrcA & SrcB;
                end
            
            2'b11: //OR
                begin
                    ALUResult = SrcA | SrcB;
                end

            default: 
                begin
                    ALUResult = '0;
                end
        endcase
    end
endmodule
