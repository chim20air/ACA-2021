`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2021 10:15:35 PM
// Design Name: 
// Module Name: stopwatch_tb
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


module stopwatch_tb
    	import packs::BCDnumber_t;
    (

    );

    
    logic                   clk, rst, tick, sign;
    BCDnumber_t  [3 : 0]    digit;
    logic                   pulse[5];
    
    stopwatch uut (.*);

    initial begin
        clk = 1'b0;
        rst = 1'b0;
        sign = 1'b0;
        // tick = 
        #15  rst = 1'b1;
        #15  rst = 1'b0;
        #10000 sign = 1'b1;
        #500 $stop;
    end
    
    always begin
        #8 clk = ~clk;
    end

    always begin
        #16 tick = 1'b0;
        #48 tick = 1'b1;
    end
endmodule
