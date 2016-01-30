program Ejercicio1 ;

{
  $Id: ejercicio1.pas,v 1.2 2016/01/30 19:06:47 aosorio Exp $

  Leer los ejercicios 4 y 5 del Práctico 1, identificar un procedimiento
  común a cada uno de ellos, asignarle un nombre representativo con sus
  respectivos parámetros, codificar el procedimiento y las soluciones.
  {pasar en igual orden e invertir}
}

uses Estructu ;

var
  ORIGEN:Pila ;
  DESTINO:Pila ;
  AUXILIAR:Pila ;

begin

  readPila( ORIGEN ) ;
  inicPila( DESTINO, '' ) ;
  inicPila( AUXILIAR, '' ) ;

  procedure pasar_elementos
  begin
    while( not pilaVacia( ORIGEN ) ) do
      apilar( AUXILIAR, desapilar( ORIGEN ) ) ;

    while( not pilaVacia( AUXILIAR ) ) do
      apilar( DESTINO, desapilar( AUXILIAR ) ) ;
  end ;

  writePila( DESTINO ) ;

end.

{
  $Id: ejercicio1.pas,v 1.2 2016/01/30 19:06:47 aosorio Exp $

  Cargar desde el teclado la pila DADA. Invertir la pila de manera que DADA
  contenga los elementos cargados originalmente en ella, pero en orden inverso.
}

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
