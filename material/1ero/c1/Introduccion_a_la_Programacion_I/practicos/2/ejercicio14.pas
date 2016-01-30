program Ejercicio14 ;
{
  $Id: ejercicio14.pas,v 1.2 2016/01/30 19:06:47 aosorio Exp $

  Una pila ORIGINAL y otra COPIA contienen los mismos elementos aunque en
  distinto orden. Redisponer los elementos de COPIA para que resulte una
  reproducción de ORIGINAL.
}

uses Estructu ;

var
  ORIGINAL, COPIA, AUX1, AUX2: Pila ;
  COPIAAUX: Fila ;

begin
  inicPila( ORIGINAL, '2 4 1 3 0 5 7 9 6 8' ) ;
  inicPila( COPIA, '3 4 7 5 9 1 8 0 2 6' ) ;
  inicPila( AUX1, '' ) ;
  inicPila( AUX2, '' ) ;
  inicFila( COPIAAUX, '' ) ;

  { Paso la pila COPIA a una fila COPIAAUX para poder iterar cíclicamente
    sobre la mísma hasta ordenar la pila COPIA }
  while( not pilaVacia( COPIA ) ) do
    agregar( COPIAAUX, desapilar( COPIA ) ) ;

  { Itero sobre la pila ORIGINAL buscando cada elemento en la fila COPIAAUX.
    Los elementos iguales los voy pasando a pilas auxiliares que tendrán el
    orden inverso a la pila ORIGINAL }
  while( not pilaVacia( ORIGINAL ) ) do
    begin
    if( tope( ORIGINAL ) = primero( COPIAAUX ) ) then
      begin
      apilar( AUX1, desapilar( ORIGINAL ) ) ;
      apilar( AUX2, extraer( COPIAAUX ) ) ;
      end 
    else
      agregar( COPIAAUX, extraer( COPIAAUX ) ) ;
    end ;

  { Finalmente invierto el orden de las pilas auxiliares para tener el orden
    de ORIGINAL }
  while( not( pilaVacia( AUX1 ) ) ) do
    apilar( ORIGINAL, desapilar( AUX1 ) ) ;

  while( not( pilaVacia( AUX2 ) ) ) do
    apilar( COPIA, desapilar( AUX2 ) ) ;

  writePila( ORIGINAL ) ;
  writePila( COPIA ) ;
end.
