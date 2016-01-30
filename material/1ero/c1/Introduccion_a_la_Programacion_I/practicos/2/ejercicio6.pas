program Ejercicio6 ;
{
  $Id: ejercicio6.pas,v 1.2 2016/01/30 19:06:47 aosorio Exp $

  Invertir el orden de la fila DADA usando una pila auxiliar.
}

uses Estructu ;

var
  DADA: Fila ;
  AUX: Pila ;

begin
  readFila( DADA ) ;

  while( not filaVacia( DADA ) ) do
    apilar( AUX, extraer( DADA ) ) ;

  while( not pilaVacia( AUX ) ) do
    agregar( DADA, desapilar( AUX ) ) ;

  writeFila( DADA ) ;
end.
