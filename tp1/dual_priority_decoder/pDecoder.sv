`timescale 1ns/100ps
module p_nDecoder
    #(parameter N = 8)
    (
        input  logic [N - 1 : 0]         in,
        output logic [$clog2(N) - 1 : 0] dir_a, dir_b,
        output logic                     en_a, en_b
    );

    localparam W = $clog2(N);

    always_comb begin
        {dir_a, en_a} = { {W {1'bx}}, 1'b0};
        {dir_b, en_b} = { {W {1'bx}}, 1'b0};

        for(int i = N-1; i >= 0; i--) begin
            if(in[i] == 1'b1) begin
                if(~en_a) begin
                    dir_a = W'(i);
                    en_a = 1'b1;
                end
                else begin
                    dir_b = W'(i);
                    en_b = 1'b1;
                    break;
                end
            end
        end
    end
    
endmodule