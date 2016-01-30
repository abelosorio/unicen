program Ejercicio4 ;

{
  $Id: ejercicio4.pas,v 1.2 2016/01/30 19:06:46 aosorio Exp $

  Cargar desde el teclado la pila ORIGEN e inicializar en vacío la pila
  DESTINO. Pasar los elementos de la pila ORIGEN a la pila DESTINO, pero
  dejándolos en el mismo orden.
}

uses Estructu ;

var
  ORIGEN:Pila ;
  DESTINO:Pila ;
  AUXILIAR:Pila ;

begin

  readPila( ORIGEN ) ;
  inicPila( DESTINO, '' ) ;
  inicPila( AUXILIAR, '' ) ;

  while( not pilaVacia( ORIGEN ) ) do
    apilar( AUXILIAR, desapilar( ORIGEN ) ) ;

  while( not pilaVacia( AUXILIAR ) ) do
    apilar( DESTINO, desapilar( AUXILIAR ) ) ;

  writePila( DESTINO ) ;

end.
