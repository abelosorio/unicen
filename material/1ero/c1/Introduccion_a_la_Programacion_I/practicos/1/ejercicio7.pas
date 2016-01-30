program Ejercicio7 ;

{
  $Id: ejercicio7.pas,v 1.2 2016/01/30 19:06:46 aosorio Exp $

  Pasar el último elemento (base) de la pila DADA a su primera posición (tope),
  dejando los restantes elementos en el mismo orden.
}

uses Estructu ;

var
  DADA:Pila ;
  AUX1:Pila ;
  AUX2:Pila ;

begin

  readPila( DADA ) ;
  inicPila( AUX1, '' ) ;
  inicPila( AUX2, '' ) ;

  { Paso todos los elementos de DADA a AUX1 }
  while( not pilaVacia( DADA ) ) do
    apilar( AUX1, desapilar( DADA ) ) ;

  { Paso el tope de AUX1 (que es la base de DADA) a AUX2 }
  if( not pilaVacia( AUX1 ) ) then
    apilar( AUX2, desapilar( AUX1 ) ) ;

  { Paso los elementos de AUX1 de nuevo a DADA }
  while( not pilaVacia( AUX1 ) ) do
    apilar( DADA, desapilar( AUX1 ) ) ;

  { Paso la ex base de DADA ahora como tope }
  if( not pilaVacia( AUX2 ) ) then
    apilar( DADA, desapilar( AUX2 ) ) ;

  writePila( DADA ) ;

end.
