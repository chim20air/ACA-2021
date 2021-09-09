module FSMtoBCDcounter(
        input logic incr, decr,
        //input logic clk,
        output logic tick, sign
    );

    always_comb begin
        tick = 1'b0;
        sign = 1'b0;
        if(incr) begin
            tick = 1'b1;
            sign = 1'b1;
        end
        else begin
            if (decr) begin
                tick = 1'b1;
                sign = 1'b0;
            end
        end
    end
endmodule
