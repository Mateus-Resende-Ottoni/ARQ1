/* 
Guia_1205.v 
855842 - Mateus Resende Ottoni

iverilog -o Guia_1205.vvp Guia_1205.v
vvp Guia_1205.vvp
*/

`include "Clock.v"


// Flip-Flop JK
//----------------------------------------
module jkff (output q, output qnot,
            input j, input k,
            input clock, input preset, input clear);	

// Dados
reg q, qnot;

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
          else
            if ( ~j & ~k )
              begin
                q <= 0;
                qnot <= 1;
              end

  end


endmodule
//----------------------------------------

// Ram 1x1
//----------------------------------------
module ram1x1 (output result,
               input address, input value,
               input clock, input read_write, input clear);

// Dados
wire storage, not_storage; // Valor guardado
wire key; // Valor para representar se r/w, adress e clock estão ativos
wire in_address;
reg k = 1'b0;
reg zero = 1'b0;
reg result = 1'b0;

// Atribuições
and  and1 ( key, address, read_write, clock );
jkff ram1 ( storage, not_storage, value, k, key, zero, clear );
and  and2 ( in_address, address, storage );

initial
  begin
    k <= value;
  end

// Processo
always @ ( clock or posedge clear or address or read_write )
  begin

    if ( storage )
      begin
        k <= ~value;
      end
    else
      begin
        k <= value;
      end

    if ( address )
      begin
        result <= in_address;
      end
    else
      begin
        result <= zero;
      end

  end


endmodule
//----------------------------------------

// Ram 1x4
//----------------------------------------
module ram1x4 (output [3:0] result,
               input address, input [3:0] value,
               input clock, input read_write, input clear);

// Dados
wire [3:0] result; wire [3:0] value;

// Módulos
ram1x1 ram1 (result[0], address, value[0], clock, read_write, clear);
ram1x1 ram2 (result[1], address, value[1], clock, read_write, clear);
ram1x1 ram3 (result[2], address, value[2], clock, read_write, clear);
ram1x1 ram4 (result[3], address, value[3], clock, read_write, clear);


endmodule
//----------------------------------------

// Ram 1x8
//----------------------------------------
module ram1x8 (output [7:0] result,
               input address, input [7:0] value,
               input clock, input read_write, input clear);

// Dados
wire [7:0] result; wire [7:0] value;

// Módulos
ram1x4 ram1 (result[3:0], address, value[3:0], clock, read_write, clear);
ram1x4 ram2 (result[7:4], address, value[7:4], clock, read_write, clear);


endmodule
//----------------------------------------

// Ram 2x8
//----------------------------------------
module ram2x8 (output [7:0] result,
               input address, input [7:0] value,
               input clock, input read_write, input clear);

// Dados
wire [7:0] result1; wire [7:0] result2; reg [7:0] result;
wire [7:0] value;
reg address1, address2;

// Módulos
ram1x8 ram1 (result1, address1, value, clock, read_write, clear);
ram1x8 ram2 (result2, address2, value, clock, read_write, clear);

// Valor inicial
initial
  begin
    address1 = 1'b0;
    address2 = 1'b0;
  end

// Atualizar valores
always @ ( clock or address or read_write or posedge clear ) 
  begin
    if ( address )
      begin
        address1 = 1'b1;
        address2 = 1'b0;
        result = result1;
      end
    else
      begin
        address1 = 1'b0;
        address2 = 1'b1;
        result = result2;
      end

  end

endmodule
//----------------------------------------

// Ram 4x8
//----------------------------------------
module ram4x8 (output [7:0] result,
               input [1:0] address, input [7:0] value,
               input clock, input read_write, input clear);

// Dados
wire [7:0] result1; wire [7:0] result2; reg [7:0] result;
wire [7:0] value;
reg address1, address2;
reg r_w1, r_w2;

// Módulos
ram2x8 ram1 (result1, address1, value, clock, r_w1, clear);
ram2x8 ram2 (result2, address2, value, clock, r_w2, clear);

// Valor inicial
initial
  begin
    address1 = 1'b0;
    address2 = 1'b0;
    r_w1     = 1'b0;
    r_w2     = 1'b0;
  end

// Atualizar valores
always @ ( clock or address or read_write or posedge clear ) 
  begin
    if ( address[0] )
      begin
        r_w1 = read_write;
        r_w2 = 1'b0;

        address1 = address[1];
        address2 = 1'b0;

        result = result1;
      end
    else
      begin
        r_w1 = 1'b0;
        r_w2 = read_write;

        address1 = 1'b0;
        address2 = address[1];

        result = result2;
      end

  end

endmodule
//----------------------------------------

// Ram 8x8
//----------------------------------------
module ram8x8 (output [7:0] result,
               input [2:0] address, input [7:0] value,
               input clock, input read_write, input clear);

// Dados
wire [7:0] result1; wire [7:0] result2; reg [7:0] result;
wire [7:0] value;
reg [1:0] address1;
reg [1:0] address2;
reg r_w1, r_w2;

// Módulos
ram4x8 ram1 (result1, address1, value, clock, r_w1, clear);
ram4x8 ram2 (result2, address2, value, clock, r_w2, clear);

// Valor inicial
initial
  begin
    address1 = 2'b00;
    address2 = 2'b00;
    r_w1     = 1'b0;
    r_w2     = 1'b0;
  end

// Atualizar valores
always @ ( clock or address or read_write or posedge clear ) 
  begin
    if ( address[0] )
      begin
        r_w1 = read_write;
        r_w2 = 1'b0;

        address1 = address[2:1];
        address2 = 2'b00;

        result = result1;
      end
    else
      begin
        r_w1 = 1'b0;
        r_w2 = read_write;

        address1 = 2'b00;
        address2 = address[2:1];

        result = result2;
      end

  end

// Conferir valores
//always @ ( posedge clock )
//  begin
//    $display ( "value: %b, address: %b, address1: %b, address2: %b and result: %b", value, address, address1, address2, result ); 
//  end

endmodule
//----------------------------------------



// Modulo principal
module Guia_1205; 

// Definir dados
wire clock;
reg [7:0] value; wire [7:0] result;
reg [2:0] address; reg read_write;
reg clear;


// Modulos iniciais
clock clk (clock);
ram8x8 ram (result, address, value, clock, read_write, clear);


// Valores iniciais
initial
  begin
    value        = 8'b00000000;
    address      = 3'b000;
    read_write   = 1'b0;
    clear        = 1'b0;
  end


// Main 
initial 
begin : main 

  $dumpfile ("Guia_1205.vcd");
  $dumpvars ( 1, clock, result, address, value, read_write, clear);

  //$display ( "Guia_1205" );
  //$display ( "" );

// Alternadamente salvar valores e os ler
  #003 address = 3'b000; value = 8'b00000001; read_write = 1'b1;
  #012 address = 3'b001; value = 8'b00001000;
  #012 address = 3'b010; value = 8'b00010000;
  #012 address = 3'b100; value = 8'b10000000;
  #012 address = 3'b000; value = 8'b00000000; read_write = 1'b0;
  #012 address = 3'b001;
  #012 address = 3'b010;
  #012 address = 3'b100;

  #012 address = 3'b000; value = 8'b00000010; read_write = 1'b1;
  #012 address = 3'b001; value = 8'b00000100;
  #012 address = 3'b010; value = 8'b00100000;
  #012 address = 3'b100; value = 8'b01000000;
  #012 address = 3'b000; value = 8'b00000000; read_write = 1'b0;
  #012 address = 3'b001;
  #012 address = 3'b010;
  #012 address = 3'b100;


  #012 $finish;

end // main 

endmodule // Guia_1205


