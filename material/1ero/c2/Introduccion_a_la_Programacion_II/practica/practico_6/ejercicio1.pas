program ejercicio6 ;
{
  $Id: ejercicio1.pas,v 1.2 2016/01/30 19:06:35 aosorio Exp $

  1) Se tiene un archivo desordenado con números enteros. Se pretende que
  realice un procedimiento que lea todos los números del archivo y genere un
  árbol ordenado en forma ascendente.
}

const
  URI_ARCHIVO = 'ejercicio1.dat' ;
  CANT_VALORES = 10 ;

type
  archivo_enteros = file of integer ;
  puntero_arbol = ^registro_arbol ;
  registro_arbol = record
    valor : integer ;
    menores : puntero_arbol ;
    mayores : puntero_arbol ;
  end ;

var
  arbol : puntero_arbol ;
  archivo : archivo_enteros ;

procedure cargar_defaults( var archivo : archivo_enteros ) ;
var
  i : integer ;
begin
  for i := 1 to CANT_VALORES do
    if ( i mod 2 = 0 ) then
      write( archivo, i*(i+2) )
    else
      write( archivo, i+1 ) ;
end ;

procedure mostrar_archivo( var archivo : archivo_enteros ) ;
var
  valor : integer ;
begin
  seek( archivo, 1 ) ;
  while ( not eof( archivo ) ) do begin
    read( archivo, valor ) ;
    writeln( valor ) ;
  end ;
end ;

procedure insertar_en_arbol( var arbol : puntero_arbol ;
                             valor : integer ) ;
begin
  if ( arbol = nil ) then begin
    new( arbol ) ;
    arbol^.valor := valor ;
    arbol^.menores := nil ;
    arbol^.mayores := nil ;
  end else begin
    if( valor <= arbol^.valor ) then
      insertar_en_arbol( arbol^.menores, valor )
    else
      insertar_en_arbol( arbol^.mayores, valor ) ;
  end ;
end ;

function archivo_a_arbol( var archivo : archivo_enteros ) : puntero_arbol ;
var
  valor : integer ;
  auxiliar : puntero_arbol ;
begin
  seek( archivo, 1 ) ;
  auxiliar := nil ;

  while ( not eof( archivo ) ) do begin
    read( archivo, valor ) ;
    insertar_en_arbol( auxiliar, valor ) ;
  end ;

  archivo_a_arbol := auxiliar ;
end ;

procedure mostrar_arbol( arbol : puntero_arbol ) ;
begin
  if ( arbol <> nil ) then begin
    mostrar_arbol( arbol^.menores ) ;
    writeln( arbol^.valor ) ;
    mostrar_arbol( arbol^.mayores ) ;
  end ;
end ;

begin
  assign( archivo, URI_ARCHIVO ) ;
  rewrite( archivo ) ;
  cargar_defaults( archivo ) ;
  writeln( 'Archivo:' ) ;
  mostrar_archivo( archivo ) ;
  arbol := archivo_a_arbol( archivo ) ;
  writeln( 'Arbol:' ) ;
  mostrar_arbol( arbol ) ;
end.
