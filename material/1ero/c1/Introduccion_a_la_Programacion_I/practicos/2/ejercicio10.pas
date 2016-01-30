program ejercicio10 ;
{
  $Id: ejercicio10.pas,v 1.2 2016/01/30 19:06:47 aosorio Exp $

  Cargar PILA1 y PILA2 y luego imprimir PILA1 ó PILA2 según un valor ingresado
  por el usuario en la pila VALOR.
}

uses Estructu ;

var
  PILA1, PILA2, VALOR: Pila ;

begin
  inicPila( PILA1, '1 2 3 4 5' ) ;
  inicPila( PILA2, '6 7 8 9 0' ) ;
  readPila( VALOR ) ;

  if( tope( VALOR ) > 5 ) then
    writePila( PILA1 )
  else
    writePila( PILA2 ) ;
end.
