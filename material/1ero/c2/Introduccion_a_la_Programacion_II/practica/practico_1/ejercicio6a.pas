program Ejercicio6a ;
{
  $Id: ejercicio6a.pas,v 1.2 2016/01/30 19:06:33 aosorio Exp $

    Teniendo en cuenta que los siguientes archivos son de números enteros,
  realice procedimientos acorde a los siguientes incisos:
  a) Recorra (una vez sola) un archivo de forma tal que si un número es mayor
  que el anterior los intercambie.
}

const
  URI = 'ejercicio6a.dat' ;

type
  archivo_enteros = file of integer ;

var
  archivo : archivo_enteros ;

function abreArchivo( var archivo : archivo_enteros ;
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

procedure cargarDefaults( var archivo : archivo_enteros ) ;
begin
  seek( archivo, 0 ) ;
  write( archivo, 1 ) ;
  write( archivo, 5 ) ;
  write( archivo, 3 ) ;
  write( archivo, 7 ) ;
  write( archivo, 4 ) ;
  write( archivo, 8 ) ;
end ;

procedure invertirDato( var archivo : archivo_enteros ;
                        pos1 : integer ;
                        pos2 : integer ) ;
var
  dato1, dato2 : integer ;
begin
  seek( archivo, pos1 ) ;
  read( archivo, dato1 ) ;
  seek( archivo, pos2 ) ;
  read( archivo, dato2 ) ;

  seek( archivo, pos1 ) ;
  write( archivo, dato2 ) ;
  seek( archivo, pos2 ) ;
  write( archivo, dato1 ) ;

  seek( archivo, pos1 ) ;
end ;

procedure ordenarArchivo( var archivo : archivo_enteros ) ;
var
  i, dato_actual, dato_anterior : integer ;
begin
  for i := 1 to fileSize( archivo )-1 do
    begin
    seek( archivo, i ) ;
    dato_anterior := 0 ;
    dato_actual := 0 ;
    read( archivo, dato_actual ) ;
    seek( archivo, i-1 ) ;
    read( archivo, dato_anterior ) ;

    if( dato_actual > dato_anterior ) then
      invertirDato( archivo, i, i-1 ) ;

    end ;
end ;

procedure mostrarArchivo( var archivo : archivo_enteros ) ;
var
  dato : integer ;
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
    writeln( 'No se puede abrir el archivo' ) ;
    exit ;
    end ;

  cargarDefaults( archivo ) ;

  writeln( 'Archivo sin ordenar' ) ;
  mostrarArchivo( archivo ) ;

  ordenarArchivo( archivo ) ;

  writeln( 'Archivo ordenado' ) ;
  mostrarArchivo( archivo ) ;

  close( archivo ) ;
end.
