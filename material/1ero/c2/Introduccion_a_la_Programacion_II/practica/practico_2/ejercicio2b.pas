{
  $Id: ejercicio2b.pas,v 1.2 2016/01/30 19:06:34 aosorio Exp $

  2) Codifique procedimientos o funciones para manejo de tiempos:
    b) para sumar N segundos a un tiempo.

}

type
  time = record
    h : 0..23 ;
    m : 0..59 ;
    s : 0..59 ;
  end ;

function segundoCorrecto( segundo : integer ) : boolean ;
begin
  segundoCorrecto := ( ( segundo >= 0 ) AND ( segundo <= 59 ) ) ;
end ;

procedure sumaSegundo( tiempo : time ;
                       segundos : integer ) : time ;
begin
  while( segundos > 0 ) do
    begin
    if( tiempo.s = 59 ) then
      begin
      if( tiempo.m = 59 ) then
        tiempo.h := succ( tiempo.h ) ;
      tiempo.m := succ( tiempo.m ) ;
      end ;

    tiempo.s := succ( tiempo.s ) ;
    segundos := segundos-1 ;
    end ;

  sumaSegundo := tiempo ;
end ;
