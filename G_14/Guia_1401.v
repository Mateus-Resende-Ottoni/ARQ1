/* 
Guia_1401.v 
Mateus Resende Ottoni

iverilog -o Guia_1401.vvp Guia_1401.v
vvp Guia_1401.vvp
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


// Registrador de deslocamento para a esquerda (6 bits)
//----------------------------------------
module desloc_esq_6 (output [5:0] result,
                     input data, input load,
                     input clock, input clear);

// Dados
reg [5:0] result = 6'b000000;
wire [5:0] n_out;
wire [5:0] out;
reg preset0 = 1'b0;
reg preset1 = 1'b1;
reg preset  = 1'b0;

// Módulos
dff d1 ( out[0], n_out[0],   data, clock,  preset, clear);
dff d2 ( out[1], n_out[1], out[0], clock, preset0, clear);
dff d3 ( out[2], n_out[2], out[1], clock, preset0, clear);
dff d4 ( out[3], n_out[3], out[2], clock, preset0, clear);
dff d5 ( out[4], n_out[4], out[3], clock, preset0, clear);
dff d6 ( out[5], n_out[5], out[4], clock, preset0, clear);

always @( posedge clock )
  begin
    result <= out;
    if ( load )
      begin
        preset = preset1;
      end
    else
      begin
        preset = preset0;
      end
  end


endmodule
//----------------------------------------





// Modulo principal
module Guia_1401; 

// Definir dados
wire [5:0] result;
wire clock;
reg value = 1'b1;
reg data = 1'b1;
reg load = 1'b0;
reg clear = 1'b0;

// Modulos iniciais
clock clock1 ( clock );
desloc_esq_6 deslocador1 (result, data, load, clock, clear);

// Valores iniciais
initial
  begin
    clear = 1'b1;
    #4 clear = 1'b0;
  end

// Main 
initial 
begin : main 

  $dumpfile ("Guia_1401.vcd");
  $dumpvars ( 1, data, load, clear, clock, result);

  $display ( "Guia_1401" );
  $display ( "" );

  $display ( "|    Output   | Load |  Input |" );
  $display ( "|-------------|------|--------|" );

// Mudança dos valores
  #003 data = 1'b1; 
  #012 data = 1'b0; 
  #012 load = 1'b1;
  #012 data = 1'b1; load = 1'b0;
  #012 data = 1'b0;

  #120 $finish;

end // main 

always @( result )
  begin
    $display ( "| %b %b %b %b %b %b |    %b |     %b  |", result[5], result[4], result[3], result[2], result[1], result[0], load, data);
  end

endmodule // Guia_1401


