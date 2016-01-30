program ejercicio3 ;
{
  $Id: ejercicio3.pas,v 1.2 2016/01/30 19:06:34 aosorio Exp $

  3) Codifique procedimientos o funciones para manejo de fechas:
    a) para cargar una fecha desde teclado, validando que sea correcta.
    b) para sumar N días a una fecha.
    c) para calcular la cantidad de días entre dos fechas.
    d) para imprimir una fecha.
}

uses
  sysutils ;

type
  date = record
    d : 1..31 ;
    m : 1..12 ;
    y : 1960..2050 ;
  end ;

var
  fecha1, fecha2 : date ;
  dias_a_sumar : integer ;

function diaCorrecto( dia : integer ) : boolean ;
begin
  diaCorrecto := ( ( dia >= 1 ) AND ( dia <= 31 ) ) ;
end ;

function mesCorrecto( mes : integer ) : boolean ;
begin
  mesCorrecto := ( ( mes >= 1 ) AND ( mes <= 12 ) ) ;
end ;

function anioCorrecto( anio : integer ) : boolean ;
begin
  anioCorrecto := ( ( anio >= 1960 ) AND ( anio <= 2050 ) ) ;
end ;

procedure leerParametroDate( var fecha : date ) ;
var
  dia, mes, anio : integer ;
begin
  dia := -1 ;
  mes := -1 ;
  anio := -1 ;

  while( not diaCorrecto( dia ) ) do
    begin
    write( 'Ingrese el día [1-31]: ' ) ;
    readln( dia ) ;
    end ;

  while( not mesCorrecto( mes ) ) do
    begin
    write( 'Ingrese el mes [1-12]: ' ) ;
    readln( mes ) ;
    end ;

  while( not anioCorrecto( anio ) ) do
    begin
    write( 'Ingrese el año [1960-2050]: ' ) ;
    readln( anio ) ;
    end ;

  fecha.d := dia ;
  fecha.m := mes ;
  fecha.y := anio ;
end ;

procedure aumentarAnio( var fecha : date ) ;
begin
  if( fecha.y >= 2050 ) then
    begin
    writeln( '¡Fecha fuera de rango (', fecha.y , '-',
             fecha.m, '-', fecha.d, ')!' ) ;
    halt( 1 ) ;
    end ;

  fecha.y := succ( fecha.y ) ;
end ;

procedure aumentarMes( var fecha : date ) ;
begin
  if( fecha.m = 12 ) then
    begin
    aumentarAnio( fecha ) ;
    fecha.m := 1 ;
    end
  else
    fecha.m := succ( fecha.m ) ;
end ;

procedure sumarDiasAFecha( var fecha : date ;
                           dias : integer ) ;
begin
  while( dias > 0 ) do
    begin

    if( fecha.d = 31 ) then
      begin
      aumentarMes( fecha ) ;
      fecha.d := 1 ;
      end
    else
      fecha.d := succ( fecha.d ) ;

    dias := dias-1 ;
    end ;
end ;

function fechasIguales( fecha_1 : date ;
                        fecha_2 : date ) : boolean ;
begin
  fechasIguales := ( ( fecha_1.y = fecha_2.y ) AND
                     ( fecha_1.m = fecha_2.m ) AND
                     ( fecha_1.d = fecha_2.d ) ) ;
end ;

function fechaMayor( fecha_1 : date ;
                     fecha_2 : date ) : boolean ;
begin
  fechaMayor := (
  ( fecha_1.y > fecha_2.y ) OR
    ( fecha_1.y = fecha_2.y ) AND ( ( fecha_1.m > fecha_2.m ) OR
                                    ( ( fecha_1.m = fecha_2.m ) AND
                                      ( fecha_1.d > fecha_2.d ) ) ) ) ;
end ;

function distanciaEntreFechas( fecha_1 : date ;
                               fecha_2 : date ) : integer ;
var
  i : integer ;
  a, b : date ;
  invertir : boolean ;
begin
  i := 0 ;

  if( fechaMayor( fecha_1, fecha_2 ) ) then
    { fecha_1 es mayor a fecha_2 }
    begin
    a := fecha_1 ;
    b := fecha_2 ;
    invertir := true ;
    end
  else
    begin
    a := fecha_2 ;
    b := fecha_1 ;
    invertir := false ;
    end ;

  { Se asegura de que A sea mayor que B, entonces se van contando los días que
    se deben sumar a B hasta llegar a A. }
  while( not fechasIguales( a, b ) ) do
    begin
    sumarDiasAFecha( b, 1 ) ;
    i := i+1 ;
    end ;

  if( invertir ) then
    i := i*(-1) ;

  distanciaEntreFechas := i ;
end ;

function IntToStr( i : integer ) : string ;
var
  s : string ;
begin
 str( i, s ) ;
 IntToStr := s ;
end ;

function fechaFormateada( fecha : date ) : string ;
begin
  fechaFormateada := IntToStr( fecha.y ) + '-' + IntToStr( fecha.m ) + '-' +
                     IntToStr( fecha.d ) ;
end ;

procedure mostrarFecha( fecha : date ) ;
begin
  writeln( fechaFormateada( fecha ) ) ;
end ;

begin
  leerParametroDate( fecha1 ) ;
  leerParametroDate( fecha2 ) ;

  write( 'Ingrese una cantidad de días a sumarle a la primer fecha: ' ) ;
  readln( dias_a_sumar ) ;

  sumarDiasAFecha( fecha1, dias_a_sumar ) ;

  writeln( 'La distancia (en días) entre ', fechaFormateada( fecha1 ), ' y ',
           fechaFormateada( fecha2 ), ' es: ',
           distanciaEntreFechas( fecha1, fecha2 ), '.' ) ;

  mostrarFecha( fecha1 ) ;
  mostrarFecha( fecha2 ) ;
end.
