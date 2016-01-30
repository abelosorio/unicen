program Ejercicio5 ;

{
  $Id: ejercicio5.pas,v 1.2 2016/01/30 19:06:46 aosorio Exp $

  Cargar desde el teclado la pila DADA. Invertir la pila de manera que DADA
  contenga los elementos cargados originalmente en ella, pero en orden inverso.
}

uses Estructu ;

var

  DADA:Pila ;
  AUXILIAR1:Pila ;
  AUXILIAR2:Pila ;

begin

  readPila( DADA ) ;
  inicPila( AUXILIAR1, '' ) ;
  inicPila( AUXILIAR2, '' ) ;

  while( not pilaVacia( DADA ) ) do
    apilar( AUXILIAR1, desapilar( DADA ) ) ;

  while( not pilaVacia( AUXILIAR1 ) ) do
    apilar( AUXILIAR2, desapilar( AUXILIAR1 ) ) ;

  while( not pilaVacia( AUXILIAR2 ) ) do
    apilar( DADA, desapilar( AUXILIAR2 ) ) ;

  writePila( DADA ) ;

end.
