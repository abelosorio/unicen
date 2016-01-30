program Ejercicio13 ;
{
  $Id: ejercicio13.pas,v 1.2 2016/01/30 19:06:47 aosorio Exp $

  Concatenar dos pilas de modo que la que posee menos elementos quede abajo; si
  ambas tienen la misma cantidad de elementos, cualquiera puede quedar abajo.
  ¿Convendría resolver el problema con filas en lugar de pilas? Justifique su
  respuesta.

  - Respuesta: ...
}

uses Estructu ;

var
  PILA1, PILA2: Pila ;

begin
  readPila( PILA1 ) ;
  readPila( PILA2 ) ;

  while( not pilaVacia( PILA1 ) ) do
    begin
    apilar( AUX1, desapilar( PILA1 ) ) ;
    if( not pilaVacia( PILA2 ) ) then
      apilar( AUX2, desapilar( PILA2 ) ) ;
    end ;

  if( pilaVacia( PILA1 ) and pilaVacia( PILA2 ) ) then
  { Las pilas son iguales }
    begin
    while( not pilaVacia( PILA1 ) ) do
      apilar( FINAL, desapilar( PILA1 ) ) ;
    while( not pilaVacia( PILA2 ) ) do
      apilar( FINAL, desapilar( PILA2 ) ) ;
    end
  else
    begin
    if( pilaVacia( PILA1 ) and not pilaVacia( PILA2 ) ) then
    { La pila más grande es PILA2 }
      begin
      while( not pilaVacia( PILA1 ) ) do
        apilar( FINAL, desapilar( PILA1 ) ) ;
      while( not pilaVacia( PILA2 ) ) do
        apilar( FINAL, desapilar( PILA2 ) ) ;
      end ;

  writePila( FINAL ) ;
