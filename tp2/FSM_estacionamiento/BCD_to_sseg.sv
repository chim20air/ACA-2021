`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2021 02:47:07 PM
// Design Name: 
// Module Name: BCD_to_sseg
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

module BCD_to_sseg
	import digito_pkg::BCDnumber_t;

    (
        input  BCDnumber_t   hex,
        input  logic         active_high,
        output logic [7 : 0] sseg
    );

    logic [7 : 0] code;

    always_comb begin
        case(hex.digito)       //gfe_dcba
            4'h0: code = {hex.dp, 7'b011_1111};
            4'h1: code = {hex.dp, 7'b000_0110};
            4'h2: code = {hex.dp, 7'b101_1011};
            4'h3: code = {hex.dp, 7'b100_1111};
            4'h4: code = {hex.dp, 7'b110_0110};
            4'h5: code = {hex.dp, 7'b110_1101};
            4'h6: code = {hex.dp, 7'b111_1101};
            4'h7: code = {hex.dp, 7'b000_0111};
            4'h8: code = {hex.dp, 7'b111_1111};
            4'h9: code = {hex.dp, 7'b110_0111};
            4'hA: code = {hex.dp, 7'b111_0111};
            4'hB: code = {hex.dp, 7'b111_1100};
            4'hC: code = {hex.dp, 7'b000_1111};
            4'hD: code = {hex.dp, 7'b101_1110};
            4'hE: code = {hex.dp, 7'b111_1001};
            default: code = {hex.dp, 7'b111_0001};
        endcase

        sseg = active_high ? code : ~code;
    end


    
endmodule
