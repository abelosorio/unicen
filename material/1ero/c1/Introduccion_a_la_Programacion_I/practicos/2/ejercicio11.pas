program Ejercicio11 ;
{
  $Id: ejercicio11.pas,v 1.2 2016/01/30 19:06:47 aosorio Exp $

  Cargar una estructura (pila o fila) MODELO con un solo elemento y otra
  estructura ORIGEN. Modificar ORIGEN tal que si existe un elemento igual al
  de MODELO se lo ubique en el tope. Imprima ORIGEN.
}

uses Estructu ;

var
  MODELO, ORIGEN, AUX1, AUX2: Pila ;

begin
  inicPila( MODELO, '1' ) ;
  readPila( ORIGEN ) ;
  inicPila( AUX1, '' ) ;
  inicPila( AUX2, '' ) ;

  while( not pilaVacia( ORIGEN ) ) do
    begin
    if( tope( ORIGEN ) = tope( MODELO ) ) then
      apilar( AUX1, desapilar( ORIGEN ) )
    else
      apilar( AUX2, desapilar( ORIGEN ) ) ;
    end ;

  while( not pilaVacia( AUX2 ) ) do
    apilar( ORIGEN, desapilar( AUX2 ) ) ;

  apilar( ORIGEN, desapilar( MODELO ) ) ;

  writePila( ORIGEN ) ;
end.
