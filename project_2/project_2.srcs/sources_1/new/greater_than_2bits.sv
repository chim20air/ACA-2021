`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/05/2021 02:43:27 PM
// Design Name: 
// Module Name: greater_than_2bits
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


module greater_than_2bits(
    input logic [1:0] a, b,
    output out
    );

    logic case1, case2, case2a, case2b, case3, case3a, case3b;
	
	comparador_2bit eq_bita_01(.a(a), .b(2'b01), .out(case2a));
	comparador_2bit eq_bitb_00(.a(b), .b(2'b00), .out(case2b));
	
	comparador_2bit eq_bita_11(.a(a), .b(2'b11), .out(case3a));
	comparador_2bit eq_bitb_10(.a(b), .b(2'b10), .out(case3b));
	
	assign case1 = ~b[1] & a[1];
	assign case2 = case2a & case2b;
	assign case3 = case3a & case3b;
	
	assign out = case1 | case2 | case3;

	//otra opcion más sencilla a nivel RTL que es lo que se carga en
	//la LUT
	//assign out = a > b;
endmodule
