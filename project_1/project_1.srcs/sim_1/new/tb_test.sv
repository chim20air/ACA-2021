`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/03/2021 02:47:08 PM
// Design Name: 
// Module Name: tb_test
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


module tb_test(
	
    );
    logic a, b, out;
    test mytest(.*);
    
    initial begin
    	a = 0;
    	b = 0;
    	#10;
    	a = 1;
    	b = 0;
    	#10;
    	a = 0;
    	b = 1;
    	#10;
    	a = 1;
    	b = 1;
    	#10;
    end
endmodule
