`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/26/2021 03:16:40 PM
// Design Name: 
// Module Name: MUXdigit
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


module MUXdigit(
    input  logic [7:0] nro1,
    input  logic [7:0] nro2,
    input  logic [1:0] sel,
    output logic [7:0] digito
    );

    always_comb begin
        case (~sel)
            2'b01: digito = nro1;
            2'b10: digito = nro2;
            default: digito = 0;
        endcase
    end
endmodule
