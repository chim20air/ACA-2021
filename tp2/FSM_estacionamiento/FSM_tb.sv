`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2021 01:53:57 PM
// Design Name: 
// Module Name: FSM_tb
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


module FSM_tb(

    );
    logic clk, rst, sensor1, sensor2;
    logic incr, decr;

    FSM dut (.*);

    initial begin
        clk = 1'b0;
        rst = 1'b0;
        sensor1 = 1'b0;
        sensor2 = 1'b0;
        #3 rst = 1'b1;
        #17 rst = 1'b0;
        #30 sensor1 = 1'b1;
        #30 sensor2 = 1'b1;
        #30 sensor1 = 1'b0;
        #30 sensor2 = 1'b0;
        #50;
        #30 sensor1 = 1'b1;
        #30 sensor2 = 1'b1;
        #30 sensor1 = 1'b0;
        #30 sensor2 = 1'b0;
        #50;
        #30 sensor2 = 1'b1;
        #30 sensor1 = 1'b1;
        #30 sensor2 = 1'b0;
        #30 sensor1 = 1'b0;
        #50;
        #30 sensor2 = 1'b1;
        #30 sensor1 = 1'b1;
        #30 sensor2 = 1'b0;
        #30 sensor1 = 1'b0;
        #50;
        $stop;
    end

    always begin
        #10 clk = ~clk;
    end
endmodule
