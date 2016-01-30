program Ejercicio14 ;
{ 
  $Id: ejercicio14.pas,v 1.2 2016/01/30 19:06:46 aosorio Exp $

  Determinar si la cantidad de elementos de la pila DADA es par. Si es par,
  pasar el elemento del tope de la pila AUX a la pila PAR y si es impar pasar
  el tope a la pila IMPAR.
}

uses Estructu ;

var
  DADA, AUX, PAR, IMPAR, AUX1, AUX2 : Pila ;

begin
  inicPila( AUX, '1' ) ;
  inicPila( AUX1, '1' ) ;
  inicPila( AUX2, '1' ) ;
  inicPila( PAR, '' ) ;
  inicPila( IMPAR, '' ) ;
  readPila( DADA ) ;

  { Primero paso los elementos de DADA a AUX1 y AUX2 en partes
    iguales. Es decir, divido DADA por 2. }
  while( not pilaVacia( DADA ) ) do
  begin
    apilar( AUX1, desapilar( DADA ) ) ;
    if( not pilaVacia( DADA ) ) then
      apilar( AUX2, desapilar( DADA ) ) ;
  end ;

  { Después voy desapilando AUX1 y AUX2 hasta que alguna se vacíe.
    Si una está vacía y la otra no, significa que la división por dos tiene
    resto, es decir, la pila DADA era IMPAR. Si las dos pilas se vacían
    entonces DADA era PAR }
  while( not pilaVacia( AUX1 ) and not pilaVacia( AUX2 ) ) do
  begin
    desapilar( AUX1 ) ;
    desapilar( AUX2 ) ;
  end ;

  if( pilaVacia( AUX1 ) and pilaVacia( AUX2 ) ) then
    apilar( PAR, desapilar( AUX ) )
  else
    apilar( IMPAR, desapilar( AUX ) ) ;

  writePila( PAR ) ;
  writePila( IMPAR ) ;
end.
