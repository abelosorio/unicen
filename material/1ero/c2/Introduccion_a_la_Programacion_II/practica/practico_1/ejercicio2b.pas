program Ejercicio2b ;
{
  $Id: ejercicio2b.pas,v 1.3 2016/01/30 19:06:33 aosorio Exp $

    Teniendo en cuenta que los siguientes archivos son de números enteros,
  realice programas acorde a los siguientes incisos:
  b) Dado un nombre de archivo, mostrar por pantalla todos los elementos del
  mismo.
}

type
  archivo_enteros = file of integer ;

var
  archivo : archivo_enteros ;
  uri : string ;

function abreArchivo( var archivo : archivo_enteros ;
                      uri : string ;
                      crear : boolean ) : boolean ;
{
  ------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
}
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

procedure mostrarArchivo( var archivo : archivo_enteros ) ;
var
  valor : integer ;
begin
  seek( archivo, 0 ) ;
  while( not eof( archivo ) ) do
    begin
    read( archivo, valor ) ;
    writeln( valor ) ;
    end ;
end ;

begin
  write( 'Ingrese la ruta del archivo: ' ) ;
  readln( uri ) ;

  if( not abreArchivo( archivo, uri, FALSE ) ) then
    writeln( 'El archivo ' + uri + ' no existe' )
  else
    begin
    mostrarArchivo( archivo ) ;
    close( archivo ) ;
    end ;
end.
