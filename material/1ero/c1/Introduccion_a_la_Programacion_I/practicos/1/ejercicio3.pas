program Ejercicio3 ;

{
  $Id: ejercicio3.pas,v 1.2 2016/01/30 19:06:46 aosorio Exp $

  Cargar desde teclado una pila DADA y pasar a la pila DISTINTOS todos
  aquellos elementos distintos al valor 8.
}

uses Estructu ;

var
  DADA:Pila ;
  DISTINTOS:Pila ;
  AUXILIAR:Pila ;

begin

  readPila( DADA ) ;
  inicPila( DISTINTOS, '' ) ;
  inicPila( AUXILIAR, '' ) ;

  while( not pilaVacia( DADA ) ) do
    if( tope( DADA ) <> 8 ) then
      apilar( DISTINTOS, desapilar( DADA ) )
    else
      apilar( AUXILIAR, desapilar( DADA ) ) ;

  writePila( DISTINTOS ) ;

end.
