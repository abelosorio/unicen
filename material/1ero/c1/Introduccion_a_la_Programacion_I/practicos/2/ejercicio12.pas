program Ejercicio12 ;
{
  $Id: ejercicio12.pas,v 1.2 2016/01/30 19:06:47 aosorio Exp $

  Ubicar el tope de la estructura DADA debajo del primer elemento de valor 12,
  dejando los demás elementos en el mismo orden. Si el elemento de valor 12 es
  el tope, dejarlo como estaba. Se supone que al menos hay un elemento de
  valor de 12.
}

uses Estructu ;

var
  DADA, TOPE, AUX1: Pila ;

begin
  inicPila( DADA, '8 9 10 11 12 13 14 15 16' ) ;
  inicPila( TOPE, '' ) ;
  inicPila( AUX1, '' ) ;

  apilar( TOPE, tope( DADA ) ) ;
  while( not pilaVacia( DADA ) ) do
    begin
    if( tope( DADA )=12 and tope( TOPE )<>12 ) then
      apilar( AUX1, desapilar( TOPE ) ) ;

    apilar( AUX1, desapilar( DADA ) ) ;
    end ;

  while( not pilaVacia( AUX1 ) ) do
    apilar( DADA, desapilar( AUX1 ) ) ;

  writePila( DADA ) ;
end.
