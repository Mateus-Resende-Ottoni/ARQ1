/* 
Guia_1405.v 
Mateus Resende Ottoni

iverilog -o Guia_1405.vvp Guia_1405.v
vvp Guia_1405.vvp
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


// Conversor paralelo/série (6 bits)
//----------------------------------------
module parelserial_6 (output [5:0] result,
                     input data, input load,
                     input input1, input input2, input input3,
                     input input4, input input5, input input6,
                     input clock, input clear);

// Dados
reg [5:0] result = 6'b000000;
wire [5:0] n_out;
wire [5:0] out;
reg preset  = 1'b0;
wire preset1, preset2, preset3, preset4, preset5, preset6;


// Módulos
and and1 ( preset1,   input1,   load);
and and2 ( preset2,   input2,   load);
and and3 ( preset3,   input3,   load);
and and4 ( preset4,   input4,   load);
and and5 ( preset5,   input5,   load);
and and6 ( preset6,   input6,   load);
dff d1   (  out[0], n_out[0],   data, clock, preset1,  clear);
dff d2   (  out[1], n_out[1], out[0], clock, preset2,  clear);
dff d3   (  out[2], n_out[2], out[1], clock, preset3,  clear);
dff d4   (  out[3], n_out[3], out[2], clock, preset4,  clear);
dff d5   (  out[4], n_out[4], out[3], clock, preset5,  clear);
dff d6   (  out[5], n_out[5], out[4], clock, preset6,  clear);

always @( posedge clock )
  begin
    result <= out;
  end


endmodule
//----------------------------------------





// Modulo principal
module Guia_1405; 

// Definir dados
wire [5:0] result;
wire clock;
reg data = 1'b0;
reg load = 1'b0;
reg clear = 1'b0;
reg input1, input2, input3, input4, input5, input6;

// Modulos iniciais
clock clock1 ( clock );
parelserial_6 deslocador1 (result, data, load, input1, input2, input3, input4, input5, input6, clock, clear);

// Valores iniciais
initial
  begin
    input1 = 1'b0;
    input2 = 1'b0;
    input3 = 1'b0;
    input4 = 1'b0;
    input5 = 1'b0;
    input6 = 1'b0;
    clear = 1'b1;
    #4 clear = 1'b0;
  end

// Main 
initial 
begin : main 

  $dumpfile ("Guia_1405.vcd");
  $dumpvars ( 1, data, clear, clock, result, load);

  $display ( "Guia_1405" );
  $display ( "" );

  $display ( "|    Output   | Input | Load |  Load value |" );
  $display ( "|-------------|-------|------|-------------|" );

// Mudança dos valores
  #003 data = 1'b1;

  #024 data = 1'b0;

  #072 input1 = 1'b1; input3 = 1'b1; input5 = 1'b1; load = 1'b1;
  #002 load = 1'b0; input1 = 1'b0; input3 = 1'b0; input5 = 1'b0;
  #010;

  #072 input2 = 1'b1; input4 = 1'b1; input6 = 1'b1; load = 1'b1;
  #002 load = 1'b0; input2 = 1'b0; input4 = 1'b0; input6 = 1'b0;
  #010;

  #120 $finish;

end // main 

always @( result or posedge load )
  begin
    $display ( "| %b %b %b %b %b %b |    %b  |    %b | %b %b %b %b %b %b |", result[5], result[4], result[3], result[2], result[1], result[0], data, load, input6, input5, input4, input3, input2, input1 );
  end

endmodule // Guia_1405


