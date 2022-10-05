 module menu_pago(input AD, AT,SEL,CLC,act2, clk, reset, output reg EFE,TAR,RECS,FNS);
    reg [1:0] state, next_state; //Variables de estados definidas para que registren el dato anterior.
    parameter EF = 3'b000, TR= 3'b001, SEF = 3'b010, STAR = 3'b100,VUEL = 3'b101,REC = 3'b011, FN = 3'b110, IN= 3'b111;	


    // Nube combinacional para calcular el estado futuro

    always @ (AD or AT or SEL or CLC or state or act2) begin
	if (act2==1)
        case (state)
            EF: begin
                    if (AD == 1  )
                        next_state <= TAR; //Avanza a la siguiente opción
                    else 
                        if ( AT== 1  )
							next_state <= EF; //Vuelve a la opción anterior
						else 
							if (SEL == 1 )
								next_state <=SEF ; //Selecciona la opción del menú
							else 
									next_state <= EF;
			
                end
            TAR: if (AD == 1  )
                        next_state <= TAR; //Avanza a la siguiente opción
                    else 
                        if ( AT== 1  )
							next_state <= EF; //Vuelve a la opción anterior
						else 
							if (SEL == 1 )
								next_state <= STAR; //Selecciona la opción del menú
							else 
									next_state <= TAR;
			SEF:  if ( CLC == 1  )
                        next_state <= EF; //Vuelve al menú
					else 
						next_state <= VUEL; 
						
			STAR:  if ( CLC == 1  )
                        next_state <= TAR; //Vuelve al menú
					else 
						next_state <= REC; 
			
			VUEL:
						next_state <= REC; 
						
			REC:  	next_state <= FN; 
			FN:  	if ( CLC == 1  )
                        next_state <= EF; //Vuelve al menú
					else 
						next_state <= FN; 	
			IN: if ( CLC == 1  )
                        next_state <= IN; //Vuelve al menú
					else 
						next_state <= IN; 

						
						
			
            default: next_state <= EF; // Incluímos el 'default' para que la sintetización sea lógica combinacional y no secuencial
        endcase
else
	next_state <=IN ;
	end


    // Banco de flip flops

    always @ (posedge clk or posedge reset) begin

        if (reset == 1)//Si se activa el reset la máquina vuelve a al estado inicial del menú M1
            state <= EF;
        else
            state <= next_state; //Si el reset no se activa, el estado cambia al siguiente en el flanco de reloj
    end

    // Nube combinacional para definir las salidas en cada estado

    always @ (state) begin
        case (state)
            SEF: begin EFE = 1'b1;TAR = 1'b0;RECS =1'b0;FNS = 1'b0; end
            STAR: begin EFE = 1'b0;TAR = 1'b1;RECS =1'b0;FNS = 1'b0; end
            REC: begin EFE = 1'b0;TAR = 1'b0;RECS =1'b1;FNS = 1'b0;   end
            FN: begin EFE = 1'b0;TAR = 1'b0;RECS =1'b0;FNS = 1'b1;  end
            default: begin EFE = 1'b0;TAR = 1'b0;RECS =1'b0;FNS = 1'b0;  end
        endcase
    end

endmodule