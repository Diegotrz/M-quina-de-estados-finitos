 module menu_bebida(input AD, AT,SEL,CLC,act, clk, reset, output reg B1,B2,B3,B4,act2 );
    reg [1:0] state, next_state; //Variables de estados definidas para que registren el dato anterior.
    parameter M1 = 4'b0000, M2 = 4'b0001, M3 = 4'b0010, M4 = 4'b0100,S1 = 4'b1000,S2 = 4'b0011, S3 = 3'b1100,S4 = 4'b1001,IN =1010;


    // Nube combinacional para calcular el estado futuro

    always @ (AD or AT or SEL or CLC or state or act) begin
	if (act==1)
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
		
			IN:if ( CLC == 1  )
                        next_state <= IN; //Vuelve al menú
					else 
						next_state <= IN; 

						
						
			
            default: next_state <= M1; // Incluímos el 'default' para que la sintetización sea lógica combinacional y no secuencial

        endcase
else
	next_state <= IN;

	end


    // Banco de flip flops

    always @ (posedge clk or posedge reset) begin

        if (reset == 1)//Si se activa el reset la máquina vuelve a al estado inicial del menú M1
            state <= M1;
        else
            state <= next_state; //Si el reset no se activa, el estado cambia al siguiente en el flanco de reloj
    end

    // Nube combinacional para definir las salidas en cada estado

    always @ (state) begin
        case (state)
            S1: begin B1 = 1'b1;B2 = 1'b0;B3 = 1'b0;B4 = 1'b1;  end
            S2: begin B1 = 1'b0;B2 = 1'b1;B3 = 1'b0;B4 = 1'b1;   end
            S3: begin B1 = 1'b0;B2 = 1'b0;B3 = 1'b1;B4 = 1'b1;   end
            S4: begin B1 = 1'b0;B2 = 1'b0;B3 = 1'b0;B4 = 1'b1;  end
            default: begin B1 = 1'b0;B2 = 1'b0;B3 = 1'b0;B4 = 1'b0;  end
        endcase
    end

endmodule