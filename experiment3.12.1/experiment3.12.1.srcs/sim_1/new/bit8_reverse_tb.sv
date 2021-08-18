`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/17/2021 08:59:05 PM
// Design Name: 
// Module Name: bit8_reverse_tb
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


module bit8_reverse_tb(
    );
    
    logic [7 : 0] in, out;
    integer i;
    bit8_reverse dut (.*);
    initial begin
        in = 8'b01001000;
        #10;
        $stop;
    end
endmodule
