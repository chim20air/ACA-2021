`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2021 02:03:36 PM
// Design Name: 
// Module Name: debouncer_tb
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


module debouncer_tb(

    );

    logic clk, rst, i_signal, i_tick10ms, o_out;
    logic [3 : 0] state, state_n;

    debouncer_late dut (.*);

    initial begin
        clk = 1'b0;
        i_tick10ms = 1'b0;
        rst = 1'b0;
        i_signal = 1'b0;
        #2 rst = 1'b1;
        #5 rst = 1'b0;
        #23 i_signal = 1'b1;
        #5  i_signal = 1'b0;
        #20 i_signal = 1'b1;
        #5  i_signal = 1'b0;
        #300;
        i_signal = 1'b1;
        #300;
        #20 i_signal = 1'b0;
        #5  i_signal = 1'b1;
        #20 i_signal = 1'b0;
        #5  i_signal = 1'b1;
        #10 i_signal = 1'b0;
        #150;
        $stop;
    end

    always begin
        #10 clk = ~clk;
    end
    
    always begin
        #10 i_tick10ms = 1'b0;
        #40 i_tick10ms = 1'b1;
    end

endmodule
