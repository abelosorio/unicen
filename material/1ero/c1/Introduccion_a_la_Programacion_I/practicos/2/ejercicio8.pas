program Ejercicio8 ;
{
  $Id: ejercicio8.pas,v 1.2 2016/01/30 19:06:47 aosorio Exp $

  Cargar por teclado la fila DATOS y pasar el último elemento (base) de la fila
  DATOS a su primera posición (tope), dejando los restantes elementos en el
  mismo orden. Finalmente imprima la fila por pantalla.
}

uses Estructu ;

var
  DATOS: Fila ;
  PAUX1, PAUX2: Pila ;

begin
  readFila( DATOS ) ;
  inicPila( PAUX1, '' ) ;
  inicPila( PAUX2, '' ) ;

  { Paso todos los elementos a una pila para cambiar el orden }
  while( not filaVacia( DATOS ) ) do
    apilar( PAUX1, extraer( DATOS ) ) ;

  { Paso a DATOS el tope de la pila PAUX1 que antes era base de la fila DATOS }
  if( not pilaVacia( PAUX1 ) ) then
    agregar( DATOS, desapilar( PAUX1 ) ) ;

  { Paso todos los elementos de la pila PAUX1 a PAUX2 para cambiar el orden }
  while( not pilaVacia( PAUX1 ) ) do
    apilar( PAUX2, desapilar( PAUX1 ) ) ;

  { Paso todos los elementos de PAUX2 a DATOS para dejarlos como estaban }
  while( not pilaVacia( PAUX2 ) ) do
    agregar( DATOS, desapilar( PAUX2 ) ) ;

  writeFila( DATOS ) ;
end.
