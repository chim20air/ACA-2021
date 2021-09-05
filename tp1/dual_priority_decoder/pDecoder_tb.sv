`timescale 1ns/100ps
module pDecoder_tb (
);
    logic [3 : 0] in;
    logic [1 : 0] dir_a, dir_b;
    logic         en_a, en_b;

    p_nDecoder #(.N(4)) uut (.*);

    initial begin
        in = 4'b0;
        #20;
        for(in = 0; in < 16; in = in + 1) begin
           #20;
        end
    end
endmodule