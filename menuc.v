 module menu_comida(input AD, AT,SEL,CLC, clk, reset, output reg OP1,OP2,OP3,OP4 );
    reg [1:0] state, next_state;
    parameter M1 = 3'b000, M2 = 3'b001, M3 = 3'b010, M4 = 3'b100,S1 = 3'b101,S2 = 3'b011, S3 = 3'b110,S4 = 3'b111;


    // Nube combinacional para calcular el estado futuro

    always @ (AD or AT or SEL or CLC or state) begin
        case (state)
            M1: begin
                    if (AD == 1  )
                        next_state <= M2; //Avanza a la siguiente opción
                    else 
                        if ( AT== 1  )
							next_state <= M1; //Vuelve a la opción anterior
						else 
							if (SEL == 1 )
								next_state <= S1; //Selecciona la opción del menú
							else 
									next_state <= M1;
			
                end
            M2: if (AD == 1  )
                        next_state <= M3; //Avanza a la siguiente opción
                    else 
                        if ( AT== 1  )
							next_state <= M1; //Vuelve a la opción anterior
						else 
							if (SEL == 1 )
								next_state <= S2; //Selecciona la opción del menú
							else 
									next_state <= M2;
            M3: if (AD == 1  )
                        next_state <= M4; //Avanza a la siguiente opción
                    else 
                        if ( AT== 1  )
							next_state <= M2; //Vuelve a la opción anterior
						else 
							if (SEL == 1 )
								next_state <= S3; //Selecciona la opción del menú
							else 
									next_state <= M3;
            M4: if (AD == 1  )
                        next_state <= M4; //Avanza a la siguiente opción
                    else 
                        if ( AT== 1  )
							next_state <= M3; //Vuelve a la opción anterior
						else 
							if (SEL == 1 )
								next_state <= S4; //Selecciona la opción del menú
							else 
									next_state <= M4;
			S1:  if ( CLC == 1  )
                        next_state <= M1; //Vuelve al menú
					else 
						next_state <= S1; 
						
			S2:  if ( CLC == 1  )
                        next_state <= M1; //Vuelve al menú
					else 
						next_state <= S2; 
			
			S3:  if ( CLC == 1  )
                        next_state <= M1; //Vuelve al menú
					else 
						next_state <= S3; 
						
			S4:  if ( CLC == 1  )
                        next_state <= M1; //Vuelve al menú
					else 
						next_state <= S4; 		
						
						
						
			
            default: next_state <= M1; // Incluímos el 'default' para que la sintetización sea lógica combinacional y no secuencial
        endcase
    end

    // Banco de flip flops

    always @ (posedge clk or posedge reset) begin

        if (reset == 1)
            state <= M1;
        else
            state <= next_state;
    end

    // Nube combinacional para calcular las salidas
    // 00 = OP1
    // 01 = OP2
    // 10 = OP3
	// 11 = OP4
    always @ (state) begin
        case (state)
            S1: begin OP1 = 1'b1;OP2 = 1'b0;OP3 = 1'b0;OP4 = 1'b0;  end
            S2: begin OP1 = 1'b0;OP2 = 1'b1;OP3 = 1'b0;OP4 = 1'b0;   end
            S3: begin OP1 = 1'b0;OP2 = 1'b0;OP3 = 1'b1;OP4 = 1'b0;   end
            S4: begin OP1 = 1'b0;OP2 = 1'b0;OP3 = 1'b0;OP4 = 1'b1;  end
            default: begin OP1 = 1'b0;OP2 = 1'b0;OP3 = 1'b0;OP4 = 1'b0;  end
        endcase
    end

endmodule