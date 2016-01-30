program Ejercicio4 ;
{
  $Id: ejercicio4.pas,v 1.2 2016/01/30 19:06:47 aosorio Exp $

  Realizar un procedimiento / función (según corresponda) que inserte un
  caracter en un arreglo ordenado alfabéticamente, conservando el orden.
}

const
  LETRAS_ALFABETO : integer = 27 ;
  ALFABETO : array[1..LETRAS_ALFABETO] of char =
    [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
      'ñ', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' ] ;

var
  I : integer ;

function pertenece_alfabeto( LETRA : char ) : boolean ;
begin
  pertenece_alfabeto := FALSE ;
  for I := 1 to LETRAS_ALFABETO do
    if( LETRA = ALFABETO[I] ) then
      pertenece_alfabeto := TRUE ;
end ;

function posicion_alfabeto( LETRA : char ) : integer ;
begin
  posicion_alfabeto := -1 ;

  for I := 1 to LETRAS_ALFABETO do
    if( LETRA = ALFABETO[I] ) then
      posicion_alfabeto := I ;
end ;

begin

