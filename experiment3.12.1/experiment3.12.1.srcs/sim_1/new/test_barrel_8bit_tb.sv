`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2021 10:33:11 PM
// Design Name: 
// Module Name: test_barrel_8bit_tb
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


module test_barrel_8bit_tb(
    );
    
     //signal declaration
    logic [7:0] test_word0, test_out;
    logic test_sel;
    
    top_8bit dut(test_word0, test_sel, test_out);
    
    initial begin
        test_word0 = 8'b0010;
        test_sel = 1'b0;
        #50;
        test_sel = 1'b1;
        #50;
        $stop;
    end
endmodule