/* 
Guia_1305.v 
855842 - Mateus Resende Ottoni

iverilog -o Guia_1305.vvp Guia_1305.v
vvp Guia_1305.vvp
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


// Flip-Flop Toggle
//----------------------------------------
module tff (output q, output qnot,
            input t,
            input clock, input preset, input clear);	

// Dados
reg q, qnot;

initial
  begin
    q = 1'b0;
    qnot = 1'b1;
  end

// Processo
always @ ( posedge clock or preset or clear )
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
      if ( t )
        begin
          q <= ~q;
          qnot <= ~qnot;
        end

  end


endmodule
//----------------------------------------


// Contador Síncrono Crescente (7 bits)
//----------------------------------------
module cont_s_cre_7 (output [6:0] result,
                     input pulse, input one, input clear);

// Dados
reg [6:0] result = 7'b0000000;
wire [6:0] n_out;
wire [6:0] out;
wire t1, t2, t3, t4, t5;
reg preset = 1'b0;;

// Módulos
tff  tf1 ( out[0], n_out[0],    one, pulse, preset, clear);
tff  tf2 ( out[1], n_out[1], out[0], pulse, preset, clear);
tff  tf3 ( out[2], n_out[2],     t1, pulse, preset, clear);
tff  tf4 ( out[3], n_out[3],     t2, pulse, preset, clear);
tff  tf5 ( out[4], n_out[4],     t3, pulse, preset, clear);
tff  tf6 ( out[5], n_out[5],     t4, pulse, preset, clear);
tff  tf7 ( out[6], n_out[6],     t5, pulse, preset, clear);
and and1 (     t1,   out[0], out[1]);
and and2 (     t2,       t1, out[2]);
and and3 (     t3,       t2, out[3]);
and and4 (     t4,       t3, out[4]);
and and5 (     t5,       t4, out[5]);

always @( posedge pulse )
  begin
    result <= out;
  end


endmodule
//----------------------------------------





// Modulo principal
module Guia_1305; 

// Definir dados
wire [6:0] result;
wire pulso;
reg value = 1'b1;
reg clear = 1'b0;

// Modulos iniciais
pulse pulso1 ( pulso );
cont_s_cre_7 contador1 (result, pulso, value, clear);

// Valores iniciais
initial
  begin
    clear = 1'b1;
    #5 clear = 1'b0;
  end

// Main 
initial 
begin : main 

  $dumpfile ("Guia_1305.vcd");
  $dumpvars ( 1, value, pulso, result, clear);

  $display ( "Guia_1305" );
  $display ( "" );

// Registro dos valores para quando alterados pelo pulso
  //$display ( "|   Output  | Pulse | Input |" );
  //$display ( "|-----------|-------|-------|" );
  //$monitor ( "|   %7b |     %d |     %d |", result, pulso, value );

  #740 $finish;

end // main 

endmodule // Guia_1305


