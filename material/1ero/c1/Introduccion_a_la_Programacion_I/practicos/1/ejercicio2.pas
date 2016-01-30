program Ejercicio2 ;

{
  $Id: ejercicio2.pas,v 1.2 2016/01/30 19:06:46 aosorio Exp $

  Cargar desde el teclado la pila ORIGEN e inicializar en vacío la pila
  DESTINO. Pasar todos los elementos de la pila ORIGEN a la pila DESTINO.
}

uses Estructu ;

var

  ORIGEN:Pila ;
  DESTINO:Pila ;

begin

  readPila( ORIGEN ) ;
  inicPila( DESTINO, '' ) ;

  while( not pilaVacia( ORIGEN ) ) do
    apilar( DESTINO, desapilar( ORIGEN ) ) ;

  writePila( DESTINO ) ;

end.
