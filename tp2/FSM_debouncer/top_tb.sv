`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2021 07:58:03 PM
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

    logic         clk, rst, btn;
    logic [7 : 0] sseg;
    logic [5 : 0] AN;

    top dut(.*);

    initial begin
        clk = 1'b0;
        rst = 1'b0;
        btn = 1'b0;
        #2 rst = 1'b1;
        #3 rst = 1'b0;
        #15 btn = 1'b1;
        #15 btn = 1'b0;
        #5  btn = 1'b1;
        #15 btn = 1'b0;
        #30 btn = 1'b1;
        #15 btn = 1'b0;
        #40 btn = 1'b1;
        #3  btn = 1'b0;
        #30;
        $stop;
    end

    always begin
        #10 clk = ~clk;
    end
endmodule
