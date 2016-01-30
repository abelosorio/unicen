program Ejercicio4 ;
{
  $Id: ejercicio4.pas,v 1.2 2016/01/30 19:06:47 aosorio Exp $

  Pasar los elementos de la fila ORIGEN a la pila DESTINO.
}

uses Estructu ;

var
  ORIGEN: Fila ;
  DESTINO: Pila ;

begin
  readFila( ORIGEN ) ;
  readPila( DESTINO ) ;

  while( not filaVacia( ORIGEN ) ) do
    apilar( DESTINO, extraer( ORIGEN ) ) ;

  writePila( DESTINO ) ;
end.
