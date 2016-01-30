program ejercicio7 ;
{
  $Id: ejercicio7.pas,v 1.2 2016/01/30 19:06:34 aosorio Exp $

  7) Codifique un módulo que, dado un elemento, lo elimine de una lista ordenada
     de reales (si existe).
}

const
  CANT_VALORES = 5 ;

type
  puntero_reales = ^registro_reales ;
  registro_reales = record
    valor : real ;
    siguiente : puntero_reales ;
  end ;

var
  puntero : puntero_reales ;
  aeliminar : real ;

procedure agregarALista( var puntero : puntero_reales ;
                         valor : real ) ;
var
  aagregar : puntero_reales ;
begin
  new( aagregar ) ;
  aagregar^.valor := valor ;
  aagregar^.siguiente := puntero ;
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
begin
  while( puntero <> nil ) do begin
    writeln( puntero^.valor ) ;
    puntero := puntero^.siguiente ;
  end ;
end ;

procedure eliminarDeLista( var puntero : puntero_reales ;
                           valor : real ) ;
var
  aeliminar, anterior, cursor : puntero_reales ;
begin
  cursor := puntero ;
  anterior := nil ;

  while( ( cursor <> nil ) AND ( cursor^.valor <= valor ) ) do begin
    if( cursor^.valor = valor ) then begin
      aeliminar := cursor ;
      if( anterior = nil ) then
        puntero := cursor^.siguiente
      else
        anterior^.siguiente := cursor^.siguiente ;

      dispose( aeliminar ) ;
    end
    else begin
      anterior := cursor ;
      cursor := cursor^.siguiente ;
    end ;
  end ;
end ;

begin
  puntero := nil ;

  cargarDefaults( puntero ) ;
  write( 'Ingrese un número real para eliminarlo de la lista: ' ) ;
  readln( aeliminar ) ;

  eliminarDeLista( puntero, aeliminar ) ;

  mostrarLista( puntero ) ;
end.
