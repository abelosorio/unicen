program ejercicio4 ;
{
  $Id: ejercicio4.pas,v 1.2 2016/01/30 19:06:34 aosorio Exp $

    4) Se tiene un arreglo donde cada elemento es un registro con los datos de
  un alumno como se definió en el ejercicio 1. El arreglo se halla ordenado
  alfabéticamente según el apellido del alumno. Codificar un procedimiento que,
  dados el arreglo y un registro con los datos de un nuevo alumno, inserte
  dicho alumno en el arreglo, manteniendo el orden.
}

uses
  sysutils ;

const
  CANTALUMNOS = 10 ;

type
  fecha = record
    d : 1..31 ;
    m : 1..12 ;
    y : 1960..2050 ;
  end ;

  registro_alumno = record
    nombre : string ;
    apellido : string ;
    fecha_de_nacimiento : fecha ;
    domicilio : string ;
    telefono : integer ;
  end ;

  arreglo_alumnos = array [1..CANTALUMNOS] of registro_alumno ;

var
  alumnos : arreglo_alumnos ;
  alumno : registro_alumno ;

procedure cargarDefaults( var alumnos : arreglo_alumnos ) ;
begin
  alumnos[1].apellido := 'Gomez' ;
  alumnos[2].apellido := 'Osorio' ;
end ;

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

procedure leerParametroDate( var fecha : fecha ) ;
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

procedure leerNuevoAlumno( var alumno : registro_alumno ) ;
var
  nombre, apellido, domicilio : string ;
  telefono : integer ;
  fecha_de_nacimiento : fecha ;
begin
  write( 'Nombre: ' ) ;
  readln( nombre ) ;
  write( 'Apellido: ' ) ;
  readln( apellido ) ;
  write( 'Fecha de nacimiento (dd/mm/yyyy): ' ) ;
  leerParametroDate( fecha_de_nacimiento ) ;
  write( 'Domicilio: ' ) ;
  readln( domicilio ) ;
  write( 'Teléfono: ' ) ;
  readln( telefono ) ;

  alumno.nombre := nombre ;
  alumno.apellido := apellido ;
  alumno.fecha_de_nacimiento.d := fecha_de_nacimiento.d ;
  alumno.fecha_de_nacimiento.m := fecha_de_nacimiento.m ;
  alumno.fecha_de_nacimiento.y := fecha_de_nacimiento.y ;
  alumno.domicilio := domicilio ;
  alumno.telefono := telefono ;
end ;

function posicionNuevoRegistro( arreglo : arreglo_alumnos ;
                                apellido : string ) : integer ;
var
  i, posicion : integer ;
begin
  i := 1 ;
  posicion := -1 ;

  while( ( i <= CANTALUMNOS ) AND ( posicion = -1 ) ) do
    begin
    if( ( apellido >= arreglo[i].apellido ) AND
        ( ( arreglo[i+1].apellido = '' ) OR
          ( apellido <= arreglo[i+1].apellido )
      ) ) then
      posicion := i+1 ;
    i := i+1 ;
    end ;

  posicionNuevoRegistro := posicion ;
end ;

procedure desplazarRegistros( var arreglo : arreglo_alumnos ;
                              desde : integer ) ;
var
  i : integer ;
begin
  for i := CANTALUMNOS-1 downto desde do
    arreglo[i+1] := arreglo[i] ;
end ;

procedure insertarRegistro( alumno : registro_alumno ;
                            var alumnos : arreglo_alumnos ) ;
var
  posicion : integer ;
begin
  posicion := posicionNuevoRegistro( alumnos, alumno.apellido ) ;

  if( posicion <> -1 ) then
    begin
    desplazarRegistros( alumnos, posicion ) ;
    alumnos[posicion] := alumno ;
    end ;
end ;

procedure mostrarArreglo( alumnos : arreglo_alumnos ) ;
var
  i : integer ;
begin
  i := 1 ;
  while( ( alumnos[i].apellido <> '' ) AND ( i <= CANTALUMNOS ) ) do
    begin
    writeln( alumnos[i].apellido ) ;
    i := i+1 ;
    end ;
end ;

begin
  cargarDefaults( alumnos ) ;
  leerNuevoAlumno( alumno ) ;
  insertarRegistro( alumno, alumnos ) ;
  mostrarArreglo( alumnos ) ;
end.
