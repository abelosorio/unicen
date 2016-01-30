program ejercicio4 ;
{
  $Id: ejercicio4.pas,v 1.2 2016/01/30 19:06:35 aosorio Exp $

  4) Para verificar que un arreglo es capicúa de manera recursiva se sigue la
  siguiente estrategia. Un arreglo es capicúa si el primer elemento es igual
  al último y si el “subarreglo” que queda entre estos dos elementos
  también es capicúa. Ejemplo:
		5<subarreglo interior>5
  Para poder plantearlo recursivamente, la clave está en poder aplicar la misma
  estrategia para verificar si el subarreglo interior es capicúa. Piense cómo
  solucionar este último problema, plantee cuándo “cortar” la recursión y
  codifique la solución.
}

uses
  sysutils ;

type
  arreglo_enteros = array[1..10] of integer ;

var
  caracter, i : integer ;
  arreglo : arreglo_enteros ;

function es_capicua( arreglo : arreglo_enteros ;
                     desde : integer ;
                     hasta : integer ) : boolean ;
begin
  if ( hasta-desde <= 1 ) then
    es_capicua := ( arreglo[desde] = arreglo[hasta] )
  else begin
    if ( arreglo[desde] = arreglo[hasta] ) and
         es_capicua( arreglo, desde + 1, hasta - 1 ) then
      es_capicua := true
    else
      es_capicua := false ;
  end ;
end ;

begin
  writeln( 'Ingrese las cifras de un número para saber si es capicúa: ' ) ;

  for i := 1 to 10 do begin
    write( 'Cifra ', i, ': ' ) ;
    readln( caracter ) ;
    arreglo[i] := caracter ;
  end ;

  if ( es_capicua( arreglo, 1, 10 ) ) then
    writeln( 'Es capicúa' )
  else
    writeln( 'No es capicúa' )
end.
