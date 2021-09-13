`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2021 05:17:15 PM
// Design Name: 
// Module Name: flank_detector
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


module flank_detector(
    input  logic i_signal, clk, rst,
    output logic o_out
    );

    typedef enum logic { HIGH, LOW } salida_t;

    salida_t aux_reg, aux_next;
    // logic aux_out;

    always_ff @( posedge clk ) begin
        if(rst) begin
            aux_reg <= LOW;
        end
        else begin
            aux_reg <= aux_next;
        end
    end

    always_comb begin
        aux_next = aux_reg; //problemas con esta línea, comentada la simulación anda como debe
                            //pero cuando hago la implementación, me tira el siguiente warning:
                            //[DRC PDRC-153] Gated clock check: Net antirrebote/debounce/aux_reg_reg is a gated clock net
                            //sourced by a combinational pin antirrebote/debounce/aux_next_reg_i_2/O, cell
                            //antirrebote/debounce/aux_next_reg_i_2. This is not good design practice and will likely
                            //impact performance. For SLICE registers, for example, use the CE pin to control the loading of data.
                            //Sin comentar la línea, no hay ninguna diferencia entre con y sin antirrebote
                            //
        case (aux_reg)
            LOW:
                begin
                    if (i_signal) begin
                        aux_next = HIGH;
                    end
                end
            
            HIGH:
                begin
                    if (~i_signal) begin
                        aux_next = LOW;
                    end
                end
            default: 
                begin
                    aux_next = LOW;
                end
        endcase
    end

    assign o_out = (aux_reg == HIGH) ? 1'b1 : 1'b0;
endmodule
