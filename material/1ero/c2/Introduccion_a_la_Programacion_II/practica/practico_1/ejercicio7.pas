program Ejercicio7 ;
{
  $Id: ejercicio7.pas,v 1.2 2016/01/30 19:06:33 aosorio Exp $

    Codifique un procedimiento para realizar una búsqueda binaria en un
  archivo (ordenado) de enteros. Compare la cantidad de accesos promedio de
  esta estrategia respecto a la del inciso 3.b.
}

const
  { Archivo con datos enteros }
  URI = 'ejercicio7.dat' ;
  { Cantidad de valores por defecto a cargar }
  CANTVAL = 100 ;

type
  archivo_enteros = file of integer ;

var
  archivo : archivo_enteros ;
  resultado, valor_buscado : integer ;

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

function elementoEnArchivo( buscado : integer ;
                            var archivo : archivo_enteros ) : integer ;
var
  inicio, medio, fin, posicion, actual, divisiones : integer ;
begin
  inicio := 0 ;
  fin := fileSize( archivo )-1 ;
  posicion := -1 ;
  divisiones := 0 ;
  seek( archivo, inicio ) ;

  while( ( not eof( archivo ) ) and ( inicio <= fin ) and ( posicion = -1 ) ) do
    begin
      medio := round( ( fin-inicio )/2 )+inicio ;
      divisiones := divisiones+1 ;
      writeln( 'INICIO: ', inicio, ', MEDIO: ', medio, ', FIN: ', fin ) ;
      seek( archivo, medio ) ;
      read( archivo, actual ) ;
      if( buscado = actual ) then
        posicion := medio
      else
        if( buscado > actual ) then
          inicio := medio+1
        else
          fin := medio-1 ;
    end ;

  writeln( 'Divisiones de búsqueda: ', divisiones ) ;

  elementoEnArchivo := posicion ;
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

procedure cargarDefaults( var archivo : archivo_enteros ) ;
var
  i : integer ;
begin
  seek( archivo, 0 ) ;
  for i := 0 to CANTVAL do
    write( archivo, i ) ;
end ;

begin
  if( not abreArchivo( archivo, URI, TRUE ) ) then
    begin
    writeln( 'No se puede abrir el archivo.' ) ;
    exit ;
    end ;

  cargarDefaults( archivo ) ;

  write( 'Ingrese el elemento a buscar (menor a ', CANTVAL, '): ' ) ;
  readln( valor_buscado ) ;

  resultado := elementoEnArchivo( valor_buscado, archivo ) ;

  if( resultado = -1 ) then
    writeln( 'El elemento no se encuentra en el archivo.' )
  else
    writeln( 'El elemento se encontró en la posición ', resultado, '.' ) ;

  close( archivo ) ;
end.
