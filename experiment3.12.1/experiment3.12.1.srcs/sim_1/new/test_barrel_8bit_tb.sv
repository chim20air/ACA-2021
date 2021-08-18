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
    logic [7 : 0] sw, led;
    logic [2 : 0] amt;
    logic sel;
    
    integer i, j;
    top_8bit dut (.*);
    
    initial begin
        sw = 8'b01000100;
        sel = 1'b0;
        amt = 3'h1;
        #10;
        for(i = 0;i < 2; i = i + 1) begin
        	for(j = 0;j < 8; j = j + 1) begin
        		amt = amt + 4'h1;
        		#10;
        	end
        	sel = 1'b1;
        	#10;
        end 
        $stop;
    end
endmodule