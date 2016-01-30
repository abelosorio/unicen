program ejercicio9 ;
{
  $Id: ejercicio9.pas,v 1.2 2016/01/30 19:06:34 aosorio Exp $

  9) Dada una lista de enteros, realice un procedimiento que invierta el orden
  de sus elementos únicamente modificando sus vínculos.
}

const
  CANT_VALORES = 10 ;

type
  puntero_enteros = ^arreglo_enteros ;
  arreglo_enteros = record
    valor : integer ;
    siguiente : puntero_enteros ;
  end ;

var
  puntero : puntero_enteros ;

procedure agregar( var puntero : puntero_enteros ;
                   valor : integer ) ;
var
  aagregar : puntero_enteros ;
begin
  new( aagregar ) ;
  aagregar^.valor := valor ;
  aagregar^.siguiente := puntero ;
  puntero := aagregar ;
end ;

procedure cargarDefaults( var puntero : puntero_enteros ) ;
var
  i : integer ;
begin
  for i := 1 to CANT_VALORES do
    agregar( puntero, i ) ;
end ;

procedure invertirOrden( var puntero : puntero_enteros ) ;
var
  anterior, siguiente, cursor : puntero_enteros ;
begin
  anterior := nil ;
  cursor := puntero ;
  while( cursor <> nil ) do begin
    siguiente := cursor^.siguiente ;
    cursor^.siguiente := anterior ;
    anterior := cursor ;
    cursor := siguiente ;
  end ;
  puntero := anterior ;
end ;

procedure mostrarArreglo( puntero : puntero_enteros ) ;
begin
  while( puntero <> nil ) do begin
    writeln( puntero^.valor ) ;
    puntero := puntero^.siguiente ;
  end ;
end ;

begin
  puntero := nil ;
  cargarDefaults( puntero ) ;
  mostrarArreglo( puntero ) ;
  invertirOrden( puntero ) ;
  mostrarArreglo( puntero ) ;
end.
