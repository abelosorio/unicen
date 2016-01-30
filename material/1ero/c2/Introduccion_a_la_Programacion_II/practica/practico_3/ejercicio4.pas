program ejercicio4 ;
{
  $Id: ejercicio4.pas,v 1.3 2016/01/30 19:06:34 aosorio Exp $

  4) Codifique un módulo que cargue por teclado N caracteres en una lista (uno
  por nodo). El fin de la carga se detecta cuando el usuario ingresa el
  carácter “*”.
}

type
  puntero_caracteres = ^caracteres ;
  caracteres = record
    valor : char ;
    siguiente : puntero_caracteres ;
  end ;

var
  puntero : puntero_caracteres ;
  caracter : char ;

procedure agregarElemento( var puntero : puntero_caracteres ;
                           valor : char ) ;
var
  auxiliar : puntero_caracteres ;
begin
  new( auxiliar ) ;
  auxiliar^.valor := valor ;
  auxiliar^.siguiente := puntero ;
  puntero := auxiliar ;
end ;

procedure mostrarLista( puntero : puntero_caracteres ) ;
begin
  while( puntero <> nil ) do begin
    writeln( puntero^.valor ) ;
    puntero := puntero^.siguiente ;
  end ;
end ;

begin
  caracter := ' ' ;
  puntero := nil ;

  while( caracter <> '*' ) do begin
    write( 'Ingrese un caracter ("*" para terminar): ' ) ;
    readln( caracter ) ;
    if( caracter <> '*' ) then agregarElemento( puntero, caracter ) ;
  end ;

  mostrarLista( puntero ) ;
end.
