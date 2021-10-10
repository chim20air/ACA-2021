`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2021 10:46:00 PM
// Design Name: 
// Module Name: fibonacci
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


module fibonacci(
    input  logic [3 : 0] n_in,
    input  logic         clk, rst, start,
    output logic         done, ready,
    output logic [9 : 0] out
    );

    logic [9 : 0] fib_prev_reg, fib_prev_next;
    logic [9 : 0] fib_reg, fib_next;
    logic [3 : 0] n_reg;
    logic en, eq_0;

    typedef enum logic [1 : 0] { IDLE, BUSY, DONE } state_t;

    state_t state_reg, state_next;

    always_ff @( posedge clk ) begin
        if(rst) begin
            {fib_prev_reg, fib_reg} <= {10'h0, 10'h001};
            n_reg <= n_in;
            state_reg <= IDLE;
        end
        else begin
            fib_prev_reg <= fib_prev_next;
            fib_reg      <= fib_next;
            state_reg    <= state_next;
        end
    end

    always_comb begin
        case (state_reg)
            IDLE: 
                begin
                    
                end
            default: 
        endcase
    end
endmodule
