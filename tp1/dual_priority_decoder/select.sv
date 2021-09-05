module select(
    input  logic [4:0] num1, num2, //dp + nro hexa
    input  logic clk, tick,
    output logic [7:0] out_digit_select,
    output logic [4:0] out_digit_number
    );
	
	
	logic aux = 1'b0;
	
	always_ff @(posedge clk)
	begin
		// if(aux >= 1'b1) begin
		// 	aux = 1'b0;
		// end
		// else begin
		// 	aux = aux + 2'b01;
		// end
		if (tick) begin
			aux <= aux + 1'b1;
		end
	end
	
	always_comb begin	
		case(aux)
			1'b0:
				begin
					out_digit_select = 8'b1111_1110;
					out_digit_number = num1;
				end
			1'b1:
				begin
					out_digit_select = 8'b1111_1101;
					out_digit_number = num2;
				end
			default:
				begin
					out_digit_select = 8'b1111_1111;
				end
		endcase
	end
	
	
endmodule