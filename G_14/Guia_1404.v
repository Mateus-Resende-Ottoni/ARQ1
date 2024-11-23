/* 
Guia_1404.v 
Mateus Resende Ottoni

iverilog -o Guia_1404.vvp Guia_1404.v
vvp Guia_1404.vvp
*/


// Clock
//----------------------------------------
module clock (output signal);

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


// Flip-Flop D
//----------------------------------------
module dff (output q, output qnot,
            input d,
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
      begin
        q <= d;
        qnot <= ~d;
      end

  end


endmodule
//----------------------------------------


// Registrador de deslocamento circular (6 bits)
//----------------------------------------
module desloc_twistedring_6 (output [5:0] result,
                     input data,
                     input clock, input clear);

// Dados
reg [5:0] result = 6'b000000;
wire [5:0] n_out;
wire [5:0] out;
reg preset  = 1'b0;
wire insert;

// Módulos
or or1 ( insert, data, out[5]);
dff d1 ( out[0], n_out[0], insert, clock, preset,  clear);
dff d2 ( out[1], n_out[1], out[0], clock, preset,  clear);
dff d3 ( out[2], n_out[2], out[1], clock, preset,  clear);
dff d4 ( out[3], n_out[3], out[2], clock, preset,  clear);
dff d5 ( out[4], n_out[4], out[3], clock, preset,  clear);
dff d6 ( out[5], n_out[5], out[4], clock, preset,  clear);

always @( posedge clock )
  begin
    result <= out;
  end


endmodule
//----------------------------------------





// Modulo principal
module Guia_1404; 

// Definir dados
wire [5:0] result;
wire clock;
reg data = 1'b0;
reg clear = 1'b0;

// Modulos iniciais
clock clock1 ( clock );
desloc_twistedring_6 deslocador1 (result, data, clock, clear);

// Valores iniciais
initial
  begin
    clear = 1'b1;
    #4 clear = 1'b0;
  end

// Main 
initial 
begin : main 

  $dumpfile ("Guia_1404.vcd");
  $dumpvars ( 1, data, clear, clock, result);

  $display ( "Guia_1404" );
  $display ( "" );

  $display ( "|    Output   |  Input |" );
  $display ( "|-------------|--------|" );

// Mudança dos valores
  #003 data = 1'b0;
  #012 data = 1'b1;
  #012 data = 1'b0;

  #024 data = 1'b1;
  #012 data = 1'b0; 

  #120 $finish;

end // main 

always @( result )
  begin
    $display ( "| %b %b %b %b %b %b |     %b  |", result[5], result[4], result[3], result[2], result[1], result[0], data);
  end

endmodule // Guia_1404


