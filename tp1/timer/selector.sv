module selector
    import packs::BCDnumber_t;
	#(
		parameter NRO_DIGITOS = 4
	)
	(
		input  BCDnumber_t [NRO_DIGITOS - 1 : 0] num,
		input  logic clk, tick,
		output logic [5:0] out_digit_select,
		output BCDnumber_t out_digit_number
    );
	
	
	logic [1 : 0] aux = 2'b0;
	
	always_ff @(posedge clk)
	begin
		if(tick) begin
			if(aux >= 2'b11) begin
				aux <= 2'b0;
			end
			else begin
				aux <= aux + 2'b01;
			end
		end
	end
	
	always_comb begin	
		case(aux)
			2'b00:
				begin
					// out_digit_select = 8'b1111_1110;
					out_digit_select = 6'b11_1110;
					out_digit_number = num[0];
				end
			2'b01:
				begin
					// out_digit_select = 8'b1111_1101;
					out_digit_select = 6'b11_1101;
					out_digit_number = num[1];
				end
			2'b10:
				begin
					// out_digit_select = 8'b1111_1011;
					out_digit_select = 6'b11_1011;
					out_digit_number = num[2];
				end
			default:
				begin
					// out_digit_select = 8'b1111_0111;
					out_digit_select = 6'b11_0111;
					out_digit_number = num[3];
				end
			// default:
			// 	begin
			// 		out_digit_select = 8'b1111_1111;
			// 	end
		endcase
	end
	
	
endmodule