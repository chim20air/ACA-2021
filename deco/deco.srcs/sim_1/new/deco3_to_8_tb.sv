`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/07/2021 04:51:27 PM
// Design Name: 
// Module Name: deco3_to_8_tb
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


module deco3_to_8_tb(
    );
    //signal declaration
    logic [2:0] test_word;
    logic en;
    logic [7:0] test_out;
    
    deco3_to_8 uut(.a(test_word), .en(en), .out(test_out));

    initial begin
        test_word = 2'b00;
        en = 1'b0;
        #10;
        for(int j = 0; j < 2; j = j + 1) begin
            for(int i = 0; i < 8; i = i + 1) begin
                test_word = test_word + 2'b01;
                #10;
            end
			en = 1'b1;
            #10;
        end
        $stop;
    end
endmodule
