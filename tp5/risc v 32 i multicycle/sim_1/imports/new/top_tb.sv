`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2021 09:24:46 PM
// Design Name: 
// Module Name: top_tb
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


module top_tb(

    );
    logic clk, rst;

    top dut(.*);
    
    always #10 clk = ~ clk;

    initial begin
        clk = 1'b0;
        rst = 1'b0;
        #3 rst = 1'b1;
        #35 rst = 1'b0;
    end

endmodule
