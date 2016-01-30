program Ejercicio5 ;
{
  $Id: ejercicio5.pas,v 1.2 2016/01/30 19:06:33 aosorio Exp $

  Invierta el orden de los elementos de un archivo de caracteres.
}

const
  URI = 'ejercicio5.dat' ;

type
  archivo_chars = file of char ;

var
  archivo : archivo_chars ;

procedure cargarDefaults( var archivo : archivo_chars ) ;
begin
  seek( archivo, 0 ) ;
  write( archivo, 'a' ) ;
  write( archivo, 'b' ) ;
  write( archivo, 'c' ) ;
  write( archivo, 'd' ) ;
  write( archivo, 'e' ) ;
  write( archivo, 'f' ) ;
  write( archivo, 'g' ) ;
  write( archivo, 'h' ) ;
end ;

function abreArchivo( var archivo : archivo_chars ;
                      uri : string ;
                      crear : boolean ) : boolean ;
var
  resultado : integer ;

begin
  assign( archivo, uri ) ;
  {$I-} ;
  reset( archivo ) ;
  {$I+} ;
  resultado := ioresult ;

  if( ( resultado <> 0 ) AND ( crear ) ) then
    begin
    rewrite( archivo ) ;
    resultado := ioresult ;
    end ;

  abreArchivo := ( resultado = 0 ) ;
end ;

procedure invertirDato( var archivo : archivo_chars ;
                        pos1 : integer ;
                        pos2 : integer ) ;
var
  dato1, dato2 : char ;

begin
  seek( archivo, pos1 ) ;
  read( archivo, dato1 ) ;
  seek( archivo, pos2 ) ;
  read( archivo, dato2 ) ;

  seek( archivo, pos1 ) ;
  write( archivo, dato2 ) ;
  seek( archivo, pos2 ) ;
  write( archivo, dato1 ) ;
end ;

procedure invertirDatos( var archivo : archivo_chars ) ;
var
  i : integer ;
begin
  for i := 0 to trunc( fileSize( archivo )/2 )-1 do
    invertirDato( archivo, i, fileSize( archivo )-i-1 ) ;
end ;

procedure mostrarArchivo( var archivo : archivo_chars ) ;
var
  dato : char ;

begin
  seek( archivo, 0 ) ;
  while( not eof( archivo ) ) do
    begin
    read( archivo, dato ) ;
    writeln( dato ) ;
    end ;
end ;

begin
  if( not abreArchivo( archivo, URI, TRUE ) ) then
    begin
    writeln( 'No se puede abrir el archivo.' ) ;
    exit ;
    end ;

  cargarDefaults( archivo ) ;
  writeln( 'Archivo derecho' ) ;
  mostrarArchivo( archivo ) ;
  invertirDatos( archivo ) ;

  writeln( 'Archivo al revés' ) ;
  mostrarArchivo( archivo ) ;
end.
