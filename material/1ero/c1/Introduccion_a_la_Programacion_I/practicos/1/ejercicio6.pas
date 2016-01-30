program Ejercicio6 ;
{
  $Id: ejercicio6.pas,v 1.2 2016/01/30 19:06:46 aosorio Exp $

  Pasar el primer elemento (tope) de la pila DADA a su última posición (base),
  dejando los restantes elementos en el mismo orden.
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

  if( not pilaVacia( DADA ) ) then
    apilar( AUXILIAR1, desapilar( DADA ) ) ;

  while( not pilaVacia( DADA ) ) do
    apilar( AUXILIAR2, desapilar( DADA ) ) ;

  if( not pilaVacia( AUXILIAR1 ) ) then
    apilar( DADA, desapilar( AUXILIAR1 ) ) ;

  while( not pilaVacia( AUXILIAR2 ) ) do
    apilar( DADA, desapilar( AUXILIAR2 ) ) ;

  writePila( DADA ) ;
end.
