program Ejercicio10 ;

{
  $Id: ejercicio10.pas,v 1.2 2016/01/30 19:06:46 aosorio Exp $

  Comparar las pilas A y B. Si son iguales dejar el tope de la pila AUX en la
  pila VERDADERO y si son distintas en FALSO.
}

uses Estructu ;

var
  A:pila ;
  B:Pila ;
  AUX:Pila ;
  VERDADERO:Pila ;
  FALSO:Pila ;

begin

  readPila( A ) ;
  readPila( B ) ;
  inicPila( VERDADERO, '' ) ;
  inicPila( FALSO, '' ) ;
  inicPila( AUX, '5' ) ;

  apilar( VERDADERO, tope( AUX ) ) ;

  while( not ( pilaVacia( A ) or pilaVacia( B ) ) ) do
  begin
    if( tope( A ) <> tope( B ) ) then
      if( not pilaVacia( VERDADERO ) ) then
        apilar( FALSO, desapilar( VERDADERO ) ) ;
    desapilar( A ) ;
    desapilar( B ) ;
  end ;

  if( not pilaVacia( A ) and not pilaVacia( B ) ) then
    if( not pilaVacia( VERDADERO ) ) then
      apilar( FALSO, desapilar( VERDADERO ) ) ;

  writePila( VERDADERO ) ;
  writePila( FALSO ) ;

end.
