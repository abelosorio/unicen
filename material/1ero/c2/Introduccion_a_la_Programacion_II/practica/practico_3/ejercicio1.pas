program ejercicio1 ;
{
  $Id: ejercicio1.pas,v 1.2 2016/01/30 19:06:34 aosorio Exp $

  1) Realice un módulo (procedimiento o función) que retorne la suma de los
  elementos reales de una lista vinculada.
}

type
  puntero = ^registro_reales ;
  registro_reales = record
    valor : real ;
    siguiente : puntero ;
  end ;

var
  lista : puntero ;

procedure inicializarLista( var lista : puntero ) ;
var
  i : integer ;
  cursor_aux : puntero ;
begin
  new( lista ) ;
  lista^.siguiente := nil ;
  lista^.valor := 0.5 ;
  new( cursor_aux ) ;
  cursor_aux := lista ;
  for i := 1 to 5 do begin
    new( cursor_aux^.siguiente ) ;
    cursor_aux := cursor_aux^.siguiente ;
    cursor_aux^.valor := i+0.5 ;
    cursor_aux^.siguiente := nil ;
  end ;
end ;

function sumaDeElementos( lista : puntero ) : real ;
var
  contador : real ;
  auxiliar : puntero ;
begin
  contador := 0 ;
  auxiliar := lista ;
  while( auxiliar <> nil ) do
    begin
    contador := contador+auxiliar^.valor ;
    auxiliar := auxiliar^.siguiente ;
    end ;

  sumaDeElementos := contador ;
end ;

begin
  inicializarLista( lista ) ;
  writeln( 'La suma de elementos es: ', sumaDeElementos( lista ) ) ;
end.
