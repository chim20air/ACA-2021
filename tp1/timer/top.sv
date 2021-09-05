module top
    import packs::BCDnumber_t;
    (
        input logic sysclk, SW, rst,
        output logic [7 : 0] sseg,
        output logic [5 : 0] AN
    );
	
	localparam NRO_DIGITOS = 4;
	
    logic tick_contador, tick_display;
    BCDnumber_t [ NRO_DIGITOS - 1 : 0 ] out_gen_digit; //[ms:seg:min][digito]
    // logic [7 : 0] out_seleccion_digito;
    logic [4 : 0] out_digito_BCD;

    clk_divider #(
        .N(25),     //valores placa
        .M(12_500_000))
        // .N(3),   //valores simulacion
        // .M(5)) 
            pulseGenContador (
                               .clk(sysclk),
                               .rst(rst),
                               .tick(tick_contador)
							  );
    
    clk_divider #(
        .N(17),     //valores placa
        .M(125_000))
        // .N(2),   //valores simulacion
        // .M(2)) 
            pulseGenDisplay (
                               .clk(sysclk),
                               .rst(rst),
                               .tick(tick_display)
							  );
    
    stopwatch #(.DEC(NRO_DIGITOS)) timer (
										  .clk(sysclk),
										  .rst(rst),
										  .tick(tick_contador),
										  .sign(SW),
										  .digit(out_gen_digit)
										 );
	
	selector #(.NRO_DIGITOS(NRO_DIGITOS)) MUX_BCD
	(
		.num(out_gen_digit),
		.clk(sysclk),
		.tick(tick_display),
		.out_digit_select(AN),
		.out_digit_number(out_digito_BCD)
    );


	
	BCD_to_sseg sevensegConverter(
                                  .hex(out_digito_BCD),
                                  .active_high(1'b0),
                                  .sseg(sseg)
                                 );
endmodule
