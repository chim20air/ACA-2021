`timescale 1ns / 100ps

module stopwatch
	import packs::BCDnumber_t;
	#(
		parameter DEC = 4,
		parameter [3 : 0] SUP_LIMITS[DEC] = '{9, 9, 5, 9}
	)
	(
		input  logic         clk, rst, tick, sign, //sign == 1 => SUP_LIMIT else INF_LIMIT
		output BCDnumber_t   [DEC - 1 : 0] digit//,
		// output logic		 pulse [DEC + 1]
	);
	
	logic pulso [DEC + 1];
	
	assign pulso[0] = tick;
	// assign pulse = pulso;
	
	generate
		genvar i;
		for(i = 0; i < DEC; i++) begin
			BCD_counter #(.SUP_LIMIT(SUP_LIMITS[i])) 
				contador (
						  .clk(clk),
						  .rst(rst),
						  .tick(pulso[i]),
						  .sign(sign),
						  .digit(digit[i].digito),
						  .overflow(pulso[i + 1])
						 );
			
			if(i % 2 == 1) begin
				assign digit[i].dp = 1'b1;
			end
			else begin
				assign digit[i].dp = 1'b0;
			end

		end
	endgenerate
endmodule
