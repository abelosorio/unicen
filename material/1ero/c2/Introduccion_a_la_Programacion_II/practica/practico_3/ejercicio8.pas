program ejercicio8 ;
{
  $Id: ejercicio8.pas,v 1.2 2016/01/30 19:06:34 aosorio Exp $

  8) Codifique un módulo que, dada una posición, elimine el elemento
  correspondiente (a esa posición) de una lista ordenada doblemente vinculada
  de reales.
}

const
  CANT_VALORES = 10 ;

type
  puntero_reales = ^registro_reales ;
  registro_reales = record
    valor : real ;
    anterior : puntero_reales ;
    siguiente : puntero_reales ;
  end ;

var
  puntero : puntero_reales ;
  aeliminar : integer ;

procedure agregarALista( var puntero : puntero_reales ;
                         valor : real ) ;
var
  aagregar : puntero_reales ;
begin
  new( aagregar ) ;
  aagregar^.valor := valor ;
  aagregar^.anterior := nil ;
  aagregar^.siguiente := nil ;
  if( puntero <> nil ) then begin
    aagregar^.siguiente := puntero ;
    puntero^.anterior := aagregar ;
  end ;
  puntero := aagregar ;
end ;

procedure cargarDefaults( var puntero : puntero_reales ) ;
var
  i : integer ;
begin
  for i := CANT_VALORES downto 1 do
    agregarALista( puntero, i+0.5 ) ;
end ;

procedure mostrarLista( puntero : puntero_reales ) ;
var
  posicion : integer ;
begin
  posicion := 1 ;
  writeln( 'Posicion, valor' ) ;
  while( puntero <> nil ) do begin
    writeln( posicion, ', ', puntero^.valor ) ;
    puntero := puntero^.siguiente ;
    posicion := posicion + 1 ;
  end ;
end ;

procedure eliminarDeLista( var puntero : puntero_reales ;
                           posicion : real ) ;
var
  aeliminar, cursor : puntero_reales ;
  posicion_aux : integer ;
begin
  cursor := puntero ;
  posicion_aux := 1 ;

  while( posicion_aux <= posicion ) or ( cursor <> nil ) do begin
    if( posicion_aux = posicion ) then begin
      aeliminar := cursor ;
      if( cursor^.anterior = nil ) then
        puntero := cursor^.siguiente
      else
        cursor^.anterior^.siguiente := cursor^.siguiente ;

      dispose( aeliminar ) ;
    end
    else begin
      cursor := cursor^.siguiente ;
    end ;
    posicion_aux := posicion_aux + 1 ;
  end ;
end ;

begin
  puntero := nil ;

  cargarDefaults( puntero ) ;
  mostrarLista( puntero ) ;

  write( 'Ingrese la posición del número para eliminarlo de la lista: ' ) ;
  readln( aeliminar ) ;

  eliminarDeLista( puntero, aeliminar ) ;
  mostrarLista( puntero ) ;
end.
