// `timescale 1ns / 1ps
// //////////////////////////////////////////////////////////////////////////////////
// // Company: 
// // Engineer: 
// // 
// // Create Date: 09/02/2021 01:52:59 PM
// // Design Name: 
// // Module Name: packs
// // Project Name: 
// // Target Devices: 
// // Tool Versions: 
// // Description: 
// // 
// // Dependencies: 
// // 
// // Revision:
// // Revision 0.01 - File Created
// // Additional Comments:
// // 
// //////////////////////////////////////////////////////////////////////////////////


// module packs(

//     );
// endmodule

package digito_pkg;

    typedef struct packed
    {
        logic [3 : 0] digito;
        logic dp;
    }BCDnumber_t;
endpackage
