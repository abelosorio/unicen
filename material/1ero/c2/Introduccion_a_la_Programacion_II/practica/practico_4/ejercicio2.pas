{
  $Id: ejercicio2.pas,v 1.2 2016/01/30 19:06:34 aosorio Exp $

  Se tiene una lista vinculada de alumnos en el que cada nodo posee los
  siguientes datos:
    - Apellido y Nombre
    - Curso (1ro, 2do, 3ro, 4to o 5to)
    - DNI
    - Domicilio
    - Teléfono
    - Edad
  La lista se encuentra ordenada por curso y dentro de cada curso por
  apellido. Para obtener un listado alfabético de todos los alumnos
  implementaremos una lista “invertida”. Los nodos de una lista invertida
  apuntan a los nodos de la lista original pero se vinculan entre si en otro
  orden, como en el siguiente gráfico (ver pdf).

  Si recorremos la lista invertida, el orden de los nodos es alfabético
  (Alvarez, Britos, Gomez, Ramirez, Sanchez) en lugar de por curso y esto nos
  permite emitir el listado con una pasada.
  Codifique el procedimiento que, dada la lista vinculada original, construya y
  devuelva la lista invertida correspondiente.
}

program ejercicio2 ;

type
  tipo_curso = 1..5 ;
  puntero_alumnos = ^registro_alumnos ;
  registro_alumnos = record
    apellido : string ;
    nombre : string ;
    curso : tipo_curso ;
    domicilio : string ;
    telefono : integer ;
    edad : integer ;
    siguiente : puntero_alumnos ;
  end ;
  puntero_invertida = ^registro_invertida ;
  registro_invertida = record
    puntero : puntero_alumnos ;
    siguiente : puntero_invertida ;
  end ;

var
  alumnos : puntero_alumnos ;

procedure agregar_alumno( var alumnos : puntero_alumnos ;
                          apellido : string ;
                          nombre : string ;
                          curso : tipo_curso ;
                          domicilio : string ;
                          telefono : integer ;
                          edad : integer ) ;
var
  aagregar, cursor, anterior : puntero_alumnos ;
  continuar : boolean ;
begin
  new( aagregar ) ;
  aagregar^.apellido := apellido ;
  aagregar^.nombre := nombre ;
  aagregar^.curso := curso ;
  aagregar^.domicilio := domicilio ;
  aagregar^.telefono := telefono ;
  aagregar^.edad := edad ;
  aagregar^.siguiente := nil ;

  if ( alumnos = nil ) then
    alumnos := aagregar
  else begin
    cursor := alumnos ;
    anterior := nil ;

    continuar := TRUE ;

    while ( continuar ) and ( cursor <> nil ) and ( cursor^.curso <= curso ) do
      if ( cursor^.curso = curso ) and ( cursor^.apellido >= apellido ) then
        continuar := false
      else begin
        anterior := cursor ;
        cursor := cursor^.siguiente ;
      end ;

    aagregar^.siguiente := cursor ;

    if ( anterior = nil ) then
      alumnos := aagregar
    else
      anterior^.siguiente := aagregar ;
  end ;
end ;

procedure cargar_defaults( var alumnos : puntero_alumnos ) ;
begin
  agregar_alumno( alumnos, 'Alvarez', '', 2, '', 0, 18 ) ;
  agregar_alumno( alumnos, 'Sanchez', '', 1, '', 0, 18 ) ;
  agregar_alumno( alumnos, 'Britos',  '', 1, '', 0, 18 ) ;
  agregar_alumno( alumnos, 'Gomez',   '', 1, '', 0, 18 ) ;
  agregar_alumno( alumnos, 'Ramirez', '', 4, '', 0, 18 ) ;
end ;

procedure agregar_vinculo( alumnos : puntero_alumnos ;
                           var invertida : puntero_invertida ) ;
var
  cursor, anterior, aagregar : puntero_invertida ;
begin
  cursor := invertida ;
  anterior := nil ;

  new( aagregar ) ;
  aagregar^.puntero := alumnos ;
  aagregar^.siguiente := nil ;

  while ( cursor <> nil ) and
        ( cursor^.puntero^.apellido <= alumnos^.apellido ) do begin
    anterior := cursor ;
    cursor := cursor^.siguiente ;
  end ;

  aagregar^.siguiente := cursor ;

  if ( anterior = nil ) then
    invertida := aagregar
  else
    anterior^.siguiente := aagregar ;
end ;

function lista_invertida( alumnos : puntero_alumnos ) : puntero_invertida ;
var
  auxiliar : puntero_invertida ;
begin
  auxiliar := nil ;

  while ( alumnos <> nil ) do begin
    agregar_vinculo( alumnos, auxiliar ) ;
    alumnos := alumnos^.siguiente ;
  end ;

  lista_invertida := auxiliar ;
end ;

procedure mostrar_lista( alumnos : puntero_alumnos ) ;
begin
  while ( alumnos <> nil ) do begin
    writeln( alumnos^.curso, ' - ', alumnos^.apellido ) ;
    alumnos := alumnos^.siguiente ;
  end ;
end ;

procedure mostrar_lista_invertida( invertida : puntero_invertida ) ;
begin
  while ( invertida <> nil ) do begin
    writeln( invertida^.puntero^.curso, ' - ', invertida^.puntero^.apellido ) ;
    invertida := invertida^.siguiente ;
  end ;
end ;

begin
  cargar_defaults( alumnos ) ;
  writeln( 'Lista normal' ) ;
  mostrar_lista( alumnos ) ;
  writeln( 'Lista invertida' ) ;
  mostrar_lista_invertida( lista_invertida( alumnos ) ) ;
end.
