`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Adrian Evaraldo
//
// Create Date: 09/26/2021 04:18:03 PM
// Design Name:
// Module Name: RegisterFile
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


module RegisterFile(
    input  logic        clk,
    input  logic [ 4:0] a1, a2, a3,
    input  logic        we3,
    input  logic [31:0] wd3,
    output logic [31:0] rd1, rd2
    );

    logic [31 : 0] REGISTER [32];

//    assign REGISTER[0] = '0;
    // initial begin
    //     REGISTER[5] = 32'h00000006;
    //     REGISTER[9] = 32'h00000004;
    // end

    always_ff @( posedge clk ) begin
        if (we3 && a3 != '0) begin
            REGISTER[a3] <= wd3;
        end
    end

//    assign rd1 = REGISTER[a1];
//    assign rd2 = REGISTER[a2];

    always_ff @(posedge clk) begin
        if (a1 == '0) begin
            rd1 <= '0;
        end
        else begin
            rd1 <= REGISTER[a1];
        end

        if (a2 == '0) begin
            rd2 <= '0;
        end
        else begin
            rd2 <= REGISTER[a2];
        end
    end
endmodule
