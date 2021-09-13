`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2021 01:32:23 PM
// Design Name: 
// Module Name: debouncer_late
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

module debouncer_late(
    input  logic clk, rst, i_signal, i_tick10ms,
    output logic o_out//,
    // output logic [3 : 0] state, state_n
    );

    typedef enum logic [3: 0] { IDLE_0, LISTEN_1_TICK0, LISTEN_1_TICK1, IDLE_1, LISTEN_0_TICK0, LISTEN_0_TICK1 } debounc_late_t;
    typedef enum logic { HIGH, LOW } salida_t;

    debounc_late_t state_reg, state_next;
    // salida_t aux_out_reg, aux_out_next;
    logic aux_out;

    // assign state = state_reg;
    // assign state_n = state_next;

    always_ff @( posedge clk, posedge rst ) begin
        if(rst) begin
            state_reg   <= IDLE_0;
            // aux_out_reg <= LOW;
        end
        else begin
            state_reg   <= state_next;
            // aux_out_reg <= aux_out_next;
        end
    end
    
    always_comb begin
        state_next = state_reg;
        casez (state_reg)
            IDLE_0:
                begin
                    if(i_signal) begin
                        state_next = LISTEN_1_TICK0;
                    end
                end

            LISTEN_1_TICK0:
                begin
                    if (~i_signal) begin
                        state_next = IDLE_0;
                    end
                    else begin
                       if(i_tick10ms) begin
                            state_next = LISTEN_1_TICK1;
                        end 
                    end
                end

            LISTEN_1_TICK1:
                begin
                    if (~i_signal) begin
                        state_next = IDLE_0;
                    end
                    else begin
                       if(i_tick10ms) begin
                            state_next = IDLE_1;
                        end 
                    end
                end

            IDLE_1:
                begin
                    if (~i_signal) begin
                        state_next = LISTEN_0_TICK0;
                    end
                end

            LISTEN_0_TICK0:
                begin
                    if (i_signal) begin
                        state_next = IDLE_1;
                    end
                    else begin
                       if(i_tick10ms) begin
                            state_next = LISTEN_0_TICK1;
                        end 
                    end
                end

            LISTEN_0_TICK1:
                begin
                    if (i_signal) begin
                        state_next = IDLE_1;
                    end
                    else begin
                       if(i_tick10ms) begin
                            state_next = IDLE_0;
                        end 
                    end
                end
                
            default: 
                state_next = IDLE_0;
        endcase
    end

    always_comb begin
        // aux_out_next = aux_out_reg;
        // case (aux_out_reg)
        //     LOW:
        //         begin
        //             if (state_reg == IDLE_1 ||
        //                 state_reg == LISTEN_0_TICK0 ||
        //                 state_reg == LISTEN_0_TICK1) begin
        //                     aux_out = 1'b1;
        //                     aux_out_next = HIGH;
        //             end
        //         end

        //     HIGH:
        //         begin
        //             if (state_reg == IDLE_0 ||
        //                 state_reg == LISTEN_1_TICK0 ||
        //                 state_reg == LISTEN_1_TICK1) begin
        //                     aux_out = 1'b0;
        //                     aux_out_next = LOW;
        //             end
        //         end
        //     default:
        //         begin
        //             aux_out_next = LOW;
        //             aux_out = 1'b0;
        //         end
        // endcase
        case (state_reg)
            IDLE_1, LISTEN_1_TICK0, LISTEN_1_TICK1:
                aux_out = 1'b1;
            IDLE_0, LISTEN_0_TICK0, LISTEN_0_TICK1:
                aux_out = 1'b0;
            default:
                aux_out = 1'b0;
        endcase
    end

    assign o_out = aux_out;

endmodule
