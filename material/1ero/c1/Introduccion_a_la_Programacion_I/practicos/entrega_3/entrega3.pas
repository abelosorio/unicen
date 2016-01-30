program entrega3 ;
{
  $Id: entrega3.pas,v 1.12 2016/01/30 19:06:47 aosorio Exp $

  ------------------------------------------------------------------------------

  Se tiene una matriz Aulas [1..CantAulas; 1..CantDias; 1..CantHoras] de chars
  que representa la ocupación, que hacen las cátedras de una facultad, de las
  aulas para dictar clases. Cada celda contiene un blanco (“ “) si esa aula
  está libre en esa hora y en ese día. Si está ocupada, tendrá un char que
  representa la materia (letra inicial de la materia) que dicta la clase en esa
  aula, ese día, a esa hora. Por otro lado, se tiene un arreglo CapacidadAulas
  [1..CantAulas] de integers, donde el índice representa el aula y el valor de
  la celda la capacidad del aula.
  Se pide que implemente los siguientes servicios:

  Servicio 1: Dado un char que represente una materia, una cantidad de alumnos,
  y la cantidad de horas de clase, encontrar un aula adecuada para dictar esa
  clase de manera continua. Si se encuentra ese lugar, actualizar la matriz
  ocupando las celdas indicadas. Si no se encuentra lugar, imprimir un mensaje
  indicando que no hay lugar para la clase.

  Servicio 2: Devolver el día con mayor ocupación en cuanto a aulas y horas.

  Servicio 3: Devolver una lista ordenada (arreglo de número de aula) de aulas
  según su cantidad de horas y días ocupados. Se puede usar en este servicio
  una estructura auxiliar.

  Se debe implementar el programa principal que permita ejecutar los 3
  servicios.

  ------------------------------------------------------------------------------

  Semántica de escritura de variables/constantes.

  <nombre>	(letra minúscula) variable local de procedimiento/función).

  <NOMBRE>	(letra mayúscula) variable global o constante).

  <_NOMBRE>	(letra mayúscula, comenzando con guión bajo) variable de
		parámetro de procedimiento/función.

  ------------------------------------------------------------------------------

  @NOTE
  - En los comentarios se utilizará #1 para hacer mención de la matriz AULAS, la
  que contiene información de aulas, días y horarios de cursado. Se utilizará #2
  para hacer mención del arreglo CAPACIDADAULAS, el cual contiene la capacidad
  de cada aula.

  ------------------------------------------------------------------------------

  Implementación de los servicios

  Servicio 1: Opción 1 del menú principal.
  Servicio 2: Opción 2 del menú principal.
  Servicio 3: Opción 3 del menú principal.
}

uses
{ sysutils se incluye para usar strtoint().
  crt se incluye para usar clrscr. }
  sysutils,
  crt ;

const
  CANTAULAS = 5 ; { Cantidad de aulas }
  CANTDIAS = 5 ; { Días de cursado }
  CANTHORAS = 7 ; { Horas de cursado }

type
  matriz_aulas = array[1..CANTAULAS,1..CANTDIAS,1..CANTHORAS] of char ;
  arreglo_capacidades = array[1..CANTAULAS] of integer ;
  matriz_auxiliar = array[1..CANTAULAS,1..3] of integer ;

var
  AULAS : matriz_aulas ; { Matriz de aulas (#1) }
  CAPACIDADAULAS : arreglo_capacidades ; { Arreglo de capacidades (#2) }
  OPCION_MP : integer ;

procedure cargar_aulas( var _AULAS : matriz_aulas ) ;
{
  ------------------------------------------------------------------------------
  Procedimiento para cargar la matriz de aulas con datos predefinidos.
  ------------------------------------------------------------------------------
  Parámetros
    _AULAS	Matriz de tipo matriz_aulas (#1).
  ------------------------------------------------------------------------------
}
var
  i, j, k : integer ;
begin
  for i := 1 to CANTAULAS do
    for j := 1 to CANTDIAS do
      for k := 1 to CANTHORAS do
        _AULAS[i][j][k] := ' ' ;

  for i := 1 to 3 do
    for j := 1 to 3 do
      for k := 3 to 5 do
        _AULAS[(i-1)*2+1][(j-1)*2+1][k] := 'O';
end ;

procedure cargar_capacidades( var _CAPACIDADAULAS : arreglo_capacidades ) ;
{
  ------------------------------------------------------------------------------
  Procedimiento para cargar el arreglo de capacidades de las aulas
  ------------------------------------------------------------------------------
  Parámetros
    _CAPACIDADAULAS
		Arreglo de tipo arreglo_capacidades (#2).
  ------------------------------------------------------------------------------
}
var
  i : integer ;
begin
  for i := 1 to CANTAULAS do
    _CAPACIDADAULAS[i] := 30+(i-2)*5 ;
end ;

procedure limpiar_pantalla() ;
{
  ------------------------------------------------------------------------------
  Procedimiento para limpiar la pantalla luego de que el usuario presione ENTER
  para continuar.
  ------------------------------------------------------------------------------
  Parámetros
    No tiene
  ------------------------------------------------------------------------------
}
begin
  writeln( '' ) ;
  writeln( '' ) ;
  write( 'Presione ENTER para continuar...' ) ;
  readln() ;
  clrscr ;
end ;

procedure imprimir_header_capacidades_aulas() ;
{
  ------------------------------------------------------------------------------
  Procedimiento que imprime el header de las capacidades de las aulas.
  ------------------------------------------------------------------------------
  Parámetros
    No tiene.
  ------------------------------------------------------------------------------
}
begin
  writeln( 'Capacidades de las aulas' ) ;
  writeln( '------------------------' ) ;
  writeln( '' ) ;
  writeln( ' Aula | Capacidad' ) ;
  writeln( ' -----+----------' ) ;
end ;

procedure imprimir_fila_capacidades_aulas( _AULA : integer;
                                           _CAPACIDAD : integer ) ;
{
  ------------------------------------------------------------------------------
  Procedimiento que imprime una fila del listado las capacidades de las aulas.
  ------------------------------------------------------------------------------
  Parámetros
    _AULA	Número de aula.
    _CAPACIDAD	Capacidad del aula.
  ------------------------------------------------------------------------------
}
begin
  writeln( ' ', _AULA, '    | ', _CAPACIDAD ) ;
end ;

procedure mostrar_capacidades_aulas( _CAPACIDADES : arreglo_capacidades ) ;
{
  ------------------------------------------------------------------------------
  Procedimiento para mostrar las capacidades de las aulas.
  ------------------------------------------------------------------------------
  Parámetros
    _CAPACIDADES
		Arreglo de tipo arreglo_capacidades (#2).
  ------------------------------------------------------------------------------
}
var
  i : integer ;
begin
  clrscr ;
  imprimir_header_capacidades_aulas() ;
  for i := 1 to CANTAULAS do
    imprimir_fila_capacidades_aulas( i, _CAPACIDADES[i] ) ;

  limpiar_pantalla() ;
end ;

function char_numerico( _CHAR : char ) : boolean ;
{
  ------------------------------------------------------------------------------
  Función para verificar si un caracter es numérico.
  ------------------------------------------------------------------------------
  Parámetros
    _CHAR	Caracter a analizar.
  ------------------------------------------------------------------------------
  Retorno
    Devuelve TRUE si el caracter es numérico o FALSE en caso contrario.
  ------------------------------------------------------------------------------
}
begin
  char_numerico := ( ( ord( _CHAR ) >= 48 ) AND ( ord( _CHAR ) <= 57 ) ) ;
end ;

function string_numerico( _STRING : string ) : boolean ;
{
  ------------------------------------------------------------------------------
  Función para verificar si una cadena contiene sólo números.
  ------------------------------------------------------------------------------
  Parámetros
    _STRING	Cadena a analizar.
  ------------------------------------------------------------------------------
  Retorno
    Devuelve TRUE si la cadena son números o FALSE en caso contrario.
  ------------------------------------------------------------------------------
}
var
  i : integer ;
  es_numero : boolean ;
  caracter : char ;
begin
  es_numero := TRUE ;
  i := 1 ;

  while( ( i <= length( _STRING ) ) AND es_numero ) do
    begin
    caracter := _STRING[i] ;
    es_numero := char_numerico( caracter ) ;
    i := i+1 ;
    end ;

  string_numerico := es_numero ;
end ;

function leer_parametro_char( _MENSAJE : string ) : char ;
{
  ------------------------------------------------------------------------------
  Función para leer un parámetro de tipo char desde teclado.
  ------------------------------------------------------------------------------
  Parámetros
    _MENSAJE	Mensaje mostrado al usuario para pedir el dato.
  ------------------------------------------------------------------------------
  Retorno
    El valor del parámetro ingresado por el usuario.
  ------------------------------------------------------------------------------
}
var
  parametro : char ;
begin
  write( _MENSAJE + ': ' ) ;
  readln( parametro ) ;

  leer_parametro_char := parametro ;
end ;

function leer_parametro_integer( _MENSAJE : string ) : integer ;
{
  ------------------------------------------------------------------------------
  Función para leer un parámetro de tipo integer desde teclado.
  ------------------------------------------------------------------------------
  Parámetros
    _MENSAJE	Mensaje mostrado al usuario para pedir el dato.
  ------------------------------------------------------------------------------
  Retorno
    El valor del parámetro ingresado por el usuario.
  ------------------------------------------------------------------------------
}
var
  parametro : string ;
  dato_valido : boolean ;
begin
  dato_valido := FALSE ;

  while( not dato_valido ) do
    begin
    dato_valido := TRUE ;
    write( _MENSAJE + ': ' ) ;
    readln( parametro ) ;
    if( ( not string_numerico( parametro ) ) OR ( parametro = '' ) ) then
      begin
      dato_valido := FALSE ;
      writeln( '' ) ;
      writeln( '¡El dato debe ser numérico! Ingreselo nuevamente por favor.' ) ;
      writeln( '' ) ;
      end ;
    end ;

  leer_parametro_integer := strtoint( parametro ) ;
end ;

function menu_principal() : integer ;
{
  ------------------------------------------------------------------------------
  Función que muestra un menú de opciones para interactuar con el usuario
  ------------------------------------------------------------------------------
  Parámetros
    No tiene
  ------------------------------------------------------------------------------
  Retorno
    La opción que se seleccionó. El tipo de la opción es char para que
    el programa no falle si el usuario tipea algo que no esté dentro de las
    opciones del menú, por ejemplo "A".
  ------------------------------------------------------------------------------
}
begin
  writeln( '' ) ;
  writeln( '=============================================================' ) ;
  writeln( ' Sistema de asignación de materias' ) ;
  writeln( '=============================================================' ) ;
  writeln( ' Seleccione la opción deseada:' ) ;
  writeln( '' ) ;
  writeln( '    1) Buscar lugar para dictar una materia.' ) ;
  writeln( '    2) Buscar el día más ocupado (en cuanto a aulas y horas).' ) ;
  writeln( '    3) Ver listado de aulas.' ) ;
  writeln( '    4) Ver listado de materias asignadas.' ) ;
  writeln( '    5) Ver capacidades de las aulas.' ) ;
  writeln( '    0) Salir.' ) ;
  writeln( '-------------------------------------------------------------' ) ;
  writeln( '' ) ;
  writeln( '' ) ;
  writeln( '' ) ;

  menu_principal := leer_parametro_integer( 'Opción' ) ;
end ;

procedure imprimir_header_materias_asignadas() ;
{
  ------------------------------------------------------------------------------
  Procedimiento que imprime el header de la lista de materias asignadas.
  ------------------------------------------------------------------------------
  Parámetros
    No tiene.
  ------------------------------------------------------------------------------
}
begin
  writeln( 'Listado de materias asignadas' ) ;
  writeln( '-----------------------------' ) ;
  writeln( '' ) ;
  writeln( ' Aula | Día | Hora | Materia' ) ;
  writeln( ' -----+-----+------+--------' ) ;
end ;

procedure imprimir_fila_materias_asignadas( _AULA : integer;
                                            _DIA : integer;
                                            _HORA : integer;
                                            _MATERIA : char ) ;
{
  ------------------------------------------------------------------------------
  Procedimiento que imprime una fila del listado de materias asignadas.
  ------------------------------------------------------------------------------
  Parámetros
    _AULA	Número de aula.
    _DIA 	Día de clase.
    _HORA 	Hora de clase.
    _MATERIA	Materia asignada (letra inicial).
  ------------------------------------------------------------------------------
}
begin
  writeln( ' ', _AULA, '    | ', _DIA, '   | ', _HORA, '    | ', _MATERIA ) ;
end ;

procedure mostrar_materias_asignadas( _AULAS : matriz_aulas ) ;
{
  ------------------------------------------------------------------------------
  Procedimiento para mostrar una lista de las materias asignadas, ordenado por
  aula, día y horario.
  ------------------------------------------------------------------------------
  Parámetros
    _AULAS	Matriz de tipo matriz_aulas (#1).
  ------------------------------------------------------------------------------
}
var
  i, j, k : integer ;
begin
  clrscr ;
  imprimir_header_materias_asignadas() ;
  for i := 1 to CANTAULAS do
    for j := 1 to CANTDIAS do
      for k := 1 to CANTHORAS do
        imprimir_fila_materias_asignadas( i, j, k, _AULAS[i][j][k] ) ;

  limpiar_pantalla() ;
end ;

procedure asignar_clase( var _AULAS : matriz_aulas;
                         _MATERIA : char;
                         _AULA: integer;
                         _DIA : integer;
                         _HORA_DESDE: integer;
                         _HORA_HASTA: integer ) ;
{
  ------------------------------------------------------------------------------
  Procedimiento para asignar una clase en un aula, día y horario.
  ------------------------------------------------------------------------------
  Parámetros
    _AULAS	Matriz de tipo matriz_aulas (#1).
    _MATERIA	Letra inicial de la materia a asignar.
    _AULA	Número de aula que se utilizará para la clase.
    _DIA	Día en que se dictará la materia.
    _HORA_DESDE	Hora de comienzo de clase.
    _HORA_HASTA	Hora de fin de clase.
  ------------------------------------------------------------------------------
}
var
  i : integer ;
begin
  for i := _HORA_DESDE to _HORA_HASTA do
    _AULAS[_AULA][_DIA][i] := _MATERIA ;
end ;

procedure buscar_disponibilidad_de_clase( var _AULAS : matriz_aulas;
                                          _CAPACIDADES : arreglo_capacidades;
                                          _MATERIA : char;
                                          _ALUMNOS : integer;
                                          _DURACION : integer ) ;
{
  ------------------------------------------------------------------------------
  Procedimiento para buscar la disponibilidad de un dictado de una materia en
  un aula, dia y horario disponible.
  ------------------------------------------------------------------------------
  Parámetros
    _AULAS	Matriz de tipo matriz_aulas (#1).
    _CAPACIDADES
		Arreglo de tipo arreglo_capacidades (#2).
    _MATERIA	Letra inicial de la materia que pretende dictarse.
    _ALUMNOS	Cantidad de alumnos que asistirán a clase.
    _DURACION	Duración de la clase.
  ------------------------------------------------------------------------------
}
var
  i, j, k, libre : integer ;
  clase_asignada : boolean ;
begin
  clase_asignada := FALSE ;
  i := 1 ;

  while( not clase_asignada AND ( i <= CANTAULAS ) ) do
    begin
    if( _CAPACIDADES[i] >= _ALUMNOS ) then
      begin
      j := 1 ;
      while( not clase_asignada AND ( j <= CANTDIAS ) ) do
        begin
        libre := 0 ;
        k := 1 ;
        while( not clase_asignada AND ( k <= CANTHORAS ) ) do
          begin
          if( _AULAS[i][j][k] = ' ' ) then
            libre := libre+1
          else
            libre := 0 ;
          if( libre = _DURACION ) then
            begin
            asignar_clase( _AULAS, _MATERIA, i, j, k-_DURACION+1, k ) ;
            clase_asignada := TRUE ;
            end ;
          k := k+1 ;
          end ;
        j := j+1 ;
        end ;
      end ;
    i := i+1 ;
    end ;

  writeln( '' ) ;
  if( clase_asignada ) then
    writeln( '--> La clase fue asignada exitosamente.' )
  else
    writeln( '--> ¡No hay disponibilidad para dictar la clase!' ) ;
  writeln( '' ) ;
  writeln( '' ) ;
  writeln( '' ) ;
end ;

procedure ejecutar_opcion_1( var _AULAS : matriz_aulas;
                             _CAPACIDADAULAS : arreglo_capacidades ) ;
{
  ------------------------------------------------------------------------------
  Procedimiento que ejecuta la opción 1 del menú principal
  ------------------------------------------------------------------------------
  Parámetros
    _AULAS	Matriz de tipo matriz_aulas (#1).
    _CAPACIDADAULAS
		Arreglo de tipo arreglo_capacidades (#2).
  ------------------------------------------------------------------------------
}
var
  materia : char ;
  alumnos, duracion : integer ;
begin
  clrscr ;
  materia := leer_parametro_char( 'Ingrese la letra inicial de la materia' ) ;
  alumnos := leer_parametro_integer(
               'Ingrese la cantidad de alumnos que cursarán a la clase' ) ;
  duracion := leer_parametro_integer(
                'Ingrese la duración (en hs) de la clase' ) ;

  buscar_disponibilidad_de_clase(
    _AULAS, _CAPACIDADAULAS, upcase( materia ), alumnos, duracion ) ;

  limpiar_pantalla() ;
end ;

function aulas_asignadas_por_dia( _AULAS : matriz_aulas;
                                  _DIA: integer ) : integer ;
{
  ------------------------------------------------------------------------------
  Función para calcular cuantas aulas tienen materias asignadas, por día.
  ------------------------------------------------------------------------------
  Parámetros
    _AULAS	Matriz de tipo matriz_aulas (#1).
    _DIA	Día que se analiza.
  ------------------------------------------------------------------------------
  Retorno
    La cantidad de materias asignadas para ese día.
  ------------------------------------------------------------------------------
}
var
  i, j, asignado : integer ;
  aula_asignada : boolean ;
begin
  asignado := 0 ;

  for i := 1 to CANTAULAS do
    begin
    aula_asignada := FALSE ;
    j := 1 ;
    while( not aula_asignada AND ( j <= CANTHORAS ) ) do
      begin
      if( _AULAS[i][_DIA][j] <> ' ' ) then
        begin
        asignado := asignado+1 ;
        aula_asignada := TRUE ;
        end ;
      j := j+1 ;
      end ;
    end ;

  aulas_asignadas_por_dia := asignado ;
end ;

function horas_ocupadas_por_dia( _AULAS : matriz_aulas;
                                 _DIA: integer ) : integer ;
{
  ------------------------------------------------------------------------------
  Función para calcular cuantas horas hay ocupadas en un día.
  ------------------------------------------------------------------------------
  Parámetros
    _AULAS	Matriz de tipo matriz_aulas (#1).
    _DIA	Día que se analiza.
  ------------------------------------------------------------------------------
  Retorno
    La cantidad de horas ocupadas para ese día.
  ------------------------------------------------------------------------------
}
var
  i, j, asignado : integer ;
begin
  asignado := 0 ;

  for i := 1 to CANTAULAS do
    for j := 1 to CANTHORAS do
      if( _AULAS[i][_DIA][j] <> ' ' ) then
          asignado := asignado+1 ;

  horas_ocupadas_por_dia := asignado ;
end ;

procedure buscar_dia_mas_ocupado( _AULAS : matriz_aulas ) ;
{
  ------------------------------------------------------------------------------
  Procedimiento que busca cuál es el día más ocupado con respecto a aulas y
  horas.
  ------------------------------------------------------------------------------
  Parámetros
    _AULAS	Matriz de tipo matriz_aulas (#1).
  ------------------------------------------------------------------------------
}
var
  i, aulas_asignadas, horas_ocupadas, dia_mas_ocupado : integer ;
  max_aulas_asignadas, max_horas_ocupadas : integer ;
begin
  max_aulas_asignadas := 0 ;
  max_horas_ocupadas := 0 ;

  for i := 1 to CANTDIAS do
    begin
    aulas_asignadas := aulas_asignadas_por_dia( _AULAS, i ) ;
    horas_ocupadas := horas_ocupadas_por_dia( _AULAS, i ) ;

    if( ( aulas_asignadas > max_aulas_asignadas ) OR
        ( ( aulas_asignadas = max_aulas_asignadas ) AND
          ( horas_ocupadas > max_horas_ocupadas ) ) ) then
      begin
      dia_mas_ocupado := i ;
      max_aulas_asignadas := aulas_asignadas ;
      max_horas_ocupadas := horas_ocupadas ;
      end ;
    end ;

  writeln( '' ) ;
  writeln( '--> El día más ocupado es el ', dia_mas_ocupado, ', con ',
           max_aulas_asignadas, ' aula/s asignada/s y ', max_horas_ocupadas,
           ' hora/s ocupada/s.' ) ;
  writeln( '' ) ;
  writeln( '' ) ;
  writeln( '' ) ;
end ;

procedure ejecutar_opcion_2( _AULAS : matriz_aulas ) ;
{
  ------------------------------------------------------------------------------
  Procedimiento que ejecuta la opción 2 del menú principal.
  ------------------------------------------------------------------------------
  Parámetros
    _AULAS	Matriz de tipo matriz_aulas (#1).
  ------------------------------------------------------------------------------
}
begin
  buscar_dia_mas_ocupado( _AULAS ) ;
  limpiar_pantalla() ;
end ;

procedure imprimir_header_aulas_ocupadas() ;
{
  ------------------------------------------------------------------------------
  Procedimiento que imprime el header de la lista de aulas ocupadas.
  ------------------------------------------------------------------------------
  Parámetros
    No tiene.
  ------------------------------------------------------------------------------
}
begin
  writeln( 'Listado de aulas ocupadas' ) ;
  writeln( '-----------------------------' ) ;
  writeln( '' ) ;
  writeln( ' Aula | Días ocupados | Horas ocupadas' ) ;
  writeln( ' -----+---------------+---------------' ) ;
end ;

procedure imprimir_fila_aulas_ocupadas( _AULA : integer;
                                        _DIAS_OCUPADOS : integer;
                                        _HORAS_OCUPADAS : integer ) ;
{
  ------------------------------------------------------------------------------
  Procedimiento que imprime una fila del listado de aulas ocupadas.
  ------------------------------------------------------------------------------
  Parámetros
    _AULA	Número de aula.
    _DIAS_OCUPADOS
		Días en que el aula está ocupada.
    _HORAS_OCUPADAS
		Cantidad de horas en las que el aula está ocupada.
  ------------------------------------------------------------------------------
}
begin
  writeln( ' ', _AULA, '    | ', _DIAS_OCUPADOS, '             | ',
           _HORAS_OCUPADAS ) ;
end ;

procedure inicializar_matriz_auxiliar( var _AUXILIAR : matriz_auxiliar ) ;
{
  ------------------------------------------------------------------------------
  Procedimiento para inicializar la matriz _AUXILIAR con valores nulos.
  ------------------------------------------------------------------------------
  Parámetros
    _AUXILIAR	Matriz de tipo matriz_auxiliar.
  ------------------------------------------------------------------------------
}
var
  i,j : integer ;
begin
  for i := 1 to CANTAULAS do
    for j := 1 to 3 do
    _AUXILIAR[i][j] := -1 ;
end ;

function horas_ocupadas_por_aula( _AULAS : matriz_aulas;
                                  _AULA : integer ) : integer ;
{
  ------------------------------------------------------------------------------
  Función que calcula cuántas horas está ocupada un aula determinada.
  ------------------------------------------------------------------------------
  Parámetros
    _AULAS	Matriz de tipo matriz_aulas (#1).
    _AULA	Número de aula.
  ------------------------------------------------------------------------------
  Retorno
    La cantidad de horas en que el aula está ocupada, o 0 en su defecto.
  ------------------------------------------------------------------------------
}
var
  i, j, horas_ocupadas : integer ;
begin
  horas_ocupadas := 0 ;

  for i := 1 to CANTDIAS do
    for j := 1 to CANTHORAS do
      if( _AULAS[_AULA][i][j] <> ' ' ) then
        horas_ocupadas := horas_ocupadas+1 ;

  horas_ocupadas_por_aula := horas_ocupadas ;
end ;

function dias_ocupados_por_aula( _AULAS : matriz_aulas;
                                 _AULA : integer ) : integer ;
{
  ------------------------------------------------------------------------------
  Función que calcula cuántos días está ocupada un aula determinada.
  ------------------------------------------------------------------------------
  Parámetros
    _AULAS	Matriz de tipo matriz_aulas (#1).
    _AULA	Número de aula.
  ------------------------------------------------------------------------------
  Retorno
    La cantidad de días en que el aula está ocupada, o 0 en su defecto.
  ------------------------------------------------------------------------------
}
var
  i, j, dia_ocupado, dias_ocupados : integer ;
begin
  dias_ocupados := 0 ;

  for i := 1 to CANTDIAS do
    begin
    dia_ocupado := 0 ;
    j := 1 ;
    while( ( j <= CANTHORAS ) AND ( dia_ocupado = 0 ) ) do
      begin
      if( _AULAS[_AULA][i][j] <> ' ' ) then
        dia_ocupado := 1 ;
      j := j+1 ;
      end ;
    dias_ocupados := dias_ocupados+dia_ocupado ;
    end ;

  dias_ocupados_por_aula := dias_ocupados ;
end ;

function auxiliar_aulas_ocupadas( _AULAS : matriz_aulas ) : matriz_auxiliar ;
{
  ------------------------------------------------------------------------------
  Función que genera una matriz auxiliar para imprimir el listado de aulas
  ocupadas.
  ------------------------------------------------------------------------------
  Parámetros
    _AULAS	Matriz de tipo matriz_aulas (#1).
  ------------------------------------------------------------------------------
  Retorno
    La matriz auxiliar.
  ------------------------------------------------------------------------------
}
var
  i, dias_ocupados, horas_ocupadas, fila : integer ;
  auxiliar : matriz_auxiliar ;
begin
  fila := 1 ;
  inicializar_matriz_auxiliar( auxiliar ) ;

  for i := 1 to CANTAULAS do
    begin
    dias_ocupados := dias_ocupados_por_aula( _AULAS, i ) ;
    horas_ocupadas := horas_ocupadas_por_aula( _AULAS, i ) ;
    if( horas_ocupadas > 0 ) then
      begin
      auxiliar[fila][1] := i ;
      auxiliar[fila][2] := dias_ocupados ;
      auxiliar[fila][3] := horas_ocupadas ;
      fila := fila+1 ;
      end ;
    end ;

  auxiliar_aulas_ocupadas := auxiliar ;
end ;

procedure swap_fila_matriz_auxiliar( var _AUXILIAR : matriz_auxiliar;
                                     _FILA1 : integer;
                                     _FILA2 : integer ) ;
{
  ------------------------------------------------------------------------------
  Procedimiento que intercambia los valores de las filas dadas de la matriz
  auxiliar.
  ------------------------------------------------------------------------------
  Parámetros
    _AUXILIAR	Matriz de tipo matriz auxiliar.
    _FILA1	El número de una de las filas a intercambiar.
    _FILA2	El número de la otra fila.
  ------------------------------------------------------------------------------
}
var
  auxiliar, i : integer ;
begin
  for i := 1 to 3 do
    begin
    auxiliar := _AUXILIAR[_FILA1][i] ;
    _AUXILIAR[_FILA1][i] := _AUXILIAR[_FILA2][i] ;
    _AUXILIAR[_FILA2][i] := auxiliar ;
    end ;
end ;

procedure ordenar_matriz_auxiliar( var _AUXILIAR : matriz_auxiliar ) ;
{
  ------------------------------------------------------------------------------
  Procedimiento que ordena la matriz auxiliar según días y horas ocupadas.
  ------------------------------------------------------------------------------
  Parámetros
    _AUXILIAR	Matriz de tipo matriz_auxiliar.
  ------------------------------------------------------------------------------
}
var
  i, j : integer ;
begin
  i := 1 ;

  while( ( i <= CANTAULAS-1 ) AND ( _AUXILIAR[i][1] <> -1 ) ) do
    begin
    j := i+1 ;
    while( ( j <= CANTAULAS ) AND ( _AUXILIAR[j][1] <> -1 ) ) do
      begin
      if( ( _AUXILIAR[j][2] > _AUXILIAR[i][2] ) OR
          ( ( _AUXILIAR[j][2] = _AUXILIAR[i][2] ) AND
            ( _AUXILIAR[j][3] > _AUXILIAR[i][3] ) ) ) then
        swap_fila_matriz_auxiliar( _AUXILIAR, i, j ) ;
      j := j+1 ;
      end ;
    i := i+1 ;
    end ;
end ;

procedure imprimir_matriz_auxiliar( _AUXILIAR : matriz_auxiliar ) ;
{
  ------------------------------------------------------------------------------
  Procedimiento para imprimir la matriz auxiliar.
  ------------------------------------------------------------------------------
  Parámetros
    _AUXILIAR	Matriz de tipo matriz_auxiliar.
  ------------------------------------------------------------------------------
}
var
  i : integer ;
begin
  imprimir_header_aulas_ocupadas() ;
  i := 1 ;

  while( ( _AUXILIAR[i][1] <> -1 ) AND ( i <= CANTAULAS ) ) do
    begin
      imprimir_fila_aulas_ocupadas( _AUXILIAR[i][1], _AUXILIAR[i][2],
                                    _AUXILIAR[i][3] ) ;
      i := i+1 ;
    end ;
end ;

procedure mostrar_aulas_ocupadas( _AULAS : matriz_aulas ) ;
{
  ------------------------------------------------------------------------------
  Procedimiento que muestra un listado de las aulas ocupadas, según su cantidad
  de horas y días ocupados.
  ------------------------------------------------------------------------------
  Parámetros
    _AULAS	Matriz de tipo matriz_aulas (#1).
  ------------------------------------------------------------------------------
}
var
  auxiliar : matriz_auxiliar ;
begin
  clrscr ;
  auxiliar := auxiliar_aulas_ocupadas( _AULAS ) ;
  ordenar_matriz_auxiliar( auxiliar ) ;
  imprimir_matriz_auxiliar( auxiliar ) ;
end ;

procedure ejecutar_opcion_3( _AULAS : matriz_aulas ) ;
{
  ------------------------------------------------------------------------------
  Procedimiento que ejecuta la opción 3 del menú principal.
  ------------------------------------------------------------------------------
  Parámetros
    _AULAS	Matriz de tipo matriz_aulas (#1).
  ------------------------------------------------------------------------------
}
begin
  mostrar_aulas_ocupadas( _AULAS ) ;
  limpiar_pantalla() ;
end ;

{
  ------------------------------------------------------------------------------
  Comienzo del bloque principal
  ------------------------------------------------------------------------------
}
begin
  clrscr ;
  cargar_aulas( AULAS ) ;
  cargar_capacidades( CAPACIDADAULAS ) ;
  OPCION_MP := 99 ;

  while( OPCION_MP <> 0 ) do
    begin
    OPCION_MP := menu_principal() ;
    case OPCION_MP of
      1: ejecutar_opcion_1( AULAS, CAPACIDADAULAS ) ;
      2: ejecutar_opcion_2( AULAS ) ;
      3: ejecutar_opcion_3( AULAS ) ;
      4: mostrar_materias_asignadas( AULAS ) ;
      5: mostrar_capacidades_aulas( CAPACIDADAULAS ) ;
      else
        clrscr ;
      end ;
    end ;
end.
