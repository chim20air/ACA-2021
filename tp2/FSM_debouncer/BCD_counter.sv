`timescale 1ns / 100ps

module BCD_counter
    #(
        parameter INF_LIMIT = 4'h0,
        parameter SUP_LIMIT = 4'h9
    )
    (
        input  logic         clk, rst, tick, sign, //sign == 1 => SUP_LIMIT else INF_LIMIT
        output logic [3 : 0] digit,
        output logic         overflow
    );
    
    logic [3 : 0] state_reg;
    logic overflow_reg;
    logic counter_aux;
    // logic [3 : 0] limit;

    always_ff @( posedge clk, posedge rst ) begin
        if(rst) begin
            digit       <= INF_LIMIT;
            state_reg   <= INF_LIMIT;
            overflow    <= 1'b0;
            counter_aux <= 1'b0;
        end
        else begin

            if(tick && ~counter_aux) begin

                state_reg   <= digit;

                overflow    <= overflow_reg;

                if(sign) begin
                    digit <= (digit == SUP_LIMIT) ? INF_LIMIT : digit + 4'h1;
                end
                else begin
                    digit <= (digit == INF_LIMIT) ? SUP_LIMIT : digit - 4'h1;
                end

                counter_aux <= 1'b1;
            end
            else begin
                if(~tick) begin
                    counter_aux <= 1'b0;
                end
            end
        end
    end

    always_comb begin
        // limit = sign ? SUP_LIMIT : INF_LIMIT;
        // overflow = (digit == limit);
        if (digit == SUP_LIMIT && state_reg == (SUP_LIMIT - 4'h1)
            ||  digit == INF_LIMIT && state_reg == (INF_LIMIT + 4'h1)) begin
                overflow_reg = 1'b1;
            end
            else begin
                overflow_reg = 1'b0;
            end
    end
endmodule
