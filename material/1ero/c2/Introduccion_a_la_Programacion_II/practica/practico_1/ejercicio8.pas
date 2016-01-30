program Ejercicio8 ;
{
  $Id: ejercicio8.pas,v 1.2 2016/01/30 19:06:34 aosorio Exp $

    En una universidad se tienen dos archivos con los números (enteros) de
  legajo de alumnos, uno posee los inscriptos en Análisis y el otro en Álgebra.
  Ambos archivos están ordenados por el nº de legajo. Confeccione un programa
  que genere otro archivo con los nº de legajo de los alumnos que están
  inscriptos en ambas materias.
}

const
  URI1 = 'ejercicio8_1.dat' ;
  URI2 = 'ejercicio8_2.dat' ;
  URI3 = 'ejercicio8_3.dat' ;
  CANTVAL = 20 ;

type
  archivo_enteros = file of integer ;

var
  archivo1 : archivo_enteros ;
  archivo2 : archivo_enteros ;
  archivo_final : archivo_enteros ;

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

procedure cargarArchivo1( var archivo : archivo_enteros ) ;
var
  i : integer ;
begin
  seek( archivo, 0 ) ;
  for i := 1 to CANTVAL do
    if( ( i mod 2 = 0 ) ) then
      write( archivo, i ) ;
end ;

procedure cargarArchivo2( var archivo : archivo_enteros ) ;
var
  i : integer ;
begin
  seek( archivo, 0 ) ;
  for i := 1 to CANTVAL do
    if( ( i mod 4 = 0 ) ) then
      write( archivo, i ) ;
end ;

function elementoEnArchivo( buscado : integer ;
                            var archivo : archivo_enteros ) : integer ;
var
  inicio, medio, fin, posicion, actual : integer ;
begin
  inicio := 0 ;
  fin := fileSize( archivo )-1 ;
  posicion := -1 ;
  seek( archivo, inicio ) ;

  while( ( not eof( archivo ) ) and ( inicio <= fin ) and ( posicion = -1 ) ) do
    begin
      medio := round( ( fin-inicio )/2 )+inicio ;
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

  elementoEnArchivo := posicion ;
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
end ;

procedure unirArchivos( var archivo1 : archivo_enteros ;
                        var archivo2 : archivo_enteros ;
                        var archivo_final : archivo_enteros ) ;
var
  valor : integer ;

begin
  seek( archivo_final, 0 ) ;
  seek( archivo1, 0 ) ;
  while( not eof( archivo1 ) ) do
    begin
    read( archivo1, valor ) ;
    if( elementoEnArchivo( valor, archivo2 ) <> -1 ) then
      write( archivo_final, valor ) ;
    end ;
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
  if( not ( abreArchivo( archivo1, URI1, TRUE ) AND
            abreArchivo( archivo2, URI2, TRUE ) AND
            abreArchivo( archivo_final, URI3, TRUE ) ) ) then
    begin
    writeln( 'No se pueden abrir los archivos de legajos' ) ;
    exit ;
    end ;

  cargarArchivo1( archivo1 ) ;
  cargarArchivo2( archivo2 ) ;

  writeln( 'Archivo 1' ) ;
  mostrarArchivo( archivo1 ) ;
  writeln( 'Archivo 2' ) ;
  mostrarArchivo( archivo2 ) ;

  unirArchivos( archivo1, archivo2, archivo_final ) ;

  writeln( 'Archivo final' ) ;

  mostrarArchivo( archivo_final ) ;

  close( archivo1 ) ;
  close( archivo2 ) ;
  close( archivo_final ) ;
end.
