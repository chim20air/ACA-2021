`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2021 08:34:22 PM
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
    logic         sysclk, SW, rst;
    logic [7 : 0] sseg, AN;
    
    top uut (.*);

    initial begin
        sysclk = 1'b0;
        rst = 1'b0;
        SW = 1'b0;
        // tick = 
        #15  rst = 1'b1;
        #15  rst = 1'b0;
        #2000 $stop;
    end
    
    always begin
        #10 sysclk = ~sysclk;
    end
endmodule
