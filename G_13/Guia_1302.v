/* 
Guia_1302.v 
855842 - Mateus Resende Ottoni

iverilog -o Guia_1302.vvp Guia_1302.v
vvp Guia_1302.vvp
*/


// Pulse
//----------------------------------------
module pulse (output signal);

// Dados
reg signal;

// Processo
initial
  begin
    signal = 1'b0;
  end

  always
    begin
      #6 signal = ~signal;
    end


endmodule
//----------------------------------------


// Flip-Flop JK
//----------------------------------------
module jkff (output q, output qnot,
            input j, input k,
            input clock, input preset, input clear);	

// Dados
reg q, qnot;

initial
  begin
    q = 1'b0;
    qnot = 1'b1;
  end

// Processo
always @ ( posedge clock or posedge preset or posedge clear )
  begin

  if ( clear )
    begin
      q <= 0;
      qnot <= 1;
    end
  else
    if ( preset )
      begin
        q <= 1;
        qnot <= 0;
      end
    else
      if ( j & ~k )
        begin
          q <= 1;
          qnot <= 0;
        end
      else
        if ( ~j & k )
          begin
            q <= 0;
            qnot <= 1;
          end
        else
          if ( j & k )
            begin
              q <= ~q;
              qnot <= ~qnot;
            end

  end


endmodule
//----------------------------------------


// Contador Assíncrono Crescente (5 bits)
//----------------------------------------
module cont_a_cre_5 (output [4:0] result,
                     input pulse, input one, input clear);

// Dados
reg [4:0] result = 5'b00000;
wire [4:0] n_out;
wire [4:0] out;
reg preset = 1'b0;;

// Módulos
jkff jk1 ( out[0], n_out[0], one, one, pulse, preset, clear);
jkff jk2 ( out[1], n_out[1], one, one, out[0], preset, clear);
jkff jk3 ( out[2], n_out[2], one, one, out[1], preset, clear);
jkff jk4 ( out[3], n_out[3], one, one, out[2], preset, clear);
jkff jk5 ( out[4], n_out[4], one, one, out[3], preset, clear);

always @( posedge pulse )
  begin
    result <= n_out;
  end


endmodule
//----------------------------------------





// Modulo principal
module Guia_1302; 

// Definir dados
wire [4:0] result;
wire pulso;
reg value = 1'b1;
reg clear = 1'b0;

// Modulos iniciais
pulse pulso1 ( pulso );
cont_a_cre_5 contador1 (result, pulso, value, clear);

// Valores iniciais
initial
  begin
    clear = 1'b1;
    #5 clear = 1'b0;
  end

// Main 
initial 
begin : main 

  $dumpfile ("Guia_1302.vcd");
  $dumpvars ( 1, value, pulso, result, clear);

  $display ( "Guia_1302" );
  $display ( "" );

// Registro dos valores para quando alterados pelo pulso
  //$display ( "| Output | Pulse | Input |" );
  //$display ( "|--------|-------|-------|" );
  //$monitor ( "|  %5b |     %d |     %d |", result, pulso, value );

  #395 $finish;

end // main 

endmodule // Guia_1302


