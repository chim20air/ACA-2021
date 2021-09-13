import digito_pkg::BCDnumber_t;

module selector
	#(
		parameter NRO_DIGITOS = 4
	)
	(
		input  BCDnumber_t [NRO_DIGITOS - 1 : 0] num,
		input  logic clk, tick,
		output logic [5 : 0] out_digit_select,
		output BCDnumber_t out_digit_number
    );
	
	logic [2 : 0] aux = 3'b0;

	BCDnumber_t cero;

	assign cero.digito = 4'b0000;
	assign cero.dp	   = 1'b0;
	
	always_ff @(posedge clk)
	begin
		if(tick) begin
			if(aux >= 3'b101) begin
				aux <= 3'b0;
			end
			else begin
				aux <= aux + 3'b001;
			end
		end
	end
	
	always_comb begin	
		case(aux)
			3'b000:
				begin
					// out_digit_select = 8'b1111_1110;
					out_digit_select = 6'b11_1110;
					out_digit_number = num[0];
				end
			3'b001:
				begin
					// out_digit_select = 8'b1111_1101;
					out_digit_select = 6'b11_1101;
					out_digit_number = num[1];
				end
			3'b010:
				begin
					// out_digit_select = 8'b1111_1011;
					out_digit_select = 6'b11_1011;
					out_digit_number = num[2];
				end
			3'b011:
				begin
					// out_digit_select = 8'b1111_1011;
					out_digit_select = 6'b11_0111;
					out_digit_number = num[3];
				end
			// 3'h4:
			// 	begin
			// 		// out_digit_select = 8'b1111_1011;
			// 		out_digit_select = 6'b10_1111;
			// 		out_digit_number = num[4];
			// 	end
			default:
				begin
					out_digit_select = 6'b11_1111;
					out_digit_number = cero;
				end
		endcase
	end
	
	
endmodule
