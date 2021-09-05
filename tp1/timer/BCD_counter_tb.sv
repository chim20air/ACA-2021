`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2021 03:04:16 PM
// Design Name: 
// Module Name: BCD_counter_tb
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

module BCD_counter_tb
	import packs::BCDnumber_t;
    (

    );

    
    logic         clk, rst, tick, sign;
    logic [3 : 0] digit;//, state_reg;
    logic         overflow;
    
    BCD_counter uut (.*);

    initial begin
        clk = 1'b0;
        rst = 1'b0;
        sign = 1'b0;
        // tick = 
        #15  rst = 1'b1;
        #15  rst = 1'b0;
        #10000 sign = 1'b1;
        #1000 $stop;
    end
    
    always begin
        #10 clk = ~clk;
    end

    always begin
        #20 tick = 1'b0;
        #50 tick = 1'b1;
    end

endmodule
