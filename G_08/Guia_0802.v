/* 
Guia_0802.v 
855842 - Mateus Resende Ottoni

iverilog -o Guia_0802.vvp Guia_0802.v
vvp Guia_0802.vvp
*/



// Meia Diferença
//----------------------------------------
module half_difference (output s0, output s1,
                   input a, b);

// Saída 1
   xor XOR (	s0,	a,	b);

// Saída 2
   not NOT ( not_a,     a);
   and AND (	s1, not_a,	b);

endmodule
//----------------------------------------

// Diferença completa
//----------------------------------------
module full_difference (output s0, output s1,
                   input a, b, c);

// Dados locais
wire w01, w11, w12;

// Processo
half_difference HD1 ( w01, w11,   a,   b);
half_difference HD2 (  s1, w12, w01,   c); // Saída s1
or         OR  (  s0,      w11, w12); // Saída s0



endmodule
//----------------------------------------

// Modulo de diferença
//----------------------------------------
module f02 (output s1, output s2, output s3,
            output s4, output s5,
            input  a0, b0, a1, b1,
                   a2, b2, a3, b3);

// Dados locais
reg valor0 = 1'b0;
wire res01, res02, res03;

// Processo
full_difference FD1 ( res01, s1, a0, b0, valor0); // Saída s1
full_difference FD2 ( res02, s2, a1, b1,  res01); // Saída s2
full_difference FD3 ( res03, s3, a2, b2,  res02); // Saída s3
full_difference FD4 (    s5, s4, a3, b3,  res03); // Saída s4 e s5

endmodule
//----------------------------------------




// Modulo principal
module Guia_0802; 

// Definir dados
reg a0, b0, a1, b1, a2, b2, a3, b3;
wire w1, w2, w3, w4, w5;

f02    f02_ (w1, w2, w3, w4, w5,
             a0, b0, a1, b1, a2, b2, a3, b3);


 initial
  begin
   a0     = 1'b0;
   b0     = 1'b0;
   a1     = 1'b0;
   b1     = 1'b0;
   a2     = 1'b0;
   b2     = 1'b0;
   a3     = 1'b0;
   b3     = 1'b0;
  end


// Main 
initial 
begin : main 

$display ( "Guia_0802" );

/*	Mostrar valores em tabela				*/
$display ( "" );
$display ( "______________________________" );
$display ( "||    a |    b || diferenca ||" );
$display ( "||------|------||-----------||" );
$monitor ( "|| %b%b%b%b | %b%b%b%b ||     %b%b%b%b%b ||",
              a3, a2, a1, a0,
                         b3, b2, b1, b0,
                                     w5, w4, w3, w2, w1 );
/*								*/

/*	Atualizar valores ( a = 00)	*/

#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;

/*					*/

/*	Atualizar valores ( a = 01)	*/

#1;  a0 = 1'b1;
     b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b0;

#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;

/*					*/

/*	Atualizar valores ( a = 02)	*/

#1;  a0 = 1'b0; a1 = 1'b1;
     b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b0;

#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;

/*					*/

/*	Atualizar valores ( a = 03)	*/

#1;  a0 = 1'b1;
     b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b0;

#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;

/*					*/

/*	Atualizar valores ( a = 04)	*/

#1;  a0 = 1'b0; a1 = 1'b0; a2 = 1'b1;
     b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b0;

#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;

/*					*/

/*	Atualizar valores ( a = 05)	*/

#1;  a0 = 1'b1;
     b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b0;

#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;

/*					*/

/*	Atualizar valores ( a = 06)	*/

#1;  a0 = 1'b0; a1 = 1'b1;
     b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b0;

#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;

/*					*/

/*	Atualizar valores ( a = 07)	*/

#1;  a0 = 1'b1;
     b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b0;

#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;

/*					*/

/*	Atualizar valores ( a = 08)	*/

#1;  a0 = 1'b0; a1 = 1'b0; a2 = 1'b0; a3 = 1'b1;
     b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b0;

#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;

/*					*/

/*	Atualizar valores ( a = 09)	*/

#1;  a0 = 1'b1;
     b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b0;

#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;

/*					*/

/*	Atualizar valores ( a = 10)	*/

#1;  a0 = 1'b0; a1 = 1'b1;
     b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b0;

#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;

/*					*/

/*	Atualizar valores ( a = 11)	*/

#1;  a0 = 1'b1;
     b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b0;

#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;

/*					*/

/*	Atualizar valores ( a = 12)	*/

#1;  a0 = 1'b0; a1 = 1'b0; a2 = 1'b1;
     b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b0;

#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;

/*					*/

/*	Atualizar valores ( a = 13)	*/

#1;  a0 = 1'b1;
     b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b0;

#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;

/*					*/

/*	Atualizar valores ( a = 14)	*/

#1;  a0 = 1'b0; a1 = 1'b1;
     b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b0;

#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;

/*					*/

/*	Atualizar valores ( a = 15)	*/

#1;  a0 = 1'b1;
     b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b0;

#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b0; b3 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b0; b2 = 1'b1;
#1;  b0 = 1'b1;
#1;  b0 = 1'b0; b1 = 1'b1;
#1;  b0 = 1'b1;

/*					*/



end // main 

endmodule // Guia_0802

/*	Previsão de Testes 		*/
/*


______________________________
||    a |    b || diferenca ||
||------|------||-----------||
|| 0000 | 0000 ||     00000 ||
|| 0000 | 0001 ||     11111 ||
|| 0000 | 0010 ||     11110 ||
|| 0000 | 0011 ||     11101 ||
|| 0000 | 0100 ||     11100 ||
|| 0000 | 0101 ||     11011 ||
|| 0000 | 0110 ||     11010 ||
|| 0000 | 0111 ||     11001 ||
|| 0000 | 1000 ||     11000 ||
|| 0000 | 1001 ||     10111 ||
|| 0000 | 1010 ||     10110 ||
|| 0000 | 1011 ||     10101 ||
|| 0000 | 1100 ||     10100 ||
|| 0000 | 1101 ||     10011 ||
|| 0000 | 1110 ||     10010 ||
|| 0000 | 1111 ||     10001 ||
|| 0001 | 0000 ||     00001 ||
|| 0001 | 0001 ||     00000 ||
|| 0001 | 0010 ||     11111 ||
|| 0001 | 0011 ||     11110 ||
|| 0001 | 0100 ||     11101 ||
|| 0001 | 0101 ||     11100 ||
|| 0001 | 0110 ||     11011 ||
|| 0001 | 0111 ||     11010 ||
|| 0001 | 1000 ||     11001 ||
|| 0001 | 1001 ||     11000 ||
|| 0001 | 1010 ||     10111 ||
|| 0001 | 1011 ||     10110 ||
|| 0001 | 1100 ||     10101 ||
|| 0001 | 1101 ||     10100 ||
|| 0001 | 1110 ||     10011 ||
|| 0001 | 1111 ||     10010 ||
|| 0010 | 0000 ||     00010 ||
|| 0010 | 0001 ||     00001 ||
|| 0010 | 0010 ||     00000 ||
|| 0010 | 0011 ||     11111 ||
|| 0010 | 0100 ||     11110 ||
|| 0010 | 0101 ||     11101 ||
|| 0010 | 0110 ||     11100 ||
|| 0010 | 0111 ||     11011 ||
|| 0010 | 1000 ||     11010 ||
|| 0010 | 1001 ||     11001 ||
|| 0010 | 1010 ||     11000 ||
|| 0010 | 1011 ||     10111 ||
|| 0010 | 1100 ||     10110 ||
|| 0010 | 1101 ||     10101 ||
|| 0010 | 1110 ||     10100 ||
|| 0010 | 1111 ||     10011 ||
|| 0011 | 0000 ||     00011 ||
|| 0011 | 0001 ||     00010 ||
|| 0011 | 0010 ||     00001 ||
|| 0011 | 0011 ||     00000 ||
|| 0011 | 0100 ||     11111 ||
|| 0011 | 0101 ||     11110 ||
|| 0011 | 0110 ||     11101 ||
|| 0011 | 0111 ||     11100 ||
|| 0011 | 1000 ||     11011 ||
|| 0011 | 1001 ||     11010 ||
|| 0011 | 1010 ||     11001 ||
|| 0011 | 1011 ||     11000 ||
|| 0011 | 1100 ||     10111 ||
|| 0011 | 1101 ||     10110 ||
|| 0011 | 1110 ||     10101 ||
|| 0011 | 1111 ||     10100 ||
|| 0100 | 0000 ||     00100 ||
|| 0100 | 0001 ||     00011 ||
|| 0100 | 0010 ||     00010 ||
|| 0100 | 0011 ||     00001 ||
|| 0100 | 0100 ||     00000 ||
|| 0100 | 0101 ||     11111 ||
|| 0100 | 0110 ||     11110 ||
|| 0100 | 0111 ||     11101 ||
|| 0100 | 1000 ||     11100 ||
|| 0100 | 1001 ||     11011 ||
|| 0100 | 1010 ||     11010 ||
|| 0100 | 1011 ||     11001 ||
|| 0100 | 1100 ||     11000 ||
|| 0100 | 1101 ||     10111 ||
|| 0100 | 1110 ||     10110 ||
|| 0100 | 1111 ||     10101 ||
|| 0101 | 0000 ||     00101 ||
|| 0101 | 0001 ||     00100 ||
|| 0101 | 0010 ||     00011 ||
|| 0101 | 0011 ||     00010 ||
|| 0101 | 0100 ||     00001 ||
|| 0101 | 0101 ||     00000 ||
|| 0101 | 0110 ||     11111 ||
|| 0101 | 0111 ||     11110 ||
|| 0101 | 1000 ||     11101 ||
|| 0101 | 1001 ||     11100 ||
|| 0101 | 1010 ||     11011 ||
|| 0101 | 1011 ||     11010 ||
|| 0101 | 1100 ||     11001 ||
|| 0101 | 1101 ||     11000 ||
|| 0101 | 1110 ||     10111 ||
|| 0101 | 1111 ||     10110 ||
|| 0110 | 0000 ||     00110 ||
|| 0110 | 0001 ||     00101 ||
|| 0110 | 0010 ||     00100 ||
|| 0110 | 0011 ||     00011 ||
|| 0110 | 0100 ||     00010 ||
|| 0110 | 0101 ||     00001 ||
|| 0110 | 0110 ||     00000 ||
|| 0110 | 0111 ||     11111 ||
|| 0110 | 1000 ||     11110 ||
|| 0110 | 1001 ||     11101 ||
|| 0110 | 1010 ||     11100 ||
|| 0110 | 1011 ||     11011 ||
|| 0110 | 1100 ||     11010 ||
|| 0110 | 1101 ||     11001 ||
|| 0110 | 1110 ||     11000 ||
|| 0110 | 1111 ||     10111 ||
|| 0111 | 0000 ||     00111 ||
|| 0111 | 0001 ||     00110 ||
|| 0111 | 0010 ||     00101 ||
|| 0111 | 0011 ||     00100 ||
|| 0111 | 0100 ||     00011 ||
|| 0111 | 0101 ||     00010 ||
|| 0111 | 0110 ||     00001 ||
|| 0111 | 0111 ||     00000 ||
|| 0111 | 1000 ||     11111 ||
|| 0111 | 1001 ||     11110 ||
|| 0111 | 1010 ||     11101 ||
|| 0111 | 1011 ||     11100 ||
|| 0111 | 1100 ||     11011 ||
|| 0111 | 1101 ||     11010 ||
|| 0111 | 1110 ||     11001 ||
|| 0111 | 1111 ||     11000 ||
|| 1000 | 0000 ||     01000 ||
|| 1000 | 0001 ||     00111 ||
|| 1000 | 0010 ||     00110 ||
|| 1000 | 0011 ||     00101 ||
|| 1000 | 0100 ||     00100 ||
|| 1000 | 0101 ||     00011 ||
|| 1000 | 0110 ||     00010 ||
|| 1000 | 0111 ||     00001 ||
|| 1000 | 1000 ||     00000 ||
|| 1000 | 1001 ||     11111 ||
|| 1000 | 1010 ||     11110 ||
|| 1000 | 1011 ||     11101 ||
|| 1000 | 1100 ||     11100 ||
|| 1000 | 1101 ||     11011 ||
|| 1000 | 1110 ||     11010 ||
|| 1000 | 1111 ||     11001 ||
|| 1001 | 0000 ||     01001 ||
|| 1001 | 0001 ||     01000 ||
|| 1001 | 0010 ||     00111 ||
|| 1001 | 0011 ||     00110 ||
|| 1001 | 0100 ||     00101 ||
|| 1001 | 0101 ||     00100 ||
|| 1001 | 0110 ||     00011 ||
|| 1001 | 0111 ||     00010 ||
|| 1001 | 1000 ||     00001 ||
|| 1001 | 1001 ||     00000 ||
|| 1001 | 1010 ||     11111 ||
|| 1001 | 1011 ||     11110 ||
|| 1001 | 1100 ||     11101 ||
|| 1001 | 1101 ||     11100 ||
|| 1001 | 1110 ||     11011 ||
|| 1001 | 1111 ||     11010 ||
|| 1010 | 0000 ||     01010 ||
|| 1010 | 0001 ||     01001 ||
|| 1010 | 0010 ||     01000 ||
|| 1010 | 0011 ||     00111 ||
|| 1010 | 0100 ||     00110 ||
|| 1010 | 0101 ||     00101 ||
|| 1010 | 0110 ||     00100 ||
|| 1010 | 0111 ||     00011 ||
|| 1010 | 1000 ||     00010 ||
|| 1010 | 1001 ||     00001 ||
|| 1010 | 1010 ||     00000 ||
|| 1010 | 1011 ||     11111 ||
|| 1010 | 1100 ||     11110 ||
|| 1010 | 1101 ||     11101 ||
|| 1010 | 1110 ||     11100 ||
|| 1010 | 1111 ||     11011 ||
|| 1011 | 0000 ||     01011 ||
|| 1011 | 0001 ||     01010 ||
|| 1011 | 0010 ||     01001 ||
|| 1011 | 0011 ||     01000 ||
|| 1011 | 0100 ||     00111 ||
|| 1011 | 0101 ||     00110 ||
|| 1011 | 0110 ||     00101 ||
|| 1011 | 0111 ||     00100 ||
|| 1011 | 1000 ||     00011 ||
|| 1011 | 1001 ||     00010 ||
|| 1011 | 1010 ||     00001 ||
|| 1011 | 1011 ||     00000 ||
|| 1011 | 1100 ||     11111 ||
|| 1011 | 1101 ||     11110 ||
|| 1011 | 1110 ||     11101 ||
|| 1011 | 1111 ||     11100 ||
|| 1100 | 0000 ||     01100 ||
|| 1100 | 0001 ||     01011 ||
|| 1100 | 0010 ||     01010 ||
|| 1100 | 0011 ||     01001 ||
|| 1100 | 0100 ||     01000 ||
|| 1100 | 0101 ||     00111 ||
|| 1100 | 0110 ||     00110 ||
|| 1100 | 0111 ||     00101 ||
|| 1100 | 1000 ||     00100 ||
|| 1100 | 1001 ||     00011 ||
|| 1100 | 1010 ||     00010 ||
|| 1100 | 1011 ||     00001 ||
|| 1100 | 1100 ||     00000 ||
|| 1100 | 1101 ||     11111 ||
|| 1100 | 1110 ||     11110 ||
|| 1100 | 1111 ||     11101 ||
|| 1101 | 0000 ||     01101 ||
|| 1101 | 0001 ||     01100 ||
|| 1101 | 0010 ||     01011 ||
|| 1101 | 0011 ||     01010 ||
|| 1101 | 0100 ||     01001 ||
|| 1101 | 0101 ||     01000 ||
|| 1101 | 0110 ||     00111 ||
|| 1101 | 0111 ||     00110 ||
|| 1101 | 1000 ||     00101 ||
|| 1101 | 1001 ||     00100 ||
|| 1101 | 1010 ||     00011 ||
|| 1101 | 1011 ||     00010 ||
|| 1101 | 1100 ||     00001 ||
|| 1101 | 1101 ||     00000 ||
|| 1101 | 1110 ||     11111 ||
|| 1101 | 1111 ||     11110 ||
|| 1110 | 0000 ||     01110 ||
|| 1110 | 0001 ||     01101 ||
|| 1110 | 0010 ||     01100 ||
|| 1110 | 0011 ||     01011 ||
|| 1110 | 0100 ||     01010 ||
|| 1110 | 0101 ||     01001 ||
|| 1110 | 0110 ||     01000 ||
|| 1110 | 0111 ||     00111 ||
|| 1110 | 1000 ||     00110 ||
|| 1110 | 1001 ||     00101 ||
|| 1110 | 1010 ||     00100 ||
|| 1110 | 1011 ||     00011 ||
|| 1110 | 1100 ||     00010 ||
|| 1110 | 1101 ||     00001 ||
|| 1110 | 1110 ||     00000 ||
|| 1110 | 1111 ||     11111 ||
|| 1111 | 0000 ||     01111 ||
|| 1111 | 0001 ||     01110 ||
|| 1111 | 0010 ||     01101 ||
|| 1111 | 0011 ||     01100 ||
|| 1111 | 0100 ||     01011 ||
|| 1111 | 0101 ||     01010 ||
|| 1111 | 0110 ||     01001 ||
|| 1111 | 0111 ||     01000 ||
|| 1111 | 1000 ||     00111 ||
|| 1111 | 1001 ||     00110 ||
|| 1111 | 1010 ||     00101 ||
|| 1111 | 1011 ||     00100 ||
|| 1111 | 1100 ||     00011 ||
|| 1111 | 1101 ||     00010 ||
|| 1111 | 1110 ||     00001 ||
|| 1111 | 1111 ||     00000 ||


*/
/*					*/