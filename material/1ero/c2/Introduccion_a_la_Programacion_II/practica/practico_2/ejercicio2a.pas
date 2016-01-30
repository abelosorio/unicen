{
  $Id: ejercicio2a.pas,v 1.2 2016/01/30 19:06:34 aosorio Exp $

  2) Codifique procedimientos o funciones para manejo de tiempos:
    a) para cargar un "tiempo" (horas, minutos y segundos) desde teclado,
    validando que sea correcto.
}

type
  time = record
    h : 0..23 ;
    m : 0..59 ;
    s : 0..59 ;
  end ;

function horaCorrecta( hora : integer ) : boolean ;
begin
  horaCorrecta := ( ( hora >= 0 ) AND ( hora <= 23 ) ) ;
end ;

function minutoCorrecto( minuto : integer ) : boolean ;
begin
  minutoCorrecto := ( ( minuto >= 0 ) AND ( minuto <= 59 ) ) ;
end ;

function segundoCorrecto( segundo : integer ) : boolean ;
begin
  segundoCorrecto := ( ( segundo >= 0 ) AND ( segundo <= 59 ) ) ;
end ;

procedure leerParametroTime( var tiempo : time ) ;
var
  hora, minuto, segundo: integer ;
begin
  hora := -1 ;
  minuto := -1 ;
  segundo := -1 ;

  while( not horaCorrecta( hora ) ) do
    begin
    write( 'Ingrese la hora [0-23]: ' ) ;
    readln( hora ) ;
    end ;

  while( not minutoCorrecto( minuto ) ) do
    begin
    write( 'Ingrese el minuto [0-59]: ' ) ;
    readln( minuto ) ;
    end ;

  while( not segundoCorrecto( segundo ) ) do
    begin
    write( 'Ingrese el segundo [0-59]: ' ) ;
    readln( segundo ) ;
    end ;

  tiempo.h := hora ;
  tiempo.m := minuto ;
  tiempo.s := segundo ;
end ;
