`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2021 07:18:18 PM
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

import digito_pkg::BCDnumber_t;
module top
    (
        input  logic         clk, rst, btn,
        output logic [7 : 0] sseg,
        output logic [5 : 0] AN
    );

    typedef enum logic { EARLY, LATE } debouncer_seletor_t;

    logic deb_to_flank;
    logic signal_from_flank_to_counter;
    logic signal_from_deboun_flank_to_counter;
    logic tick1ms;
    BCDnumber_t [1 : 0] debouncer_count;
    BCDnumber_t [1 : 0] flank_count;
    logic [4 : 0] output_selectora;
    
    // assign debouncer_count[0].digito = 4'b0;
    // assign debouncer_count[0].dp = 1'b0;
    // assign debouncer_count[1] = debouncer_count[0];
    // assign flank_count[0] = debouncer_count[0];
    // assign flank_count[1] = debouncer_count[0];

    debouncer #(
                .select(LATE)
               )
               antirrebote (
                            .i_signal(btn),
                            .clk(clk),
                            .rst(rst),
                            .o_out(deb_to_flank)
                           );

    flank_detector
        detectorFlancoAntirr(
                             .i_signal(deb_to_flank),
                             .clk(clk),
                             .rst(rst),
                             .o_out(signal_from_deboun_flank_to_counter)
                            );
    
    flank_detector
        detectorFlanco(
                       .i_signal(btn),
                       .clk(clk),
                       .rst(rst),
                       .o_out(signal_from_flank_to_counter)
                      );

    contador #(
                .DEC(2),
                .SUP_LIMITS('{9, 9}))
            debouncer_counter (
                               .clk(clk),
                               .rst(rst),
                               .tick(signal_from_deboun_flank_to_counter),
                               .sign(1'b1), //sign == 1 => SUP_LIMIT else INF_LIMIT
                               .digit(debouncer_count)
                              );
    
    contador #(
                .DEC(2),
                .SUP_LIMITS('{9, 9}))
            flank_counter (
                            .clk(clk),
                            .rst(rst),
                            .tick(signal_from_flank_to_counter),
                            .sign(1'b1), //sign == 1 => SUP_LIMIT else INF_LIMIT
                            .digit(flank_count)
                          );

    clk_divider #(
               //   .N(2),        //para simular
               //   .M(2))
                  .N(17),      //f=125MHz
                  .M(125_000))
                  pulsos1ms (
                              .clk(clk),
                              .rst(rst),
                              .tick(tick1ms));

    selector selector_digito (
                              .num({debouncer_count, flank_count}),
                              .clk(clk),
                              .tick(tick1ms),
                              .out_digit_select(AN),
                              .out_digit_number(output_selectora)
                             );
    
    BCD_to_sseg conversorBCD_7seg (
                                   .hex(output_selectora),
                                   .active_high(1'b0),
                                   .sseg(sseg)
                                  );
endmodule
