program Ejercicio7 ;
{
  $Id: ejercicio1.pas,v 1.2 2016/01/30 19:06:47 aosorio Exp $

  Realizar un procedimiento que cargue caracteres (no más de 50) desde el
  teclado en un arreglo. El fin de la carga se detecta por el ingreso de un
  caracter '*'.
}

var
  DATO : array[1..50] of char ;
  LEIDO : char ;
  CONTINUAR : boolean = TRUE ;
  I : Integer = 1 ;

procedure inicializar_arreglo( var ARREGLO : array of char ) ;
var
  I : Integer ;
begin
  for I := 1 to 50 do
    ARREGLO[I] := ' ' ;
end ;

procedure imprimir_arreglo( ARREGLO : array of char ) ;
var
  I : Integer ;
begin
  writeln( '' ) ;
  writeln( 'Los datos del arreglo son:' ) ;
  for I := 1 to 50 do
    write( ARREGLO[I] + ' ' ) ;
  writeln( '' ) ;
end ;

begin
  inicializar_arreglo( DATO ) ;
  while( ( I <= 50 ) and CONTINUAR ) do
  begin
    write( 'Ingrese un caracter ("*" para detener): ' ) ;
    readln( LEIDO ) ;
    if( LEIDO = '*' ) then
      CONTINUAR := FALSE
    else
      DATO[I] := LEIDO ;

    I := I + 1 ;
  end ;

  imprimir_arreglo( DATO ) ;
end.
