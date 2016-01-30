program Ejercicio3b ;
{
  $Id: ejercicio2c.pas,v 1.2 2016/01/30 19:06:33 aosorio Exp $

    Teniendo en cuenta que los siguientes archivos son de números enteros,
  realice programas acorde a los siguientes incisos:
  c) Dado un nombre de archivo de origen clonarlo con otro nombre; es decir,
  crear otro que tenga exactamente el mismo contenido pero un nombre distinto.
}

type
  archivo_enteros = file of integer ;

var
  archivo1 : archivo_enteros ;
  archivo2 : archivo_enteros ;
  uri_archivo1 : string ;
  uri_archivo2 : string ;

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

  if( ( resultado <> 0 ) AND crear ) then
    begin
    rewrite( archivo ) ;
    resultado := ioresult ;
    end ;

  abreArchivo := ( resultado = 0 ) ;
end ;

procedure copiarDatos( var archivo1 : archivo_enteros ;
                       var archivo2 : archivo_enteros ) ;
var
  valor : integer ;
begin
  seek( archivo1, 0 ) ;
  seek( archivo2, 0 ) ;
  while( not eof( archivo1 ) ) do
    begin
    read( archivo1, valor ) ;
    write( archivo2, valor ) ;
    end ;
end ;

procedure renombrar( var archivo1 : archivo_enteros ;
                     uri_archivo2 : string ) ;
begin
  assign( archivo2, uri_archivo2 ) ;
  abreArchivo( archivo2, uri_archivo2, TRUE ) ;
  copiarDatos( archivo1, archivo2 ) ;
end ;

begin
  write( 'Ingrese el nombre del 1er archivo: ' ) ;
  readln( uri_archivo1 ) ;
  write( 'Ingrese el nombre del 2do archivo: ' ) ;
  readln( uri_archivo2 ) ;

  if( abreArchivo( archivo1, uri_archivo1, FALSE ) ) then
    begin
    renombrar( archivo1, uri_archivo2 ) ;
    close( archivo1 ) ;
    close( archivo2 ) ;
    end
  else
    write( 'El archivo ' + uri_archivo1 + ' no existe.' ) ;
end.
