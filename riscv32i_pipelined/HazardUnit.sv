`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Adrian Evaraldo
// 
// Create Date: 12/09/2021 04:16:05 PM
// Design Name: 
// Module Name: HazardUnit
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


module HazardUnit
    import DataTypes_pkg::*;
    (
        input  ResultSource_t   ResultSrcE,
        input  logic            PCSrcE,
        input  logic            RegWriteM,
        input  logic            RegWriteW,
        input  logic [4 : 0]    i_a1D, i_a2D,
        input  logic [4 : 0]    i_a1E, i_a2E, i_a3E,
        input  logic [4 : 0]    i_a3M,
        input  logic [4 : 0]    i_a3W,
        output logic            StallF,
        output logic            StallD, FlushD, FlushE,
        output FowHaz_MUX_SEL_t Foward1, Foward2
    );

    /////////////////////////////////////////////////////////////////
    //
    // Data Hazard
    //
    /////////////////////////////////////////////////////////////////

    always_comb begin : FowardHazard
        if (((i_a1E == i_a3M) && RegWriteM) && i_a1E != '0 ) begin // Forward from Memory stage
            Foward1 = FROM_ALU_RSLT;
        end
        else begin
            if (((i_a1E == i_a3W) && RegWriteW) && i_a1E != '0 ) begin  // Forward from Writeback stage
                Foward1 = FROM_DTA_MEMR;
            end 
            else begin
                Foward1 = FROM_REG_FILE;
            end
        end

        if (((i_a2E == i_a3M) && RegWriteM) && i_a2E != '0 ) begin // Forward from Memory stage
            Foward2 = FROM_ALU_RSLT;
        end
        else begin
            if (((i_a2E == i_a3W) && RegWriteW) && i_a2E != '0 ) begin  // Forward from Writeback stage
                Foward2 = FROM_DTA_MEMR;
            end 
            else begin
                Foward2 = FROM_REG_FILE;
            end
        end
    end



    // Stall Hazzards

    logic lwStall;

    assign lwStall = (ResultSrcE == RESULT_FROM_MEM && (( i_a1D == i_a3E) || (i_a2D == i_a3E))) ? 1'b1 : 1'b0;
    assign StallF = lwStall;
    assign StallD = lwStall;

    /////////////////////////////////////////////////////////////////
    //
    // Control Hazard
    //
    /////////////////////////////////////////////////////////////////

    assign FlushD = PCSrcE;
    assign FlushE = lwStall | PCSrcE;

endmodule
