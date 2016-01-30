{
  $Id: ejercicio1.pas,v 1.2 2016/01/30 19:06:35 aosorio Exp $

  1) Una función es recursiva si su código contiene invocaciones a sí misma.
  Teniendo en cuenta que factorial(N) = N * factorial(N-1) para N > 0 y
  factorial(0) = 1, escriba el código de la función que dado un número retorna
  su factorial.
}

program ejercicio1 ;

var
  A : integer ;

function factorial( N : integer ) : integer ;
begin
  if( N = 0 ) then
    factorial := 1
  else
    factorial := N * factorial( N - 1 ) ;
end ;

begin
  write( 'Ingrese un número para calcular su factorial: ' ) ;
  readln( A ) ;

  writeln( 'El factorial de ', A, ' es: ', factorial( A ) ) ;
end.
