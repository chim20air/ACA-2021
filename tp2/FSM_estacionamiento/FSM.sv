`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2021 01:38:44 PM
// Design Name: 
// Module Name: FSM
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


module FSM(
    input  logic clk, rst,
    input  logic sensor1, sensor2,
    output logic incr, decr
    );

    typedef enum logic [2 : 0] { IDLE, POS_[1 : 3]/*ENTER_[1 : 3], LEAVE_[1 : 3]*/ } state_type;
    typedef enum logic { ENTERING, LEAVING } direction_type;
    
    state_type state_reg, state_next;

    // localparam ENTERING = 0, LEAVING = 1;

    direction_type dir_reg, dir_next;

    always_ff @( posedge clk, posedge rst ) begin
        if(rst) begin
            state_reg <= IDLE;
            dir_reg   <= ENTERING;
        end
        else begin
            state_reg <= state_next;
            dir_reg   <= dir_next;
        end
    end

    // afuera-------sensor1--------sensor2------adentro

    always_comb begin
        {incr, decr} = 2'b0;
        state_next = state_reg;

        case (state_reg)
            IDLE:
                begin
                    if(sensor1) begin
                        state_next = POS_1;
                        // dir_next = ENTERING;
                    end
                    else begin
                        if(sensor2) begin
                            state_next = POS_1;
                            // dir_next = LEAVING;
                        end
                    end    
                end
            
            POS_1:
                begin
                    if (sensor1 && sensor2) begin
                        state_next = POS_2;
                    end
                    else begin
                        if(~sensor1 && ~sensor2) begin
                            state_next = IDLE;
                        end
                    end
                end

            POS_2:
                begin
                    if (sensor1 && ~sensor2 || ~sensor1 && sensor2) begin
                        state_next = POS_3;
                    end
                    else begin
                        if (~sensor1 && ~sensor2) begin
                            state_next = IDLE;
                        end
                    end
                end
            
            POS_3:
                begin
                    if(~sensor1 && ~sensor2) begin
                        if(dir_reg == ENTERING) begin
                            incr = 1'b1;
                        end
                        else begin
                            if (dir_reg == LEAVING) begin
                               decr = 1'b1; 
                            end
                        end
                        state_next = IDLE;
                    end
                end

            default:
                begin
                    state_next = IDLE;
                end
        endcase
    end

    always_comb begin
        dir_next = dir_reg;

        case({sensor1, sensor2})
            2'b01:
                begin
                    if(state_reg == IDLE) begin
                        dir_next = LEAVING;
                    end
                end
            2'b10:
                begin
                    if(state_reg == IDLE) begin
                        dir_next = ENTERING;
                    end
                end
            default:
                begin
                    dir_next = dir_reg;
                end
        endcase
    end

endmodule
