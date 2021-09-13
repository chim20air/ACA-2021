`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2021 06:47:20 PM
// Design Name: 
// Module Name: debouncer
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

typedef enum logic { EARLY, LATE } debouncer_seletor_t;

module debouncer #(
        parameter select = EARLY
    )
    (
    input logic i_signal, clk, rst,
    output logic o_out
    );

    
    
    logic tick10ms;

    clk_divider #(
                  .N(2),        //para simular
                  .M(3))
                //   .N(21),        //f=125MHz
                //   .M(1_250_000))
                  pulsos10ms (
                              .clk(clk),
                              .rst(rst),
                              .tick(tick10ms));

    generate
        if(select == EARLY) begin
            debouncer_early debounce (
                                      .clk(clk),
                                      .rst(rst),
                                      .i_signal(i_signal),
                                      .i_tick10ms(tick10ms),
                                      .o_out(o_out)
                                     );
        end
        else begin
            if (select == LATE) begin
                debouncer_late debounce (
                                         .clk(clk),
                                         .rst(rst),
                                         .i_signal(i_signal),
                                         .i_tick10ms(tick10ms),
                                         .o_out(o_out)
                                        );
            end
        end
    endgenerate
endmodule
