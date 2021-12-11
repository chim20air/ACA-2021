`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Adrian Evaraldo
// 
// Create Date: 09/29/2021 08:09:22 PM
// Design Name: 
// Module Name: DataPath
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

module DataPath
    import DataTypes_pkg::*;
    (
        input  logic          clk, rst, RegWriteD, JumpD, BranchD, IndjD, InvZeroD,
        input  logic          MemWriteD,
        input  ALUsource_t    ALUSrcD,
        input  ALUSrcA_t      ALUSrcAD,
        input  ResultSource_t ResultSrcD,
        input  ALUop_t        ALUControlD, 
        input  IMM_t          ImmSrcD,
        input  logic [31 : 0] InstrF, ReadDataM,
        output logic          MemWriteM,
        output logic [ 2 : 0] funct3,
        output logic [ 6 : 0] opcode, funct7,
        output logic [31 : 0] ProgramCounterF, ALUResultM, rd2M
    );

    /////////////////////////////////////////////////////////////////
    //
    // Hazards
    //
    /////////////////////////////////////////////////////////////////

    logic StallF, StallD, FlushD, FlushE;
    FowHaz_MUX_SEL_t Foward1, Foward2;

    HazardUnit HazardControl(.*);

    /////////////////////////////////////////////////////////////////
    //
    // Signals declaration on FETCH stage
    //
    /////////////////////////////////////////////////////////////////

    logic [31 : 0] ProgramCounter_NextF;
    logic [31 : 0] PCmas4F;
    logic [31 : 0] Result_to_RegMem;

    
    /////////////////////////////////////////////////////////////////
    //
    // PC Signals
    //
    /////////////////////////////////////////////////////////////////

    assign PCmas4F  = ProgramCounterF + 32'h0000_0004;

    // assign ProgramCounter_NextF = (PCSrc == JUMP) ? PCtargetE : PCmas4;
    always_comb begin : SaltoPC
        casez ({PCSrcE, IndjE})
            2'b00: ProgramCounter_NextF = PCmas4F;
            2'b10: ProgramCounter_NextF = PCtargetE;
            2'b?1: ProgramCounter_NextF = ALUResultE;
            default: 
                ProgramCounter_NextF = PCmas4F;
        endcase
    end

    PC ProgCount(
                 .PC_next(ProgramCounter_NextF),
                 .clk(clk),
                 .rst(rst),
                 .EN(~StallF),
                 .PC_out(ProgramCounterF)
    );

    /////////////////////////////////////////////////////////////////
    //
    // Signals declaration on DECODE stage
    //
    /////////////////////////////////////////////////////////////////

    logic [31 : 0] ProgramCounterD, InstrD, PCmas4D, o_extendD;
    logic [31 : 0] rd1D, rd2D;
    logic [ 4 : 0] i_a1, i_a2, i_a1D, i_a2D, i_a3D;

    always_ff @( posedge clk ) begin : FETCH_TO_DECODE_REG
        if (FlushD) begin
            ProgramCounterD <= '0;
            InstrD          <= '0;
            PCmas4D         <= '0;
        end
        else begin
            if (~StallD) begin
                ProgramCounterD <= ProgramCounterF;
                InstrD          <= InstrF;
                PCmas4D         <= PCmas4F;
            end
        end
    end
    

    /////////////////////////////////////////////////////////////////
    //
    // Instruction Decoding
    //
    /////////////////////////////////////////////////////////////////


    assign opcode = InstrD[ 6 :  0];
    assign funct3 = InstrD[14 : 12];
    assign funct7 = InstrD[31 : 25];
    assign i_a1   = InstrD[19 : 15];
    assign i_a2   = InstrD[24 : 20];
    assign i_a3D  = InstrD[11 :  7];

    /////////////////////////////////////////////////////////////////
    //
    // Fetching Registers
    //
    /////////////////////////////////////////////////////////////////


    RegisterFile RegFile(
                         .clk(clk),
                         .a1(i_a1),
                         .a2(i_a2),
                         .a3(i_a3W),
                         .we3(RegWriteW),
                         .wd3(Result_to_RegMem),
                         .rd1(rd1D),
                         .rd2(rd2D)
    );

    Extend extensor(
                    .ImmSrc(ImmSrcD),
                    .in(InstrD),
                    .out(o_extendD)
    );

    /////////////////////////////////////////////////////////////////
    //
    // Prepare signals for Hazard Unit
    //
    /////////////////////////////////////////////////////////////////

    assign i_a1D = i_a1;
    assign i_a2D = i_a2;

    /////////////////////////////////////////////////////////////////
    //
    // Signals declaration on EXECUTE stage
    //
    /////////////////////////////////////////////////////////////////

    logic [31 : 0] i_ALU_SrcA, i_ALU_SrcB, ALUResultE;
    logic [31 : 0] ProgramCounterE, PCmas4E, o_extendE;
    logic [31 : 0] rd1_HazMUX_toSrcMUX, rd2_HazMUX_toSrcMUX;
    logic [31 : 0] rd1E, rd2E, PCtargetE;
    logic [ 4 : 0] i_a1E, i_a2E, i_a3E;
    logic          RegWriteE, JumpE, BranchE, IndjE, zeroE, PCSrcE;
    logic          InvZeroE, MemWriteE;
    ALUsource_t    ALUSrcE;
    ALUSrcA_t      ALUSrcAE;
    ResultSource_t ResultSrcE;
    ALUop_t        ALUControlE;

    always_ff @( posedge clk ) begin : DECODE_TO_EXECUTE_REG
        if (FlushE) begin
            ProgramCounterE <= '0;
            PCmas4E         <= '0;
            o_extendE       <= '0;
            rd1E            <= '0;
            rd2E            <= '0;
            i_a1E           <= '0;
            i_a2E           <= '0;
            i_a3E           <= '0;
            RegWriteE       <= 1'b0;
            MemWriteE       <= 1'b0;
            JumpE           <= 1'b0;
            BranchE         <= 1'b0;
            IndjE           <= 1'b0;
            InvZeroE        <= 1'b0;
            ALUSrcE         <= ALU_RD2;
            ALUSrcAE        <= ALU_RD1;
            ResultSrcE      <= RESULT_FROM_ALU;
            ALUControlE     <= ALU_ADD;
        end
        else begin
            ProgramCounterE <= ProgramCounterD;
            PCmas4E         <= PCmas4D;
            o_extendE       <= o_extendD;
            rd1E            <= rd1D;
            rd2E            <= rd2D;
            i_a1E           <= i_a1D;
            i_a2E           <= i_a2D;
            i_a3E           <= i_a3D;
            RegWriteE       <= RegWriteD;
            MemWriteE       <= MemWriteD;
            JumpE           <= JumpD;
            BranchE         <= BranchD;
            IndjE           <= IndjD;
            InvZeroE        <= InvZeroD;
            ALUSrcE         <= ALUSrcD;
            ALUSrcAE        <= ALUSrcAD;
            ResultSrcE      <= ResultSrcD;
            ALUControlE     <= ALUControlD;
        end
    end

    /////////////////////////////////////////////////////////////////
    //
    // ALU
    //
    /////////////////////////////////////////////////////////////////

    always_comb begin : RD1_MUX_HAZARD
        case (Foward1)
            FROM_REG_FILE: rd1_HazMUX_toSrcMUX = rd1E;
            FROM_ALU_RSLT: rd1_HazMUX_toSrcMUX = ALUResultM;
            FROM_DTA_MEMR: rd1_HazMUX_toSrcMUX = Result_to_RegMem;
            default: rd1_HazMUX_toSrcMUX = rd1E;
        endcase
    end

    always_comb begin : RD2_MUX_HAZARD
        case (Foward2)
            FROM_REG_FILE: rd2_HazMUX_toSrcMUX = rd2E;
            FROM_ALU_RSLT: rd2_HazMUX_toSrcMUX = ALUResultM;
            FROM_DTA_MEMR: rd2_HazMUX_toSrcMUX = Result_to_RegMem;
            default: rd2_HazMUX_toSrcMUX = rd2E;
        endcase
    end

    assign PCtargetE = ProgramCounterE + o_extendE;

    assign i_ALU_SrcA = (ALUSrcAE == ALU_PC) ? ProgramCounterE : rd1_HazMUX_toSrcMUX;

    assign i_ALU_SrcB = (ALUSrcE == ALU_RD2) ? rd2_HazMUX_toSrcMUX : o_extendE;

    ALU arithmetic(
                   .SrcA(i_ALU_SrcA),
                   .SrcB(i_ALU_SrcB),
                   .ALUControl(ALUControlE),
                   .Zero(zeroE),
                   .ALUResult(ALUResultE)
    );

    assign PCSrcE = (InvZeroE == 1'b0) ? ( (zeroE & BranchE) | JumpE ) : ( (~zeroE & BranchE) | JumpE );

    /////////////////////////////////////////////////////////////////
    //
    // Signals declaration on MEM stage
    //
    /////////////////////////////////////////////////////////////////

    logic [31 : 0] PCmas4M;
    logic [ 4 : 0] i_a3M;
    logic          RegWriteM;
    ResultSource_t ResultSrcM;

    always_ff @( posedge clk ) begin : EXECUTE_TO_MEM_REG
        PCmas4M         <= PCmas4E;
        rd2M            <= rd2_HazMUX_toSrcMUX;
        i_a3M           <= i_a3E;
        RegWriteM       <= RegWriteE;
        MemWriteM       <= MemWriteE;
        ResultSrcM      <= ResultSrcE;
        ALUResultM      <= ALUResultE;
    end

    /////////////////////////////////////////////////////////////////
    //
    // Signals declaration on WRITEBACK stage
    //
    /////////////////////////////////////////////////////////////////

    logic [31 : 0] ALUResultW, ReadDataW, PCmas4W;
    logic [ 4 : 0] i_a3W;
    logic          RegWriteW;
    ResultSource_t ResultSrcW;

    always_ff @( posedge clk ) begin : MEM_TO_WRITEBACK_REG
        PCmas4W         <= PCmas4M;
        i_a3W           <= i_a3M;
        RegWriteW       <= RegWriteM;
        ResultSrcW      <= ResultSrcM;
        ALUResultW      <= ALUResultM;
        ReadDataW       <= ReadDataM;
    end
    

    always_comb begin : Mux_que_escribe_reg_file
        case (ResultSrcW)
            RESULT_FROM_ALU:
                Result_to_RegMem = ALUResultW;
            
            RESULT_FROM_MEM:
                Result_to_RegMem = ReadDataW;
            
            RESULT_FROM_PC4:
                Result_to_RegMem = PCmas4W;
                
            default: 
                Result_to_RegMem = ALUResultW;
        endcase
    end

endmodule
