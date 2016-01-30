program Ejercicio3b ;
{
  $Id: ejercicio3b.pas,v 1.2 2016/01/30 19:06:33 aosorio Exp $

    Teniendo en cuenta las suposiciones de los incisos a) y b) respectivamente,
  codifique una función que dado un número lo busque en un archivo de números y
  retorne la posición en la que lo encontró. Si no lo encuentra debe retornar
  -1.
  b) Suponga que los elementos del archivo se encuentran ordenados. Tenga en
  cuenta que, si el archivo está ordenado, no es necesario recorrerlo
  completamente. Explique por qué.

    Respuesta: Porque si el archivo está ordenado se compararán todos los
  elementos que sean menores (si el orden es ascendente) al buscado hasta llegar
  al mismo o a uno mayor, ya que si se encuentra uno mayor y no el buscado
  significa que el buscado no se encuentra.
}

type
  archivo_enteros = file of integer ;

var
  archivo : archivo_enteros ;
  valor_buscado : integer ;
  uri : string ;
  posicion : integer ;

function posicionElemento( var archivo : archivo_enteros ;
                           elemento : integer ) : integer ;
var
  valor : integer ;
  i : integer ;
  continuar : boolean ;

begin
  i := 0 ;
  continuar := TRUE ;

  seek( archivo, 0 ) ;

  while( ( i < fileSize( archivo ) ) AND continuar ) do
    begin
    read( archivo, valor ) ;
    if( valor >= elemento ) then
      continuar := FALSE ;
    i := i+1 ;
    end ;

  if( valor = elemento ) then
    posicionElemento := i-1
  else
    posicionElemento := -1 ;
end ;

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

begin
  write( 'Ingrese el nombre del archivo: ' ) ;
  readln( uri ) ;

  if( not abreArchivo( archivo, uri, FALSE ) ) then
    begin
    writeln( 'El archivo ' + uri + ' no existe.' ) ;
    exit ;
    end ;

  write( 'Ingrese el valor a buscar: ' ) ;
  readln( valor_buscado ) ;

  posicion := posicionElemento( archivo, valor_buscado ) ;

  if( posicion = -1 ) then
    writeln( 'Elemento no encontrado.' )
  else
    begin
    write( 'El elemento se encontró en la posición ' ) ;
    writeln( posicion ) ;
    end ;
end.
