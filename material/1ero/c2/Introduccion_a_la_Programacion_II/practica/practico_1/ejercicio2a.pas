program Ejercicio2a ;
{
  $Id: ejercicio2a.pas,v 1.2 2016/01/30 19:06:33 aosorio Exp $

    Teniendo en cuenta que los siguientes archivos son de números enteros,
  realice programas acorde a los siguientes incisos:
  a) Dado un nombre de archivo, guardar en el archivo todos los números
  positivos ingresados por teclado.
}

type
  archivo_enteros = file of integer ;

var
  archivo : archivo_enteros ;
  uri : string ;
  valor : integer ;

function abreArchivo( var archivo : archivo_enteros ;
                      uri : string ;
                      crear : boolean ) : boolean ;
{
  ------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
}
begin
  assign( archivo, uri ) ;
  {$I-} ;
  reset( archivo ) ;
  {$I+} ;
  if( ( ioresult <> 0 ) AND crear ) then
    rewrite( archivo ) ;

  abreArchivo := ( ioresult = 0 ) ;
end ;

function esPositivo( valor : integer ) : boolean ;
{
  ------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
}
begin
  esPositivo := ( valor > 0 ) ;
end ;

procedure escribirFinal( var archivo : archivo_enteros ;
                         valor : integer ) ;
{
  ------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
  ------------------------------------------------------------------------------
}
begin
  seek( archivo, fileSize( archivo ) ) ;
  write( archivo, valor ) ;
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
  valor := 1 ;

  if( not abreArchivo( archivo, uri, TRUE ) ) then
    begin
    writeln( 'El archivo ' + uri + ' no existe' ) ;
    exit ;
    end ;

  while( valor <> 0 ) do
    begin
    write( 'Ingrese un número entero (0 para terminar): ' ) ;
    readln( valor ) ;
    if( esPositivo( valor ) ) then
      escribirFinal( archivo, valor ) ;
    end ;

  mostrarArchivo( archivo ) ;
  close( archivo ) ;
end.
