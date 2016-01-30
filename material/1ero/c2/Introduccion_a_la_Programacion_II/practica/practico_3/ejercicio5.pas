program ejercicio5 ;
{
  $Id: ejercicio5.pas,v 1.3 2016/01/30 19:06:34 aosorio Exp $

  5) Codifique un módulo que inserte un número entero en una lista ordenada
  ascendentemente conservando el orden.
}

const
  CANT_VALORES = 10 ;

type
  puntero_enteros = ^registro_enteros ;
  registro_enteros = record
    valor : integer ;
    siguiente : puntero_enteros ;
  end ;

var
  puntero : puntero_enteros ;
  valor : integer ;

procedure agregarElemento( var puntero : puntero_enteros ;
                           valor : integer ) ;
var
  auxiliar : puntero_enteros ;
begin
  new( auxiliar ) ;
  auxiliar^.siguiente := puntero ;
  auxiliar^.valor := valor ;
  puntero := auxiliar ;
end ;

procedure cargarDefaults( var puntero : puntero_enteros ) ;
var
  i : integer ;
begin
  for i := CANT_VALORES downto 1 do
    if( i mod 2 = 0 ) then agregarElemento( puntero, i ) ;
end ;

procedure mostrarLista( puntero : puntero_enteros ) ;
var
  auxiliar : puntero_enteros ;
begin
  auxiliar := puntero ;
  while( auxiliar <> nil ) do begin
    writeln( auxiliar^.valor ) ;
    auxiliar := auxiliar^.siguiente ;
  end ;
end ;

procedure agregarElementoOrdenado( var puntero : puntero_enteros ;
                                   valor : integer ) ;
var
  nuevo, cursor, anterior : puntero_enteros ;
begin
  cursor := puntero ;
  anterior := nil ;

  new( nuevo ) ;
  nuevo^.siguiente := nil ;
  nuevo^.valor := valor ;

  if( puntero = nil ) then
    { Si la lista está vacío simplemente se inserta el valor }
    puntero := nuevo
  else begin
    { Sino, se busca la posición correspondiente y se inserta el valor }
    while( ( cursor <> nil ) AND ( cursor^.valor < valor ) ) do begin
      anterior := cursor ;
      cursor := cursor^.siguiente ;
    end ;
    { Se engancha el nuevo nodo }
    nuevo^.siguiente := cursor ;
    if( anterior = nil ) then
      puntero := nuevo
    else
      anterior^.siguiente := nuevo ;
  end ;
end ;

begin
  puntero := nil ;
  cargarDefaults( puntero ) ;

  write( 'Ingrese un valor a insertar en la lista: ' ) ;
  readln( valor ) ;

  agregarElementoOrdenado( puntero, valor ) ;

  mostrarLista( puntero ) ;
end.
