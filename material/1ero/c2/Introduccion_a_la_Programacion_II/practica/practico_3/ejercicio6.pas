program ejercicio5 ;
{
  $Id: ejercicio6.pas,v 1.2 2016/01/30 19:06:34 aosorio Exp $

  6) Idem al anterior con una lista doblemente vinculada.
    "5) Codifique un módulo que inserte un número entero en una lista ordenada
        ascendentemente conservando el orden."
}

const
  CANT_VALORES = 10 ;

type
  puntero_enteros = ^registro_enteros ;
  registro_enteros = record
    valor : integer ;
    anterior : puntero_enteros ;
    siguiente : puntero_enteros ;
  end ;

var
  puntero : puntero_enteros ;
  valor : integer ;

procedure agregarElemento( var puntero : puntero_enteros ;
                           valor : integer ) ;
var
  nuevo : puntero_enteros ;
begin
  new( nuevo ) ;
  nuevo^.valor := valor ;
  nuevo^.anterior := nil ;
  nuevo^.siguiente := puntero ;
  if( puntero = nil ) then
    puntero := nuevo
  else begin
    puntero^.anterior := nuevo ;
    puntero := nuevo ;
  end ;
end ;

procedure cargarDefaults( var puntero : puntero_enteros ) ;
var
  i : integer ;
begin
  for i := CANT_VALORES downto 1 do
    if( i mod 2 = 0 ) then agregarElemento( puntero, i ) ;
end ;

procedure mostrarLista( puntero : puntero_enteros ) ;
begin
  while( puntero <> nil ) do begin
    writeln( puntero^.valor ) ;
    puntero := puntero^.siguiente ;
  end ;
end ;

procedure agregarElementoOrdenado( var puntero : puntero_enteros ;
                                   valor : integer ) ;
var
  nuevo, cursor, anterior : puntero_enteros ;
begin
  cursor := puntero ;

  new( nuevo ) ;
  nuevo^.anterior := nil ;
  nuevo^.siguiente := nil ;
  nuevo^.valor := valor ;
  anterior := nil ;

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
    nuevo^.anterior := anterior ;
    nuevo^.siguiente := cursor ;
    anterior := nuevo ;

    if( nuevo^.anterior = nil ) then
      puntero := nuevo
    else
      nuevo^.anterior^.siguiente := nuevo ;
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
