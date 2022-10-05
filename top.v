// look in pins.pcf for all the pin names on the TinyFPGA BX board

module top (
input CLK,
    input PIN_11,PIN_12,PIN_13,PIN_10,
	output PIN_16,PIN_15,PIN_14,PIN_17,PIN_18,PIN_19,PIN_20,PIN_21,PIN_22,PIN_23,
	output LED,   // User/boot LED next to power LED
	output USBPU	
);
wire AD, AT,SEL,CLC, clk, reset,OP1,OP2,OP3,OP4;
wire B1,B2,B3,B4;
wire EFE,TAR,RECS,FNS;
assign AD = ~PIN_11;
assign AT = ~PIN_12;
assign SEL = ~PIN_13;
assign CLC = ~PIN_10;
assign reset = 1'b0;
assign OP1= PIN_14;
assign OP2= PIN_15;
assign OP3= PIN_16;
assign OP4= PIN_17;


assign B1= PIN_18;
assign B2= PIN_19;
assign B3= PIN_20;
assign B4= PIN_21;

assign EFE= PIN_22;
assign TAR= PIN_23;

assign clk = counter[25];
wire act; //Salida que activa la segunda máquina para la elección de bebidas
wire act2;//Salida que activa la tercer  máquina para la elección del método de pago

menu_comida U1(AD,AT,SEL,CLC,clk,reset,OP1,OP2,OP3,OP4,act);
menu_bebida U2(PIN_11,PIN_12,PIN_13,PIN_10,act,clk,reset,B1,B2,B3,B4,act2);
menu_pago U3(PIN_11,PIN_12,PIN_13,PIN_10,act2,clk,reset,EFE,TAR);
   reg [25:0] counter;

    // increment the blink_counter every clock
    always @(posedge CLK) begin
        counter <= counter + 1;
    end
    
    // light up the LED according to the pattern
    assign LED = clk;



endmodule

