program ejercicio1 ;
{
  $Id: ejercicio1.pas,v 1.2 2016/01/30 19:06:34 aosorio Exp $

  Defina un tipo de datos para una fila, implementándola como una lista
  vinculada. Los elementos son números enteros. Luego codifique las
  funciones / procedimientos implementados en el “ESTRUCTU” para la fila, a
  saber:
	a.- Inic_fila
 	b.- Agregar
	c.- Extraer
	d.- Fila_vacia
	e.- Primero
	f.- Write_fila
	g.- Read_fila (no lo implemente)
}

type
  puntero_fila = ^arreglo_fila ;
  arreglo_fila = record
    valor : integer ;
    siguiente : puntero_fila ;
  end ;

var
  fila : puntero_fila ;

procedure inic_fila( var fila : puntero_fila ) ;
begin
  fila := nil ;
end ;

procedure agregar( var fila : puntero_fila ;
                   valor: integer ) ;
var
  aagregar, puntero : puntero_fila ;
begin
  new( aagregar ) ;
  aagregar^.valor := valor ;
  aagregar^.siguiente := nil ;
  if ( fila = nil ) then
    fila := aagregar
  else begin
    puntero := fila ;
    while ( puntero^.siguiente <> nil ) do
      puntero := puntero^.siguiente ;
    puntero^.siguiente := aagregar ;
  end ;
end ;

function extraer( var fila : puntero_fila ) : integer ;
begin
  if( fila <> nil ) then begin
    extraer := fila^.valor ;
    fila := fila^.siguiente ;
  end ;
end ;

function fila_vacia( fila : puntero_fila ) : boolean ;
begin
  fila_vacia := ( fila = nil ) ;
end ;

function primero( fila : puntero_fila ) : integer ;
begin
  if( fila <> nil ) then
    primero := fila^.valor ;
end ;

procedure write_fila( fila : puntero_fila ) ;
begin
  while ( fila <> nil ) do begin
    writeln( fila^.valor ) ;
    fila := fila^.siguiente ;
  end ;
end ;

begin
  writeln( 'Inicializando fila' ) ;
  inic_fila( fila ) ;
  writeln( 'Agregando el número 1 a la fila' ) ;
  agregar( fila, 1 ) ;
  write_fila( fila ) ;
  writeln( 'Extrayendo el primer elemento de la fila: ', extraer( fila ) ) ;
  write_fila( fila ) ;
end.
