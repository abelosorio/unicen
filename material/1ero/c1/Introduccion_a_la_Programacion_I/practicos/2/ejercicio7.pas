program Ejercicio7 ;
{
  $Id: ejercicio7.pas,v 1.2 2016/01/30 19:06:47 aosorio Exp $

  Cargar la fila DATOS y pasar el primer elemento (tope) de la fila DATOS a su
  última posición (base), dejando los restantes elementos en el mismo orden.
  Finalmente imprima la fila por pantalla.
}

uses Estructu ;

var
  DATOS, AUX1, AUX2: Fila ;

begin
  readFila( DATOS ) ;
  inicFila( AUX1, '' ) ;
  inicFila( AUX2, '' ) ;

  if( not filaVacia( DATOS ) ) then
    agregar( AUX1, extraer( DATOS ) ) ;

  while( not filaVacia( DATOS ) ) do
    agregar( AUX2, extraer( DATOS ) ) ;

  while( not filaVacia( AUX2 ) ) do
    agregar( DATOS, extraer( AUX2 ) ) ;

  if( not filaVacia( AUX1 ) ) then
    agregar( DATOS, extraer( AUX1 ) ) ;

  writeFila( DATOS ) ;
end.
