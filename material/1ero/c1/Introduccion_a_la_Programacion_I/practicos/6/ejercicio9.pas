program Ejercicio9 ;
{
  $Id: ejercicio9.pas,v 1.2 2016/01/30 19:06:47 aosorio Exp $

  Dada una pila, devolver el número que se repite más veces.
}

uses Estructu ;

function contar_instancias( NUMERO : Integer ;
                            DADA : Pila ) : Integer ;
{
  Función que cuenta cuántas instancias hay de un número en una pila.

  Parámetros:
    NUMERO	Indica el número que desea contarse.
    DADA	Indica la pila donde buscar el número.

  Retorno:
    La cantidad de veces que existe el número en la pila. En el caso
    particular donde el número no existe en la pila se retorna 0.
}

var
  CONTADOR : Integer ;

begin
  CONTADOR := 0 ;

  while( not pilaVacia( DADA ) ) do
  begin
    if( tope( DADA ) = NUMERO ) then
      CONTADOR := CONTADOR + 1 ;
    desapilar( DADA ) ;
  end ;

  contar_instancias := CONTADOR ;
end ;

procedure eliminar_elemento( ELEMENTO : Integer ;
                             var DADA : Pila ) ;
{
  Procedimiento que elimina el número ELEMENTO de la pila DADA.

  Parámetros:
    ELEMENTO	Número a eliminar.
    DADA	Pila donde desea eliminarse el número.
}
var
  AUX1 : Pila ;

begin
  while( not pilaVacia( DADA ) ) do
    if( tope( DADA ) = ELEMENTO ) then
      desapilar( DADA )
    else
      apilar( AUX1, desapilar( DADA ) ) ;

  while( not pilaVacia( AUX1 ) ) do
    apilar( DADA, desapilar( AUX1 ) ) ;
end ;

procedure mostrar_repetido( ELEMENTO : Integer ;
                            REPETICIONES : Integer ) ;
{
  Procedimiento para mostrar un mensaje al usuario informando cuál es el
  número más repetido en la pila, y cuántas son las repeticiones.

  Parámetros:
    ELEMENTO		Número repetido.
    REPETICIONES	Cantidad de veces que se repite el número en la pila.
}

begin
  if( REPETICIONES <= 1 ) then
    writeln( 'No hay ningún número repetido en la pila.' )
  else
  begin
    write( 'El número más repetido es: ' ) ;
    write( ELEMENTO ) ;
    write( '. Con un total de repeticiones de: ' ) ;
    writeln( REPETICIONES ) ;
  end ;
end ;

var
  DADA, AUX1 : Pila ;
  INSTANCIAS, MAYOR_REPETIDO : Integer ;
  MAYOR_INSTANCIAS : Integer ;

begin

  MAYOR_INSTANCIAS := 0 ;
  inicPila( DADA, '12 43 3 43 7 13 12 3 7 7 13 12 25 7' ) ;
  inicPila( AUX1, '' ) ;

  while( not pilaVacia( DADA ) ) do
  begin
    INSTANCIAS := contar_instancias( tope( DADA ), DADA ) ;
    if( INSTANCIAS > MAYOR_INSTANCIAS ) then
    begin
      MAYOR_INSTANCIAS := INSTANCIAS ;
      MAYOR_REPETIDO := tope( DADA ) ;
    end ;
    eliminar_elemento( tope( DADA ), DADA ) ;
  end ;

  mostrar_repetido( MAYOR_REPETIDO, MAYOR_INSTANCIAS ) ;
end.
