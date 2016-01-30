program Ejercicio12 ;

{
  $Id: ejercicio12.pas,v 1.2 2016/01/30 19:06:46 aosorio Exp $

  Suponiendo la existencia de una pila MODELO (vacía o no), eliminar de la
  pila DADA todos los elementos que existan en MODELO.
}

uses Estructu ;

var

  MODELO,DADA,AUX1,AUX2:Pila ;

begin

  inicPila( MODELO, '1 2 3 4 5 6 7 8 9 0' ) ;
  inicPila( AUX1, '' ) ;
  inicPila( AUX2, '' ) ;
  readPila( DADA ) ;

  { Recorro la pila DADA }
  while( not pilaVacia( DADA ) ) do
  begin
    { Comparo cada elemento de DADA con todos los elementos de MODELO }
    while( not pilaVacia( MODELO ) ) do
    begin
      { Si el elemento es igual, lo saco. Sino, lo guardo en AUX1 }
      if( tope( DADA ) = tope( MODELO ) ) then
        if( not pilaVacia( DADA ) ) then desapilar( DADA )
      else
        if( not pilaVacia( DADA ) ) then apilar( AUX1, desapilar( DADA ) ) ;

      apilar( AUX2, desapilar( MODELO ) ) ;
    end ;
    { Paso los elementos de AUX2 a MODELO para volver a comparar }
    while( not pilaVacia( AUX2 ) ) do
      apilar( MODELO, desapilar( AUX2 ) ) ;
  end ;

  writePila( DADA ) ;

end.
