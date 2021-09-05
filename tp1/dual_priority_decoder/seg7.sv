module seg7 (
    input  logic [3 : 0] hex,
    input  logic         dp,
    input  logic         active_high,
    output logic [7 : 0] sseg
    );

    logic [7 : 0] code;

    always_comb begin
        case(hex)              //gfe_dcba
            4'h0: code = {dp, 7'b011_1111};
            4'h1: code = {dp, 7'b000_0110};
            4'h2: code = {dp, 7'b101_1011};
            4'h3: code = {dp, 7'b100_1111};
            4'h4: code = {dp, 7'b110_0110};
            4'h5: code = {dp, 7'b110_1101};
            4'h6: code = {dp, 7'b111_1101};
            4'h7: code = {dp, 7'b000_0111};
            4'h8: code = {dp, 7'b111_1111};
            4'h9: code = {dp, 7'b110_0111};
            4'hA: code = {dp, 7'b111_0111};
            4'hB: code = {dp, 7'b111_1100};
            4'hC: code = {dp, 7'b011_1001};
            4'hD: code = {dp, 7'b101_1110};
            4'hE: code = {dp, 7'b111_1001};
            default: code = {dp, 7'b111_0001};
        endcase

        sseg = active_high ? code : ~code;
    end


    
endmodule