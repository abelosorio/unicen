program Ejercicio8 ;

{
  $Id: ejercicio8.pas,v 1.2 2016/01/30 19:06:46 aosorio Exp $

  Repartir los elementos de la pila POZO en las pilas JUGADOR1 y JUGADOR2 en
  forma alternativa.
}

uses Estructu ;

var
  POZO:Pila ;
  JUGADOR1:Pila ;
  JUGADOR2:Pila ;

begin

  readPila( POZO ) ;
  inicPila( JUGADOR1, '' ) ;
  inicPila( JUGADOR2, '' ) ;

  while( not pilaVacia( POZO ) ) do
  begin
    apilar( JUGADOR1, desapilar( POZO ) ) ;
    if( not pilaVacia( POZO ) ) then
      apilar( JUGADOR2, desapilar( POZO ) ) ;
  end ;

  writePila( JUGADOR1 ) ;
  writePila( JUGADOR2 ) ;

end.
