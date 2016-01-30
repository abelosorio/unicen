program ejercicio2 ;
{
  $Id: ejercicio2.pas,v 1.2 2016/01/30 19:06:34 aosorio Exp $

  2) Realice un módulo que retorne el máximo de una lista vinculada de enteros.
}

type
  puntero = ^registro_enteros ;
  registro_enteros = record
    valor : integer ;
    siguiente : puntero ;
  end ;

var
  lista : puntero ;

procedure inicializarLista( var lista : puntero ) ;
var
  i : integer ;
  auxiliar : puntero ;
begin
  new( lista ) ;
  lista^.valor := -1 ;
  lista^.siguiente := nil ;
  auxiliar := lista ;

  for i := 1 to 10 do begin
    new( auxiliar^.siguiente ) ;
    auxiliar := auxiliar^.siguiente ;
    auxiliar^.valor := i ;
    auxiliar^.siguiente := nil ;
  end ;
end ;

function mayorElemento( lista : puntero ) : integer ;
var
  auxiliar : puntero ;
  mayor : integer ;
begin
  mayor := -1 ;
  auxiliar := lista ;
  while( auxiliar^.siguiente <> nil ) do begin
    auxiliar := auxiliar^.siguiente ;
    if( auxiliar^.valor > mayor ) then mayor := auxiliar^.valor ;
  end ;
  mayorElemento := mayor ;
end ;

begin
  inicializarLista( lista ) ;
  writeln( 'El mayor elemento es: ', mayorElemento( lista ) ) ;
end.
