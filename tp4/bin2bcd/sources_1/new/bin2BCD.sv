`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2021 05:09:27 PM
// Design Name: 
// Module Name: bin2BCD
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


module bin2BCD(
        input  logic         clk, start,
        input  logic [7 : 0] in,
        output logic [3 : 0] BCD [3],
        output logic         done, ready
    );

    typedef enum logic [1 : 0] { IDLE, BUSY, DONE } state_t;
    
//     logic   [11 + 8 : 0] BCDtemp_reg, BCDtemp_next;
//     state_t              state_reg, state_next;
//     logic                en;
//     logic   [3 : 0]      contador8bits_reg, contador8bits_next;
//     // logic                llegue_a_8bits_reg, llegue_a_8bits_next;
//     logic                finish_conv;


//     always_ff @( posedge clk ) begin
//         if (start) begin
//             BCDtemp_reg        <= { {12{1'b0}}, bin };
//             contador8bits_reg  <= '0;
//             state_reg          <= BUSY;
//             // llegue_a_8bits_reg <= 1'b0;
//         end
//         else begin
//             BCDtemp_reg        <= BCDtemp_next;
//             state_reg          <= state_next;
//             contador8bits_reg  <= contador8bits_next;
//             // llegue_a_8bits_reg <= llegue_a_8bits_next;
//         end
//     end

//     always_comb begin : ControlPath
//         state_next = state_reg;
//         en         = 1'b0;
//         done       = 1'b0;
//         ready      = 1'b0;

//         case (state_reg)
//             IDLE:
//                 begin
//                     ready = 1'b1;
//                     // if(start) begin
//                     //     state_next = BUSY;
//                     //     contador8bits = 4'h0;
//                     // end
//                 end
            
//             BUSY:
//                 begin
//                     en = 1'b1;
//                     if(finish_conv) begin
//                         state_next = DONE;
//                     end
//                     // if(llegue_a_8bits_reg) begin
//                         // if(BCDtemp_reg [7 : 0] == '0) begin
//                             // state_next = DONE;
//                         // end
//                     // end
//                 end

//             DONE:
//                 begin
//                     done       = 1'b1;
//                     state_next = IDLE;
//                 end

//             default: 
//                 begin
//                     state_next = IDLE;
//                 end
//         endcase
//     end

//     always_comb begin : DataPath
//         BCDtemp_next = BCDtemp_reg;
//         // llegue_a_8bits_next = llegue_a_8bits_reg;
//         contador8bits_next  = contador8bits_reg;
//         finish_conv = 1'b0;
//         BCD[0] = '0;
//         BCD[1] = '0;
//         BCD[2] = '0;

//         case(en)
//             1'b1:
//                 begin
//                     // for (i = '0; i < 2'b10 ; i = i + 2'b1 ) begin
//                     //     if(BCDtemp_next[11 + 4 * i : 8 + 4 * i] >= 4'h5) begin
//                     //         BCDtemp_next[11 + 4 * i : 8 + 4 * i] = BCDtemp_next[11 + 4 * i : 8 + 4 * i] + 4'h3;
//                     //     end
//                     // end
//                     // if(BCDtemp_next[11 : 8] >= 4'h5) begin
//                     //     BCDtemp_next[11 : 8] = BCDtemp_next[11 : 8] + 4'h3;
//                     // end
//                     // if(BCDtemp_next[15 : 12] >= 4'h5) begin
//                     //     BCDtemp_next[15 : 12] = BCDtemp_next[15 : 12] + 4'h3;
//                     // end
//                     // if(BCDtemp_next[19 : 16] >= 4'h5) begin
//                     //     BCDtemp_next[19 : 16] = BCDtemp_next[19 : 16] + 4'h3;
//                     // end
//                     BCDtemp_next = BCDtemp_reg << 1;
//                     if(contador8bits_reg < 4'h9) begin
//                         contador8bits_next = contador8bits_next + 4'b0001;
//                     end
//                     else begin
//                         // llegue_a_8bits_next = 1'b1;
//                         if(BCDtemp_reg[7 : 0] == '0) begin
//                             finish_conv = 1'b1;
//                         end
//                     end
//                 end
//             default:
//                 begin
//                     if (state_reg == DONE) begin
//                         BCD[0] = BCDtemp_reg[11 : 8 ];
//                         BCD[1] = BCDtemp_reg[15 : 12];
//                         BCD[2] = BCDtemp_reg[19 : 16];
//                         // generate
//                         //     genvar i;
//                         //     for (i = '0; i < 2'b10 ; i = i + 2'b1 ) begin
//                         //         BCD[i] = BCDtemp_reg[11 + 4 * i : 8 + 4 * i];
//                         //     end
//                         // endgenerate
//                     end
//                 end
//         endcase
//     end
// endmodule
// // 11+8=19
// // 19..16.15..12.11..8.7...0

    state_t                 state_reg, state_next;
    logic [12 + 8 - 1 : 0]  bin_reg, bin_next;
    logic                   en;
    logic [3 : 0]           counter_reg, counter_next;
    logic greater_than_3_hundred, greater_than_3_tens, greater_than_3_unit;

    always_ff @( posedge clk ) begin
        if (start) begin
            bin_reg     <= { {12{1'b0}}, in };
            counter_reg <= 4'h8;
            state_reg   <= BUSY;
        end
        else begin
            bin_reg     <= bin_next;
            counter_reg <= counter_next;
            state_reg   <= state_next;
        end
    end

    always_comb begin : ControlPath
        state_next  = state_reg;
        en          = 1'b0;
        ready       = 1'b0;
        done        = 1'b0;

        case (state_reg)
            IDLE:
                begin
                    ready = 1'b1;
                end
            
            BUSY:
                begin
                    en = 1'b1;
                    if (counter_reg == '0) begin
                        state_next = DONE;
                    end
                end

            DONE:
                begin
                    done       = 1'b1;
                    state_next = IDLE;
                end
            default:
                begin
                    state_next = state_reg;
                end
        endcase
    end

    assign BCD[0] = (state_reg == DONE) ? bin_reg[11 : 8 ] : '0;
    assign BCD[1] = (state_reg == DONE) ? bin_reg[15 : 12] : '0;
    assign BCD[2] = (state_reg == DONE) ? bin_reg[19 : 16] : '0;

    always_comb begin : DataPath
        counter_next = counter_reg;
        greater_than_3_hundred = 1'b0;
        greater_than_3_tens = 1'b0;
        greater_than_3_unit = 1'b0;

        case (en)
            1'b1:
                begin
                    // if (bin_reg[19 : 16] >= 4'h5) begin
                    //     bin_next[19 : 16] = bin_reg[19 : 16] + 4'h3;
                    // end
                    // else begin
                    //     if (bin_reg[15 : 12] >= 4'h5) begin
                    //         bin_next[15 : 12] = bin_reg[15 : 12] + 4'h3;
                    //     end
                    //     else begin
                    //         if (bin_reg[11 : 8] >= 4'h5) begin
                    //             bin_next[11 : 8] = bin_reg[11 : 8] + 4'h3;
                    //         end 
                    //         else begin
                    //             bin_next = bin_reg << 1;
                    //             counter_next = counter_reg - 1;
                    //         end
                    //     end
                    // end

                    if (bin_reg[11 : 8] >= 4'h5) begin : unidad
                        bin_next[11 : 8] = bin_reg[11 : 8] + 4'h3;
                        greater_than_3_unit = 1'b1;
                    end
                    if (bin_reg[15 : 12] >= 4'h5) begin : decena
                        bin_next[15 : 12] = bin_reg[15 : 12] + 4'h3;
                        greater_than_3_tens = 1'b1;
                    end
                    if (bin_reg[19 : 16] >= 4'h5) begin : centena
                        bin_next[19 : 16] = bin_reg[19 : 16] + 4'h3;
                        greater_than_3_hundred = 1'b1;
                    end
                    bin_next = bin_reg << 1;
                    counter_next = counter_reg - 1;
                    

                end 

            default: 
                begin
                    bin_next = '0;
                end
        endcase
    end

endmodule
