module top
    import digito_pkg:: BCDnumber_t;
    (
        input logic  clk, rst,
        input logic  [1 : 0] sensor,
        output logic [7 : 0] sseg,
        output logic [5 : 0] AN
    );

    logic incr, decr, tick, sign, tick_display;
    logic [4 : 0] out_digito_BCD;

    localparam CANT_DIGITOS = 1;

    // BCDnumber_t [CANT_DIGITOS - 1 : 0] digit;
    BCDnumber_t digit;

    FSM maquina_estado(
                        .clk(clk),
                        .rst(rst),
                        .sensor1(sensor[0]),
                        .sensor2(sensor[1]),
                        .incr(incr),
                        .decr(decr)
                      );
    
    FSMtoBCDcounter
        adaptador(
                  .incr(incr),
                  .decr(decr),
                  .tick(tick),
                  .sign(sign)
    );

    clk_divider #(
        .N(17),     //valores placa
        .M(125_000))
        // .N(2),   //valores simulacion
        // .M(2)) 
            pulseGenDisplay (
                               .clk(clk),
                               .rst(rst),
                               .tick(tick_display)
							  );

    contador #(
        .DEC(CANT_DIGITOS),
        .SUP_LIMITS('{9}))
            conta (
                    .clk(clk),
                    .rst(rst),
                    .tick(tick),
                    .sign(sign),
                    .digit(digit)
                    );
    
    selector #(.NRO_DIGITOS(CANT_DIGITOS)) MUX_BCD
	(
		.num(digit),
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