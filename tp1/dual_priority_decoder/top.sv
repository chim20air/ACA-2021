`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/25/2021 07:17:35 PM
// Design Name: 
// Module Name: top
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


module top(
        input  logic          CLK100MHZ, rst,
        input  logic [15 : 0] SW,
        output logic [7 : 0]  sseg,
        output logic [7 : 0]  sel
    );

    logic tick;
    logic [4 : 0] wire_dir_a, wire_dir_b, wire_selectora; //dp+number


    p_nDecoder #(.N(16)) IRQ (
                    .in(SW),
                    .dir_a(wire_dir_a[3 : 0]),
                    .dir_b(wire_dir_b[3 : 0]),
                    .en_a(wire_dir_a[4]),
                    .en_b(wire_dir_b[4])
                   );

    clkEn divisor_freq(
                       .clk(CLK100MHZ),
                       .rst(rst),
                       .tick(tick)
                      );
    
    select selector7seg(
                        .num1(wire_dir_a),
                        .num2(wire_dir_b),
                        .clk(CLK100MHZ),
                        .tick(tick),
                        .out_digit_select(sel),
                        .out_digit_number(wire_selectora)
                       );

    seg7 decoder_BCD_7seg(
                          .hex(wire_selectora[3 : 0]),
                          .dp(wire_selectora[4]),
                          .active_high(1'b0),
                          .sseg(sseg)
                          );

endmodule
