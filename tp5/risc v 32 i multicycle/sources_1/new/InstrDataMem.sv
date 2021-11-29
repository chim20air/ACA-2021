`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2021 07:44:53 PM
// Design Name: 
// Module Name: InstrDataMem
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


module InstrDataMem(
        input  logic          clk, we,
        input  logic [31 : 0] a, wd,
        output logic [31 : 0] rd
    );

    logic [31 : 0] MEM [128];

    initial begin
        $readmemh("base_programm.mem", MEM);
    end
    
    assign rd = MEM[a];

    always_ff @( posedge clk ) begin
        if (we) begin
            MEM[a] <= wd;
        end
        
        // rd <= MEM[a];
    end
endmodule
