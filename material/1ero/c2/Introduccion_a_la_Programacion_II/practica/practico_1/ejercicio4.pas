program Ejercicio4 ;
{
  $Id: ejercicio4.pas,v 1.2 2016/01/30 19:06:33 aosorio Exp $

    Suponga que tiene un archivo donde cada registro es un arreglo de 5 enteros.
  Cada entero corresponde a la nota en la materia 1, 2, 3, 4 y 5 de los alumnos
  de primer año de una carrera. Cada registro del archivo corresponde a las
  notas de un alumno y el archivo contiene las notas de todos los alumnos de
  primer año de la carrera. Codifique un procedimiento (¿por qué no función?)
  que devuelva un arreglo con la nota promedio en cada una de las materias.

           7      6     5     7     8
           3      9     8     5     4
           6      8     9     5     3
           5      6     5     7     8            5    8    5    6    5
           3      9     2     5     4            Promedio de cada materia
           6      8     2     4     3
                     Archivo
}

const
  CANTMATERIAS = 5 ;
  CANTNOTAS = 7 ;

type
  matriz_enteros = array [1..CANTNOTAS,1..CANTMATERIAS] of integer ;
  arreglo_promedios = array [1..CANTMATERIAS] of integer ;
  archivo_enteros = file of matriz_enteros ;

var
  matriz : matriz_enteros ;
  promedios : arreglo_promedios ;
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

procedure salvarDatos( var archivo : archivo_enteros ;
                       matriz : matriz_enteros ) ;
begin
  write( archivo, matriz ) ;
end ;

procedure leerDatos( var archivo : archivo_enteros ;
                     var matriz : matriz_enteros ) ;
begin
  seek( archivo, 0 ) ;
  read( archivo, matriz ) ;
end ;

function matrizDefault() : matriz_enteros ;
var
  i, j : integer ;
  matriz : matriz_enteros ;

begin
  for i := 1 to CANTNOTAS do
    for j := 1 to CANTMATERIAS do
      matriz[i][j] := ( (i+j)*j mod 10 )+1 ;

  matrizDefault := matriz ;
end ;

procedure mostrarMatriz( matriz : matriz_enteros ) ;
var
  i, j : integer ;

begin
  writeln( 'Notas' ) ;

  for i := 1 to CANTNOTAS do
    begin
    for j := 1 to CANTMATERIAS do
      write( matriz[i][j], '    ' ) ;
    writeln( '' ) ;
    end ;
end ;

function promedioMateria( notas : matriz_enteros ;
                          materia : integer ) : integer ;
var
  i, suma : integer ;

begin
  suma := 0 ;

  for i := 1 to CANTNOTAS do
    suma := suma+notas[i][materia] ;

  promedioMateria := round( suma/CANTNOTAS ) ;
end ;

procedure calcularPromedios( var promedios : arreglo_promedios ;
                             matriz : matriz_enteros ) ;
var
  i : integer ;
begin
  for i := 1 to CANTMATERIAS do
    promedios[i] := promedioMateria( matriz, i ) ;
end ;

procedure mostrarPromedios( promedios : arreglo_promedios ) ;
var
  i : integer ;

begin
  writeln( 'Promedios' ) ;

  for i := 1 to CANTMATERIAS do
    write( promedios[i], ' ' ) ;

  writeln( '' ) ;
end ;

begin
  matriz := matrizDefault() ;
  { Esto es para crear el archivo con valores default }
  abreArchivo( archivo, 'ejercicio4.dat', TRUE ) ;
  salvarDatos( archivo, matriz ) ;

  leerDatos( archivo, matriz ) ;
  close( archivo ) ;

  calcularPromedios( promedios, matriz ) ;

  mostrarMatriz( matriz ) ;
  mostrarPromedios( promedios ) ;
end.
