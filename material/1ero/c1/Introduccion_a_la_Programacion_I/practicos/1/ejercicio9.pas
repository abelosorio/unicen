program Ejercicio9 ;

{

  $Id: ejercicio9.pas,v 1.2 2016/01/30 19:06:47 aosorio Exp $

  Comparar la cantidad de elementos de las pilas A y B. Si son iguales dejar
  el tope de la pila AUX en la pila VERDADERO y son distintas en la pila FALSO.
}

uses Estructu ;

var
  A:Pila ;
  B:Pila ;
  V:Pila ;
  F:Pila ;
  AUX:Pila ;

begin

  readPila( A ) ;
  readPila( B ) ;
  inicPila( AUX, '5' ) ;
  inicPila( V, '' ) ;
  inicPila( F, '' ) ;

  { Desapilo hasta que alguna de las pilas se vacíe }
  while( not pilaVacia( A ) and not pilaVacia( B ) ) do
  begin
    desapilar( A ) ;
    desapilar( B ) ;
  end ;

  { Si están las 2 vacías es porque eran iguales, sino no }
  if( pilaVacia( A ) and pilaVacia( B ) ) then
  begin
    apilar( V, desapilar( AUX ) ) ;
  end
  else
  begin
    apilar( F, desapilar( AUX ) ) ;
  end ;

  writePila( V ) ;
  writePila( F ) ;

end.
