`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2021 05:38:46 PM
// Design Name: 
// Module Name: PC_IR_reg
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


module PC_IR_reg(
    input  logic        clk, IRWrite,
    input  logic [31:0] PC, in_Instr,
    output logic [31:0] OldPC, out_Instr
    );

    always_ff @( posedge clk ) begin
        if (IRWrite) begin
            out_Instr <= in_Instr;
        end
        OldPC <= PC;
    end

endmodule
