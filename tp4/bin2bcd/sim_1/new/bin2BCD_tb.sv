`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2021 04:37:37 PM
// Design Name: 
// Module Name: bin2BCD_tb
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


module bin2BCD_tb(

    );
    
    logic         clk, start;
    logic [7 : 0] in;
    logic [3 : 0] BCD [3];
    logic         done, ready;

    bin2BCD dut(.*);

    always #10 clk = ~clk;

    initial begin
        clk   = 1'b0;
        start = 1'b0;
        // wait(ready);
        in   =  '0;
        // for(int i = 0; i < 256; i = i + 1) begin
        //     wait(ready);
            #40;
            // in   = 8'b1001_0011; //147 base 10
            in   = 8'hFF;
            start = 1'b1;
            #20 start = 1'b0;
        // end
        wait(ready);
        #40;
        $stop;
    end
endmodule
