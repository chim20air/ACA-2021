`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Adrian Evaraldo
// 
// Create Date: 10/04/2021 10:15:33 PM
// Design Name: 
// Module Name: PCsource_pkg
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

package PCsource_pkg;

    typedef enum logic [1 : 0] { NEXT,                  //siguiente instruccion
                                 JUMP,                  //salto
                                 INDJ } PCsource_t;     //para el JALR salto indirecto (que parto de un registro)
endpackage
