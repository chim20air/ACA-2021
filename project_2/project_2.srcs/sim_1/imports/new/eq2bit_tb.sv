`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/22/2020 09:44:10 PM
// Design Name: 
// Module Name: eq2bit_tb
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


module eq2bit_tb(

    );
    //signal declaration
    logic [1:0] test_word0, test_word1;
    logic test_out;
    
    //comparador_2bit uut(.a(test_word0), .b(test_word1), .out(test_out));
    
    greater_than_2bits uut(.a(test_word0), .b(test_word1), .out(test_out));

    initial begin
        test_word0 = 2'b00;
        test_word1 = test_word0;
        #50;
        for(int j = 0; j < 4; j = j + 1) begin
        
            for(int i = 0; i < 4; i = i + 1) begin
                test_word0 = test_word0 + 2'b01;
                #50;
            end

            test_word1 = test_word1 + 2'b01;
            #50;
        end
        $stop;

        //test if inputs are undefined
//        test_word0 = X;
//        #50;
//        test_word1 = x;
//        #50;

//        //test if inputs are high impedance
//        test_word0 = 2'b00;
//        test_word1 = test_word0;
//        #50;
//        test_word0 = z;
//        #50;
//        test_word1 = z;
//        #50;
    end
endmodule
