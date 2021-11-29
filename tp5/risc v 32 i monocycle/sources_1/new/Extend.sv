`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2021 04:18:03 PM
// Design Name: 
// Module Name: Extend
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

module Extend(
    input  IMM_t ImmSrc,
    input  logic [31 : 0] in,
    output logic [31 : 0] out
    );

    // assign out = { {21{in[11]}} ,in[10 : 0]};

    always_comb begin
        case(ImmSrc)
            IMM_TypeI: //Type I
                begin
                    out = { { 20 {in[31]} } , in[31 : 20] };
                end
            
            IMM_TypeIu: //Type Iu
                begin
                    out = { { 20 {1'b0} } , in[31 : 20] };
                end

            IMM_TypeS: //Type S
                begin
                    out = { { 20 {in[31]} } , in[31 : 25] , in[11 : 7] };
                end
            
            IMM_TypeB: //Type B
                begin
                    out = { { 20 {in[31]} } , in[7] , in[30 : 25] , in[11 : 8], 1'b0 };
                end
            
            IMM_TypeBu: //Type Bu
                begin
                    out = { { 20 {1'b0} }, in[31] , in[7] , in[30 : 25] , in[11 : 8], 1'b0 };
                end

            IMM_TypeU: //Type U
                begin
                    out = { in[31 : 12] , { 12 {1'b0} } };
                end
            
            IMM_TypeJ: //Type J
                begin
                    out = { { 12 {in[31]} } , in[19 : 12] , in[20] , in[30 : 21], 1'b0 };
                end
            
            default:
                begin
                    out = '0;
                end
        endcase
    end

endmodule
