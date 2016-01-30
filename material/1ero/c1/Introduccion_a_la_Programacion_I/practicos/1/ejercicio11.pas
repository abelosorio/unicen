program Ejercicio11 ;

{
  $Id: ejercicio11.pas,v 1.2 2016/01/30 19:06:46 aosorio Exp $

  Suponiendo la existencia de una pila MODELO que no esté vacía, eliminar de
  la pila DADA todos los elementos que sean iguales al tope de la pila MODELO.
}

uses Estructu ;

var
  MODELO:Pila ;
  DADA:Pila ;
  AUX:Pila ;

begin

  inicPila( MODELO, '1 2 3 4 5' ) ;
  readPila( DADA ) ;

  { Paso los elementos distintos al tope de MODELO a AUX }
  while( not pilaVacia( DADA ) ) do
    if( tope( DADA ) = tope( MODELO ) ) then
      desapilar( DADA )
    else
      apilar( AUX, desapilar( DADA ) ) ;

  { Paso los elementos de AUX a DADA }
  while( not pilaVacia( AUX ) ) do
    apilar( DADA, desapilar( AUX ) ) ;

  writePila( DADA ) ;

end.
