`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/22/2020 09:44:10 PM
// Design Name: 
// Module Name: deco2_to_4_tb
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


module deco2_to_4_tb(

    );
    //signal declaration
    logic [1:0] test_word;
    logic en;
    logic [3:0] test_out;
    
    deco2_to_4 uut(.a(test_word), .en(en), .out(test_out));

    initial begin
        test_word = 2'b00;
        en = 1'b0;
        #50;
        for(int j = 0; j < 2; j = j + 1) begin
            for(int i = 0; i < 4; i = i + 1) begin
                test_word = test_word + 2'b01;
                #50;
            end
			en = 1'b1;
            #50;
        end
        $stop;
    end
endmodule
