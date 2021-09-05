`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/19/2021 02:50:53 PM
// Design Name: 
// Module Name: dual_pdecoder
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


module dual_pdecoder
	#(parameter N = 4)
	(
    input  logic [N-1 : 0] in,
    output logic [$clog2(N)-1 : 0] out1, out2,
    output logic request1, request2
    );
    
    always_comb begin
    	{ou1, request1} = {2'bxx, 1'b0};
    	{out2, request2} = {2'bxx, 1'b0};
    	
    	for(int i = 3; i >= 0 ; i--) begin
    		if(in[i] == 1'b1) begin
    			if(request1 == 1'b0) begin
					out1 = 2'(i);
					request1 = 1'b1;
    			end
    			else begin
    				out2 = 2'(i);
					request2 = 1'b1;
					break;
				end
    		end
    	end
    end
endmodule
