`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2021 06:11:24 PM
// Design Name: 
// Module Name: flank_detector_tb
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


module flank_detector_tb(

    );

    logic i_signal, clk, rst, o_out;

    flank_detector dut (.*);

    initial begin
        clk = 1'b0;
        rst = 1'b0;
        i_signal = 1'b0;
        #2 rst = 1'b1;
        #3 rst = 1'b0;
        #15 i_signal = 1'b1;
        #15 i_signal = 1'b0;
        #5  i_signal = 1'b1;
        #15 i_signal = 1'b0;
        #30 i_signal = 1'b1;
        #15 i_signal = 1'b0;
        #40 i_signal = 1'b1;
        #3  i_signal = 1'b0;
        #56 i_signal = 1'b1;
        #3  i_signal = 1'b0;
        #100;
        $stop;
    end

    always begin
        #10 clk = ~clk;
    end
endmodule
