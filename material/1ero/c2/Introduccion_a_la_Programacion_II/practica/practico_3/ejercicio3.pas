program ejercicio3 ;
{
  $Id: ejercicio3.pas,v 1.2 2016/01/30 19:06:34 aosorio Exp $

  3) Dado un arreglo de caracteres, cargar todos los elementos del arreglo en
  una lista vinculada.
}

const
  CANT_CHAR = 10 ;

type
  arreglo_char = array [1..CANT_CHAR] of char ;
  puntero_lista = ^lista_char ;
  lista_char = record
    valor : char ;
    siguiente : puntero_lista ;
  end ;

var
  puntero : puntero_lista ;
  arreglo : arreglo_char ;

procedure cargarArreglo( var arreglo : arreglo_char ) ;
var
  caracter : 'a'..'z' ;
  i : integer ;
begin
  caracter := 'a' ;

  for i := 1 to CANT_CHAR do begin
    arreglo[i] := caracter ;
    caracter := succ( caracter ) ;
  end ;
end ;

procedure arregloToLista( arreglo : arreglo_char ;
                          lista : puntero_lista ) ;
var
  i : integer ;
  auxiliar : puntero_lista ;
begin
  for i := 1 to CANT_CHAR do begin
    auxiliar := lista ;
    new( auxiliar ) ;
    auxiliar^.valor := arreglo[i] ;
    auxiliar^.siguiente := nil ;
    auxiliar := auxiliar^.siguiente ;
  end ;
end ;

begin
  new( puntero ) ;
  cargarArreglo( arreglo ) ;
  arregloToLista( arreglo, puntero ) ;
  dispose( puntero ) ;
end.
