program Ejercicio13 ;
{
  $Id: ejercicio13.pas,v 1.2 2016/01/30 19:06:46 aosorio Exp $

  Suponiendo la existencia de una pila LIMITE, pasar los elementos de la pila
  DADA que sean mayores o iguales que el tope de LIMITE a la pila MAYORES, y
  los elementos que sean menores a la pila MENORES.
}

uses Estructu ;

var
  LIMITE, DADA, MAYORES, MENORES: Pila ;

begin
  inicPila( MAYORES, '' ) ;
  inicPila( MENORES, '' ) ;
  inicPila( LIMITE, '1 2 3 4 5 6 7 8 9' ) ;
  readPila( DADA ) ;

  while( not pilaVacia( DADA ) ) do
  begin
    if( tope( DADA ) >= tope( LIMITE ) ) then
      apilar( MAYORES, desapilar( DADA ) )
    else
      apilar( MENORES, desapilar( DADA ) ) ;
  end ;

  writePila( MAYORES ) ;
  writePila( MENORES ) ;

end.
