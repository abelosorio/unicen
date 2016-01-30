program Ejercicio1 ;

{
  $Id: ejercicio1.pas,v 1.2 2016/01/30 19:06:46 aosorio Exp $

  Cargar desde el teclado una pila DADA con 5 elementos. Pasar los tres
  primeros elementos a la pila CJTO1 y los dos restantes a la pila CJTO2,
  ambas pilas inicializadas en vacío.
}

uses Estructu ;

var
  DADA:Pila ;
  CJTO1:Pila ;
  CJTO2:Pila ;

begin

  readPila( DADA ) ;
  inicPila( CJTO1, '' ) ;
  inicPila( CJTO2, '' ) ;

  if( not pilaVacia( DADA ) ) then
    apilar( CJTO1, desapilar( DADA ) ) ;
  if( not pilaVacia( DADA ) ) then
    apilar( CJTO1, desapilar( DADA ) ) ;
  if( not pilaVacia( DADA ) ) then
    apilar( CJTO1, desapilar( DADA ) ) ;

  if( not pilaVacia( DADA ) ) then
    apilar( CJTO2, desapilar( DADA ) ) ;
  if( not pilaVacia( DADA ) ) then
    apilar( CJTO2, desapilar( DADA ) ) ;

  writePila( CJTO1 ) ;
  writePila( CJTO2 ) ;

end.
