program pascal_market;
{
  $Id: pascal_market.pas,v 1.24 2016/01/30 19:06:35 aosorio Exp $

  Pascal Market es una tienda de aplicaciones donde los usuarios puede ver,
  subir y comprar aplicaciones.
}

uses
  sysutils,
  crt;

const
  { Precio máximo por aplicación. }
  MAX_PRECIO = 9999;
  { Archivo de datos. }
  PMDATA = 'pascal_market.dat';

type
  AUsuarios	 = ^RecUsuarios;
  ApUsuario	 = ^RecApUsuario;
  LAplicaciones	 = ^RecLAplicaciones;
  AAplicaciones	 = ^RecAAplicaciones;
  LAuxRanking	 = ^RecAuxRanking;
  LAuxRanking2	 = ^RecAuxRanking2;
  TipoUsuario    = string[20];
  TipoAplicacion = string[20];
  TipoUbicacion  = string[100];

  { Registro para el arbol de Usuarios. }
  RecUsuarios = record
    usuario : TipoUsuario;
    aplicaciones : ApUsuario;
    menores, mayores : AUsuarios;
  end;

  { Registro para la lista de aplicaciones de cada usuario. }
  RecApUsuario = record
    aplicacion : AAplicaciones;
    siguiente : ApUsuario;
  end;

  { Registro para la lista de categorías. }
  RecLAplicaciones = record
    categoria : string;
    aplicaciones : AAplicaciones;
    siguiente : LAplicaciones;
  end;

  { Registro para el arbol de aplicaciones. }
  RecAAplicaciones = record
    nombre : TipoAplicacion;
    descripcion : string;
    precio : real;
    cantidad_de_descargas : integer;
    usuario : AUsuarios;
    ubicacion : TipoUbicacion;
    menores, mayores : AAplicaciones;
  end;

  { Registro para el archivo de datos. }
  RecArcAplicaciones = record
    usuario : TipoUsuario;
    aplicacion : TipoAplicacion;
    categoria, descripcion : string;
    precio : real;
    cantidad_de_descargas : integer;
    ubicacion : TipoUbicacion;
  end;

  { Registro auxiliar utilizado para generar el ranking de aplicaciones por
    cantidad de descargas. }
  RecAuxRanking = record
    cantidad_de_descargas : integer;
    nombre : TipoAplicacion;
    categoria : string;
    precio : real;
    siguiente : LAuxRanking;
  end;

  { Registro auxiliar utilizado para generar el ranking de categorías por
    total de ganancias. }
  RecAuxRanking2 = record
    categoria : string;
    ganancia : real;
    siguiente : LAuxRanking2;
  end;

  ArcAplicaciones = file of RecArcAplicaciones;

{
  Función para abrir un archivo. Si no existe se crea.
}
function abre_archivo(var archivo : ArcAplicaciones) : boolean;
begin
  assign(archivo, PMDATA);
  {$I-};
  reset(archivo);
  {$I+};
  if (ioresult <> 0) then rewrite(archivo);

  abre_archivo := (ioresult = 0);
end;

{
  Procedimiento para limpiar la pantalla luego de que el usuario presione ENTER
  para continuar.
}
procedure limpiar_pantalla() ;
begin
  writeln();
  writeln();
  write('Presione ENTER para continuar...');
  readln();
  clrscr;
end;

{
  Función que lee un nombre de usuario ingresado por consola y devuelve su
  contenido.
}
function leer_usuario() : TipoUsuario;
var
  usuario : string;
begin
  repeat
    write('Ingrese el usuario (máximo 20 caracteres): ');
    readln(usuario);
  until (length(usuario) > 0) and (length(usuario) <= 20);
  leer_usuario := usuario;
end;

{
  Función que lee un nombre de aplicación ingresado por consola y devuelve su
  contenido.
}
function leer_aplicacion() : TipoAplicacion;
var
  aplicacion : string;
begin
  repeat
    write('Nombre de la aplicación (máximo 20 caracteres): ');
    readln(aplicacion);
  until (length(aplicacion) > 0) and (length(aplicacion) <= 20);
  leer_aplicacion := aplicacion;
end;

{
  Función que lee un nombre de categoría ingresado por consola y devuelve su
  contenido.
}
function leer_categoria() : string;
var
  categoria : string;
begin
  repeat
    write('Categoría: ');
    readln(categoria);
  until (length(categoria) > 0);
  leer_categoria := categoria;
end;

{
  Función que lee una descripción (de aplicación) ingresada por consola y
  devuelve su contenido.
}
function leer_descripcion() : string;
var
  descripcion : string;
begin
  repeat
    write('Descripción: ');
    readln(descripcion);
  until (length(descripcion) > 0);
  leer_descripcion := descripcion;
end;

{
  Función que lee una ubicación ingresada por consola y devuelve su contenido.
}
function leer_ubicacion() : TipoUbicacion;
var
  ubicacion : string;
begin
  repeat
    write('Ubicación de la aplicación (100 caracteres máximo): ');
    readln(ubicacion);
  until (length(ubicacion) > 0) and (length(ubicacion) <= 100);
  leer_ubicacion := ubicacion;
end;

{
  Función que lee un precio ingresado por consola y devuelve su contenido.
}
function leer_precio() : real;
var
  precio : real;
begin
  repeat
    {$I-};
    write('Precio: ');
    readln(precio);
    {$I+};
  { Pascal Market distribuye también software no comercial (precio 0). }
  until (ioresult = 0) and (precio >= 0) and (precio <= MAX_PRECIO);
  leer_precio := precio;
end;

{
  Función que lee la opción del menú ingresada por consola.
}
function leer_opcion_menu() : integer;
var
  opcion : integer;
begin
  repeat
    {$I-};
    write('Opción: ');
    readln(opcion);
    {$I+};
  until (ioresult = 0);
  leer_opcion_menu := opcion;
end;

{
  Procedimiento para imprimir un texto en forma de título.
}
procedure imprimir_titulo(titulo : string);
var
  subrayado : string;
  i : integer;
begin
  subrayado := '';
  if (length(titulo) > 0) then begin
    for i := 1 to length(titulo) do subrayado := subrayado + '-';
    writeln(titulo);
    writeln(subrayado);
    writeln();
    writeln();
  end;
end;

{
  Función para buscar el nodo de un usuario en el árbol de usuarios.
  Si el usuario existe se retorna el puntero. Sino, si crear=TRUE
  se crea el nodo y se retorna el nuevo puntero, sino se retorna nil.
}
function nodo_usuario(var Usuarios : AUsuarios;
                      usuario : TipoUsuario;
                      crear : boolean) : AUsuarios;
begin
  if (Usuarios = nil) then
    if (crear) then begin
      new(Usuarios);
      Usuarios^.usuario := usuario;
      Usuarios^.aplicaciones := nil;
      Usuarios^.menores := nil;
      Usuarios^.mayores := nil;
      nodo_usuario := Usuarios;
    end else
      nodo_usuario := nil
  else if (usuario = Usuarios^.usuario) then
    nodo_usuario := Usuarios
  else if (upcase(usuario) > upcase(Usuarios^.usuario)) then
    nodo_usuario := nodo_usuario(Usuarios^.mayores, usuario, crear)
  else
    nodo_usuario := nodo_usuario(Usuarios^.menores, usuario, crear);
end;

{
  Función para crear un nuevo nodo para una categoría.
}
function nuevo_nodo_categoria(categoria : string) : LAplicaciones;
var
  nuevo : LAplicaciones;
begin
  new(nuevo);
  nuevo^.categoria := categoria;
  nuevo^.aplicaciones := nil;
  nuevo^.siguiente := nil;
  nuevo_nodo_categoria := nuevo;
end;

{
  Función para buscar el nodo de una categoría. Si la categoría ya existe sólo
  se retorna el puntero que apunta a la misma. Si el parámetro crear es TRUE y
  el nodo no existe se crea. Si el parámetro crear es FALSE y la categoría no
  existe, se retorna nil.
  Cuando el nodo es creado, la variable de referencia 'crear' se setea en TRUE,
  de lo contrario se pasa a FALSE.
}
function nodo_categoria(var Categorias : LAplicaciones;
                        categoria : string;
                        var crear : boolean) : LAplicaciones;
var
  AAgregar, cursor, anterior : LAplicaciones;
begin
  anterior := nil;
  cursor := Categorias;

  while (cursor <> nil) and (cursor^.categoria < categoria) do begin
    anterior := cursor;
    cursor := cursor^.siguiente;
  end;

  if (cursor <> nil) and (cursor^.categoria = categoria) then begin
    { La categoría ya existe. }
    crear := FALSE;
    nodo_categoria := cursor;
  end else
    { La categoría no existe. }
    if (crear) then begin
      AAgregar := nuevo_nodo_categoria(categoria);
      AAgregar^.siguiente := cursor;

      if (anterior = nil) then
        Categorias := AAgregar
      else
        anterior^.siguiente := AAgregar;

      nodo_categoria := AAgregar;
    end else begin
      crear := FALSE;
      nodo_categoria := nil;
    end;
end;

{
  Función para obtener el puntero que apunta a un nodo en el arbol de
  categorías, para una aplicación de una categoría determinada.

  Notas:

  - Si la aplicación no existe y el parámetro crear es FALSE, se retorna
  nil, sino se retorna el puntero donde debería ser ingresada la aplicación, y
  al nombre de la aplicación se le pone NUEVO para identificarla.

  - Si la aplicación es creada (crear=TRUE), la variable crear (que se toma por
  referencia) se setea en TRUE, sino en FALSE. Esta es la forma se saber si el
  nodo es nuevo o preexistente.
}
function nodo_aplicacion(var Aplicaciones : AAplicaciones;
                         aplicacion : TipoAplicacion;
                         var crear : boolean) : AAplicaciones;
begin
  if (Aplicaciones = nil) then
    { La aplicación no existe. }
    if (crear) then begin
      { Si crear=TRUE se crea un nodo nuevo. Se mantiene el valor TRUE de
        crear para distinguir que es un nodo nuevo. }
      new(Aplicaciones);
      nodo_aplicacion := Aplicaciones;
    end else begin
      nodo_aplicacion := nil;
      crear := FALSE;
    end
  else if (aplicacion = Aplicaciones^.nombre) then begin
    { La aplicación ya existe. }
    nodo_aplicacion := Aplicaciones;
    crear := FALSE;
  end else if (upcase(aplicacion) < upcase(Aplicaciones^.nombre)) then
    nodo_aplicacion := nodo_aplicacion(Aplicaciones^.menores, aplicacion, crear)
  else if (upcase(aplicacion) > upcase(Aplicaciones^.nombre)) then
    nodo_aplicacion := nodo_aplicacion(Aplicaciones^.mayores, aplicacion,
                         crear);
end;

{
  Procedimiento para agregar una nueva aplicación en la lista de aplicaciones
  de un usuario.
}
procedure asignar_aplicacion_a_usuario(Aplicacion : AAplicaciones;
                                       var ApsUsuario : ApUsuario);
var
  AAgregar, cursor, anterior, final : ApUsuario;
begin
  new(AAgregar);
  AAgregar^.aplicacion := Aplicacion;

  if (ApsUsuario = nil) then begin
    ApsUsuario := AAgregar;
    AAgregar^.siguiente := ApsUsuario;
  end else begin
    cursor := ApsUsuario;
    anterior := nil;

    while (upcase(Aplicacion^.nombre) > upcase(cursor^.aplicacion^.nombre)) and
          (cursor^.siguiente <> ApsUsuario) do begin
      anterior := cursor;
      cursor := cursor^.siguiente;
    end;

    AAgregar^.siguiente := cursor;

    if (anterior = nil) then begin
      { En este caso, el nodo nuevo va al principio de la lista. Busco el
        último nodo y le asigno como siguiente al nuevo (que ahora es el
        primero). }
      final := cursor;
      while (final^.siguiente <> ApsUsuario) do
        final := final^.siguiente;

      ApsUsuario := AAgregar;
      final^.siguiente := AAgregar;
    end else
      anterior^.siguiente := AAgregar;
  end;
end;

{
  Procedimiento que desasigna una aplicación a un usuario.
}
procedure desasignar_aplicacion_usuario(usuario : AUsuarios;
                                        aplicacion : TipoAplicacion);
var
  anterior, cursor : ApUsuario;
begin
  cursor := usuario^.aplicaciones;
  anterior := nil;

  if (cursor <> nil) then begin
    while (cursor^.aplicacion^.nombre <> aplicacion) do begin
      anterior := cursor;
      cursor := cursor^.siguiente;
    end;

    if (anterior = nil) then
      usuario^.aplicaciones := cursor^.siguiente
    else
      anterior^.siguiente := cursor^.siguiente;

    dispose(cursor);
  end;
end;

{
  Función para agregar una nueva aplicación a las estructuras en memoria.
  Si el usuario no existe se crea. Si la categoría no existe se crea.
  Si la aplicación no existe se retorna NIL.
}
function nueva_aplicacion(var Usuarios : AUsuarios;
                          var Aplicaciones : LAplicaciones;
                          categoria : string;
                          nombre: TipoAplicacion;
                          usuario : TipoUsuario;
                          descripcion : string;
                          precio : real;
                          cantidad_de_descargas : integer;
                          ubicacion : TipoUbicacion) : AAplicaciones;
var
  NapUsuario : AUsuarios;
  NapCategoria : LAplicaciones;
  NapAplicacion : AAplicaciones;
  crear_categoria, crear_aplicacion : boolean;
begin
  { Se crea el usuario y la categoría (si no existen). Ambas funciones retornan
    el puntero al nuevo usuario y a la nueva categoría. }
  NapUsuario := nodo_usuario(Usuarios, usuario, TRUE);

  crear_categoria := TRUE;
  NapCategoria := nodo_categoria(Aplicaciones, categoria, crear_categoria);

  { Se busca el nodo correspondiente la aplicación. Si el nombre es nil
    significa que la aplicación no existe y debe crearse. }
  crear_aplicacion := TRUE;
  NapAplicacion	:= nodo_aplicacion(NapCategoria^.aplicaciones, nombre,
    crear_aplicacion);

  if (not crear_categoria and not crear_aplicacion) then
    writeln('La aplicación ya existe')
  else begin
    if (crear_aplicacion) and (NapAplicacion <> nil) then begin
      NapAplicacion^.nombre := nombre;
      NapAplicacion^.descripcion := descripcion;
      NapAplicacion^.precio := precio;
      NapAplicacion^.cantidad_de_descargas := cantidad_de_descargas;
      NapAplicacion^.usuario := NapUsuario;
      NapAplicacion^.ubicacion := ubicacion;
      NapAplicacion^.menores := nil;
      NapAplicacion^.mayores := nil;

      { Se agrega un puntero a la nueva aplicación en la lista circular de
        aplicaciones del usuario. }
      asignar_aplicacion_a_usuario(NapAplicacion, NapUsuario^.aplicaciones);

      writeln();
      writeln();
      writeln('Aplicación creada exitosamente.');
    end else
      writeln('No se pudo crear la aplicación.');
  end;

  { Se retorna el puntero a la aplicación. }
  nueva_aplicacion := NapAplicacion;
end;

{
  Procedimiento para cargar el archivo de datos a las estructuras definidas en
  memoria.
}
procedure cargar_archivo(var archivo : ArcAplicaciones;
                         var Usuarios : AUsuarios;
                         var Aplicaciones : LAplicaciones);
var
  leidoArc : RecArcAplicaciones;
begin
  if (not abre_archivo(archivo)) then begin
    writeln('Imposible abrir el archivo <', PMDATA, '>');
    exit;
  end;

  seek(archivo, 0);

  while (not eof(archivo)) do begin
    read(archivo, leidoArc);
    nueva_aplicacion(Usuarios, Aplicaciones, leidoArc.categoria,
      leidoArc.aplicacion, leidoArc.usuario, leidoArc.descripcion,
      leidoArc.precio, leidoArc.cantidad_de_descargas, leidoArc.ubicacion);
  end;
end;

procedure mostrar_aplicaciones_en_orden(AplicacionesCategoria : AAplicaciones);
begin
  if (AplicacionesCategoria <> nil) then begin
    mostrar_aplicaciones_en_orden(AplicacionesCategoria^.menores);
    writeln('Nombre: ', AplicacionesCategoria^.nombre, '. Precio: $',
      AplicacionesCategoria^.precio:3:2);
    mostrar_aplicaciones_en_orden(AplicacionesCategoria^.mayores);
  end;
end;

{
  Función que cuenta la cantidad de aplicaciones que tiene <el arbol> de una
  categoría.
}
function cantidad_de_aplicaciones(categorias : AAplicaciones) : integer;
begin
  if (categorias <> nil) then
    cantidad_de_aplicaciones :=
      cantidad_de_aplicaciones(categorias^.menores) +
      cantidad_de_aplicaciones(categorias^.mayores) + 1
  else
    cantidad_de_aplicaciones := 0;
end;

{
  Procedimiento para mostrar todas las aplicaciones en orden
  alfabético.
}
procedure mostrar_aplicaciones(Aplicaciones : LAplicaciones);
begin
  if (Aplicaciones = nil) then
    writeln('No hay aplicaciones en la tienda.')
  else begin
    imprimir_titulo('Aplicaciones en Pascal Market');
    while (Aplicaciones <> nil) do begin
      writeln();
      writeln('-- Categoría: ', Aplicaciones^.categoria, ' (',
        cantidad_de_aplicaciones(Aplicaciones^.aplicaciones),
        ' aplicacion/es)');
      mostrar_aplicaciones_en_orden(Aplicaciones^.aplicaciones);
      Aplicaciones := Aplicaciones^.siguiente;
    end;
  end;
end;

{
  Procedimiento que ejecuta un asistente de creación de una nueva aplicación
  por parte del usuario.
}
procedure asistente_nueva_aplicacion(var Usuarios : AUsuarios;
                                     var Aplicaciones : LAplicaciones);
var
  categoria, descripcion : string;
  aplicacion : TipoAplicacion;
  usuario : TipoUsuario;
  precio : real;
  ubicacion : TipoUbicacion;
begin
  imprimir_titulo('Registro de aplicación');

  { Se usan estas variables intermedias para que los datos se pidan en este
    orden explícito. }
  aplicacion := leer_aplicacion();
  categoria := leer_categoria();
  descripcion := leer_descripcion();
  usuario := leer_usuario();
  precio := leer_precio();
  ubicacion := leer_ubicacion();

  nueva_aplicacion(Usuarios, Aplicaciones, categoria, aplicacion, usuario,
    descripcion, precio, 0, ubicacion);
end;

{
  Procedimiento auxiliar que busca las aplicaciones que contienen un texto en
  su nombre en el árbol de aplicaciones.
}
procedure buscar_aplicacion_auxiliar(Aplicaciones : AAplicaciones;
                                     buscado : string);
begin
  if (Aplicaciones <> nil) then begin
    buscar_aplicacion_auxiliar(Aplicaciones^.menores, buscado);
    if (pos(upcase(buscado), upcase(Aplicaciones^.nombre)) <> 0) then begin
      writeln('  Aplicación: ', Aplicaciones^.nombre, ', de ',
        Aplicaciones^.usuario^.usuario, '.');
      writeln('    ', Aplicaciones^.descripcion);
      writeln('    Precio: $', Aplicaciones^.precio:3:2,
        '. Cantidad de descargas: ', Aplicaciones^.cantidad_de_descargas);
    end;
    buscar_aplicacion_auxiliar(Aplicaciones^.mayores, buscado);
  end;
end;

{
  Procedimiento que recorre las categorías de aplicaciones invocando al
  procedimiento buscar_aplicacion_auxiliar() para encontrar las aplicaciones que
  contienen un texto dado en su nombre.
}
procedure buscar_aplicacion(Aplicaciones : LAplicaciones;
                            buscado : string);
begin
  if (Aplicaciones = nil) then
    writeln('No hay aplicaciones en la tienda')
  else begin
    while (Aplicaciones <> nil) do begin
      writeln('Categoría: ', Aplicaciones^.categoria);
      buscar_aplicacion_auxiliar(Aplicaciones^.aplicaciones, buscado);
      Aplicaciones := Aplicaciones^.siguiente;
    end;
  end;
end;

{
  Función auxiliar de datos_validos_aplicacion() que busca en el arbol de
  aplicaciones de una categoría determinada, los datos de una aplicación y los
  compara con datos pasados por parámetros. El retorno de esta función es un
  número entero y respeta el siguiente esquema:
  0	La aplicación existe y los datos son válidos.
  1	La aplicación existe pero los datos son inválidos.
  2	La aplicación no existe.
}
function datos_validos_aplicacion_auxiliar(Aplicaciones : AAplicaciones;
                                           nombre : TipoAplicacion;
                                           usuario : TipoUsuario) : integer;
begin
  if (Aplicaciones <> nil) then begin
    datos_validos_aplicacion_auxiliar(Aplicaciones^.menores, nombre, usuario);
    datos_validos_aplicacion_auxiliar(Aplicaciones^.mayores, nombre, usuario);
    if (Aplicaciones^.nombre = nombre) then
      if(Aplicaciones^.usuario^.usuario = usuario) then
        { La aplicación existe y los datos son válidos. }
        datos_validos_aplicacion_auxiliar := 0
      else
        { La aplicación existe pero los datos son inválidos. }
        datos_validos_aplicacion_auxiliar := 1;
  end else
    { La aplicación no existe. }
    datos_validos_aplicacion_auxiliar := 2;
end;

{
  Función para verificar si los datos dados de una aplicación son válidos.
  El retorno de este función es un número entero y respeta el siguiente esquema:
  0	La aplicación existe y los datos son válidos.
  1	La aplicación existe pero los datos son inválidos.
  2	La aplicación no existe.
  3	La categoría no existe.
}
function datos_validos_aplicacion(Aplicaciones : LAplicaciones;
                                  categoria : string;
                                  nombre : TipoAplicacion;
                                  usuario : TipoUsuario) : integer;
var
  datos_validos : integer;
begin
  datos_validos := 3;

  while (Aplicaciones <> nil) and (datos_validos > 1) do begin
    if (Aplicaciones^.categoria = categoria) then
      datos_validos := datos_validos_aplicacion_auxiliar(
        Aplicaciones^.aplicaciones, nombre, usuario);

    Aplicaciones := Aplicaciones^.siguiente;
  end;

  datos_validos_aplicacion := datos_validos;
end;

{
  Procedimiento que sustituye un nodo por el nodo más derecho.
  Esta función es para árboles de tipo AAplicaciones.
}
procedure sustituir_nodo_aaplicaciones(var AEliminar : AAplicaciones;
                                       var Sustituyente : AAplicaciones);
begin
  if (Sustituyente <> nil) then begin
    if (Sustituyente^.mayores <> nil) then
      sustituir_nodo_aaplicaciones(AEliminar, Sustituyente^.mayores)
    else begin
      AEliminar^.nombre := Sustituyente^.nombre;
      AEliminar^.descripcion := Sustituyente^.descripcion;
      AEliminar^.precio := Sustituyente^.precio;
      AEliminar^.cantidad_de_descargas := Sustituyente^.cantidad_de_descargas;
      AEliminar^.usuario := Sustituyente^.usuario;
      AEliminar^.ubicacion := Sustituyente^.ubicacion;
      AEliminar := Sustituyente;
      Sustituyente := Sustituyente^.menores;
    end
  end;
end;

{
  Función que cuenta la cantidad de aplicaciones que tiene un usuario.
}
function cantidad_de_aplicaciones_usuario(usuario : AUsuarios) : integer;
var
  cantidad : integer;
  cursor : ApUsuario;
begin
  cantidad := 0;
  cursor := usuario^.aplicaciones;

  if (cursor <> nil) and (cursor^.aplicacion <> nil) then begin
    while (cursor^.aplicacion <> usuario^.aplicaciones^.aplicacion) do begin
      cantidad := cantidad + 1;
      cursor := cursor^.siguiente;
    end;
  end;
  cantidad_de_aplicaciones_usuario := cantidad;
end;

{
  Procedimiento que sustituye un nodo por el nodo más derecho.
  Esta función es para árboles de tipo AUsuarios.
}
procedure sustituir_nodo_ausuarios(var AEliminar : AUsuarios;
                                   var Sustituyente : AUsuarios);
begin
  if (Sustituyente <> nil) then begin
    if (Sustituyente^.mayores <> nil) then
      sustituir_nodo_ausuarios(AEliminar, Sustituyente^.mayores)
    else begin
      AEliminar^.usuario := Sustituyente^.usuario;
      AEliminar^.aplicaciones := Sustituyente^.aplicaciones;
      AEliminar := Sustituyente;
      Sustituyente := Sustituyente^.menores;
    end
  end;
end;

{
  Procedimiento para eliminar un usuario.
}
procedure eliminar_usuario(var usuario : AUsuarios);
var
  AEliminar : AUsuarios;
begin
  AEliminar := usuario;
  if (usuario^.menores = nil) then
    usuario := usuario^.mayores
  else if (usuario^.mayores = nil) then
    usuario := usuario^.menores
  else
    sustituir_nodo_ausuarios(AEliminar, usuario^.menores);
end;

{
  Procedimiento para eliminar una categoría de la lista de categorías.
}
procedure eliminar_categoria(var Categorias : LAplicaciones;
                             var anterior : LAplicaciones;
                             var actual : LAplicaciones);
begin
  if (anterior = nil) then
    Categorias := actual^.siguiente
  else
    anterior^.siguiente := actual^.siguiente;

  dispose(actual);
end;

{
  Función para eliminar una aplicación. Si se elimina la aplicación se retorna
  TRUE, sino FALSE.
}
function eliminar_aplicacion(var Aplicaciones : AAplicaciones;
                             nombre : TipoAplicacion) : boolean;
var
  AEliminar : AAplicaciones;
begin
  if (Aplicaciones = nil) then
    eliminar_aplicacion := FALSE
  else if (upcase(nombre) > upcase(Aplicaciones^.nombre)) then
    eliminar_aplicacion := eliminar_aplicacion(Aplicaciones^.mayores, nombre)
  else if (upcase(nombre) < upcase(Aplicaciones^.nombre)) then
    eliminar_aplicacion := eliminar_aplicacion(Aplicaciones^.menores, nombre)
  else begin
    AEliminar := Aplicaciones;
    desasignar_aplicacion_usuario(Aplicaciones^.usuario, nombre);

    if (AEliminar^.mayores = nil) then
      Aplicaciones := Aplicaciones^.menores
    else if (AEliminar^.menores = nil) then
      Aplicaciones := Aplicaciones^.mayores
    else
      sustituir_nodo_aaplicaciones(AEliminar, Aplicaciones^.menores);

    dispose(AEliminar);
    eliminar_aplicacion := TRUE;
  end;
end;

{
  Procedimiento que imprime las aplicaciones de un usuario.
}
procedure mostrar_aplicaciones_usuario(usuario : AUsuarios);
var
  ganancia : real;
  cursor : ApUsuario;
begin
  if (usuario <> nil) then begin
    ganancia := 0;
    cursor := usuario^.aplicaciones;
    if (cursor <> nil) and (cursor^.aplicacion <> nil) then begin
      repeat
        writeln('Aplicación: ', cursor^.aplicacion^.nombre);
        writeln('  Precio: $', cursor^.aplicacion^.precio:3:2);
        writeln('  Descargas: ', cursor^.aplicacion^.cantidad_de_descargas);
        ganancia := ganancia +
          cursor^.aplicacion^.precio *
          cursor^.aplicacion^.cantidad_de_descargas;
        cursor := cursor^.siguiente;
      until (cursor = nil) or (cursor = usuario^.aplicaciones);

      writeln();
      writeln('Total por cobrar: $', ganancia:3:2);
    end else
      writeln('El usuario ', usuario^.usuario,
        ' no tiene aplicaciones registradas');
  end else
    writeln('El usuario no existe');
end;

{
  Procedimiento que muestra los datos de una aplicación para su descarga.
}
procedure mostrar_aplicacion_descarga(Aplicacion : AAplicaciones;
                                      categoria : string);
begin
  if (Aplicacion <> nil) then begin
    imprimir_titulo('Aplicación descargada:');
    writeln('Nombre: ', Aplicacion^.nombre);
    writeln('Categoría: ', categoria);
    writeln('Precio: $', Aplicacion^.precio:3:2);
    writeln('Descripción: ', Aplicacion^.descripcion);
    writeln('Cantidad de descargas: ', Aplicacion^.cantidad_de_descargas);
    writeln('Ubicación: ', Aplicacion^.ubicacion);
    writeln();
    writeln();
    writeln('¡¡Gracias por descargar ', Aplicacion^.nombre, '!!');
  end;
end;

{
  Procedimiento que agrega ordenadamente una aplicación a la lista de ranking
  por descargas.
}
procedure agregar_aplicacion_ranking(var ranking : LAuxRanking;
                                     Aplicacion : AAplicaciones;
                                     categoria : string);
var
  AAgregar, cursor, anterior : LAuxRanking;
begin
  new(AAgregar);
  AAgregar^.nombre := Aplicacion^.nombre;
  AAgregar^.categoria := categoria;
  AAgregar^.cantidad_de_descargas := Aplicacion^.cantidad_de_descargas;
  AAgregar^.precio := Aplicacion^.precio;
  AAgregar^.siguiente := nil;

  if (ranking = nil) then
    ranking := AAgregar
  else begin
    cursor := ranking;
    anterior := nil;
    while (cursor <> nil) and
          (cursor^.cantidad_de_descargas > AAgregar^.cantidad_de_descargas)
    do begin
      anterior := cursor;
      cursor := cursor^.siguiente;
    end;

    AAgregar^.siguiente := cursor;

    if (anterior = nil) then
      ranking := AAgregar
    else
      anterior^.siguiente := AAgregar;
  end;
end;

{
  Procedimiento que cargar recursivamente las aplicaciones del árbol de
  aplicaciones en la lista auxiliar de ranking por descargas.
}
procedure cargar_ranking(var ranking : LAuxRanking;
                         Aplicaciones : AAplicaciones;
                         categoria : string);
begin
  if (Aplicaciones <> nil) then begin
    cargar_ranking(ranking, Aplicaciones^.menores, categoria);
    cargar_ranking(ranking, Aplicaciones^.mayores, categoria);
    agregar_aplicacion_ranking(ranking, Aplicaciones, categoria);
  end;
end;

{
  Procedimiento para generar la lista simple que contiene el ranking de
  aplicaciones ordenado descendentemente por cantidad de descargas.
}
procedure generar_ranking(var ranking : LAuxRanking;
                          Categorias : LAplicaciones);
begin
  while (Categorias <> nil) do begin
    cargar_ranking(ranking, Categorias^.aplicaciones, Categorias^.categoria);
    Categorias := Categorias^.siguiente;
  end;
end;

{
  Procedimiento que muestra el ranking de aplicaciones ordenado descendentemente
  por cantidad de descargas.
}
procedure mostrar_ranking(ranking : LAuxRanking);
begin
  if (ranking = nil) then
    writeln('No hay aplicaciones en la tienda')
  else begin
    imprimir_titulo('Ranking de aplicaciones más descargadas de Pascal Market');
    imprimir_titulo('Descargas, Nombre, Categoría, Precio');
    while (ranking <> nil) do begin
      writeln(ranking^.cantidad_de_descargas, ', ', ranking^.nombre, ', ',
        ranking^.categoria, ', $', ranking^.precio:3:2);
      ranking := ranking^.siguiente;
    end;
  end;
end;

{
  Procedimiento que elimina recursivamente los nodos de una lista de
  tipo LAuxRanking.
}
procedure eliminar_ranking(var ranking : LAuxRanking);
begin
  if (ranking <> nil) then
    if (ranking^.siguiente <> nil) then
      eliminar_ranking(ranking^.siguiente)
    else
      dispose(ranking) ;
end;

{
  Procedimiento que agrega ordenadamente una categoría a la lista de ranking
  por ganancia.
}
procedure agregar_categoria_ranking(var ranking : LAuxRanking2;
                                    categoria : string;
                                    ganancia : real);
var
  AAgregar, cursor, anterior : LAuxRanking2;
begin
  new(AAgregar);
  AAgregar^.categoria := categoria;
  AAgregar^.ganancia := ganancia;
  AAgregar^.siguiente := nil;

  if (ranking = nil) then
    ranking := AAgregar
  else begin
    cursor := ranking;
    anterior := nil;
    while (cursor <> nil) and (cursor^.ganancia > AAgregar^.ganancia) do begin
      anterior := cursor;
      cursor := cursor^.siguiente;
    end;

    AAgregar^.siguiente := cursor;

    if (anterior = nil) then
      ranking := AAgregar
    else
      anterior^.siguiente := AAgregar;
  end;
end;

{
  Procedimiento que calcula la ganancia en un árbol de tipo AAplicaciones.
}
function ganancia_por_categoria(Aplicaciones : AAplicaciones) : real;
begin
  if (Aplicaciones <> nil) then
    ganancia_por_categoria :=
      ganancia_por_categoria(Aplicaciones^.menores) +
      ganancia_por_categoria(Aplicaciones^.mayores) +
      Aplicaciones^.precio * Aplicaciones^.cantidad_de_descargas
  else
    ganancia_por_categoria := 0;
end;

{
  Procedimiento para generar la lista simple que contiene el ranking de
  categorías ordenado descendentemente por ganancia.
}
procedure generar_ranking_categorias(var ranking : LAuxRanking2;
                                     Categorias : LAplicaciones);
begin
  while (Categorias <> nil) do begin
    agregar_categoria_ranking(ranking, Categorias^.categoria,
      ganancia_por_categoria(Categorias^.aplicaciones));
    Categorias := Categorias^.siguiente;
  end;
end;

procedure mostrar_ranking_categorias(ranking : LAuxRanking2);
begin
  if (ranking <> nil) then begin
    imprimir_titulo('Ranking de categorías por ganancia');
    imprimir_titulo('Categoría, Ganancia');
    while (ranking <> nil) do begin
      writeln(ranking^.categoria, ', $', ranking^.ganancia:3:2);
      ranking := ranking^.siguiente;
    end;
  end else
    writeln('No hay aplicaciones en la tienda');
end;

{
  Procedimiento que elimina recursivamente los nodos de una lista de
  tipo LAuxRanking2.
}
procedure eliminar_ranking_categorias(var ranking : LAuxRanking2);
begin
  if (ranking <> nil) then
    if (ranking^.siguiente <> nil) then
      eliminar_ranking_categorias(ranking^.siguiente)
    else
      dispose(ranking) ;
end;

{
  Procedimiento que guarda un registro de aplicación al final de un archivo.
}
procedure guardar_en_archivo(var Archivo : ArcAplicaciones;
                             Aplicacion : AAplicaciones;
                             categoria : string);
var
  auxiliar : RecArcAplicaciones;
begin
  auxiliar.usuario		 := Aplicacion^.usuario^.usuario;
  auxiliar.aplicacion		 := Aplicacion^.nombre;
  auxiliar.categoria		 := categoria;
  auxiliar.descripcion		 := Aplicacion^.descripcion;
  auxiliar.precio		 := Aplicacion^.precio;
  auxiliar.cantidad_de_descargas := Aplicacion^.cantidad_de_descargas;
  auxiliar.ubicacion		 := Aplicacion^.ubicacion;

  write(Archivo, auxiliar);
end;

{
  Procedimiento que salva los datos en un archvo de un árbol de aplicaciones
  recursivamente.
}
procedure salvar_datos_aplicaciones(var Archivo : ArcAplicaciones;
                                    Aplicaciones : AAplicaciones;
                                    categoria : string);
begin
  if (Aplicaciones <> nil) then begin
    guardar_en_archivo(Archivo, Aplicaciones, categoria);
    salvar_datos_aplicaciones(Archivo, Aplicaciones^.menores, categoria);
    salvar_datos_aplicaciones(Archivo, Aplicaciones^.mayores, categoria);
  end;
end;

{
  Procedimiento que salva los datos en un archivo.
}
procedure salvar_datos(var Archivo : ArcAplicaciones;
                       Categorias : LAplicaciones);
begin
  while (Categorias <> nil) do begin
    salvar_datos_aplicaciones(Archivo, Categorias^.aplicaciones,
      Categorias^.categoria);
    Categorias := Categorias^.siguiente;
  end;
end;

{
  ==============================================================================
  PROCEDIMIENTOS DEL MENÚ PRINCIPAL.
  ==============================================================================
}

{
  Procedimiento que ejecuta la opción 1 del menú principal:
  - Ver aplicaciones.
}
procedure ejecutar_opcion_1(Aplicaciones : LAplicaciones);
begin
  clrscr;
  mostrar_aplicaciones(Aplicaciones);
  limpiar_pantalla();
end;

{
  Procedimiento que ejecuta la opción 2 del menú principal:
  - Registrar aplicación.
}
procedure ejecutar_opcion_2(var Usuarios : AUsuarios;
                            var Aplicaciones : LAplicaciones);
begin
  clrscr;
  asistente_nueva_aplicacion(Usuarios, Aplicaciones);
  limpiar_pantalla();
end;

{
  Procedimiento que ejecuta la opción 3 del menú principal:
  - Buscar aplicación.
}
procedure ejecutar_opcion_3(Aplicaciones : LAplicaciones);
var
  buscado : string;
begin
  clrscr;
  if (Aplicaciones = nil) then
    writeln('No hay aplicaciones en la tienda.')
  else begin
    imprimir_titulo('Buscar aplicación');
    write('Ingrese parte del nombre de la aplicación a buscar: ');
    readln(buscado);
    buscar_aplicacion(Aplicaciones, buscado);
  end;
  limpiar_pantalla();
end;

{
  Procedimiento que ejecuta la opción 4 del menú principal:
  - Eliminar aplicación.
}
procedure ejecutar_opcion_4(var Usuarios : AUsuarios;
                            var Aplicaciones : LAplicaciones);
var
  usuario : TipoUsuario;
  aplicacion, categoria : string;
  datos_validos : integer;
  anterior, cursor : LAplicaciones;
  puntero_usuario : AUsuarios;
begin
  clrscr;
  if (Aplicaciones = nil) then
    writeln('No hay aplicaciones en la tienda.')
  else begin
    imprimir_titulo('Ingrese los datos de la aplicación a eliminar:');
    aplicacion := leer_aplicacion();
    categoria := leer_categoria();
    usuario := leer_usuario();

    datos_validos := datos_validos_aplicacion(Aplicaciones, categoria,
      aplicacion, usuario);

    if (datos_validos = 0) then begin
      cursor := Aplicaciones;
      anterior := nil;

      { Se busca el nodo de la categoría de la aplicación a eliminar. }
      while (cursor^.categoria <> categoria) do begin
        anterior := cursor;
        cursor := cursor^.siguiente;
      end;

      if (eliminar_aplicacion(cursor^.aplicaciones, aplicacion)) then begin
        writeln();
        writeln();
        writeln('Aplicación eliminada.');
        puntero_usuario := nodo_usuario(Usuarios, usuario, FALSE);
        if (cantidad_de_aplicaciones_usuario(puntero_usuario) = 0) then
          eliminar_usuario(puntero_usuario);
        if (cantidad_de_aplicaciones(cursor^.aplicaciones) = 0) then
          eliminar_categoria(Aplicaciones, anterior, cursor);
      end else begin
        writeln();
        writeln();
        writeln('No se pudo eliminar la aplicación');
      end;
    end else if (datos_validos = 1) then
      writeln('Los datos ingresados no son válidos.')
    else if (datos_validos = 2) then
      writeln('La aplicación ingresada no existe.')
    else
      writeln('La categoría ingresada no existe.');
  end;

  limpiar_pantalla();
end;

{
  Procedimiento que ejecuta la opción 5 del menú principal:
  - Descargar aplicación.
}
procedure ejecutar_opcion_5(var Aplicaciones : LAplicaciones);
var
  aplicacion, categoria : string;
  NAplicacion : AAplicaciones;
  NCategoria: LAplicaciones;
  crear : boolean;
begin
  clrscr;
  if (Aplicaciones = nil) then begin
    writeln('No hay aplicaciones en la tienda');
    limpiar_pantalla();
    exit;
  end;

  aplicacion := leer_aplicacion();
  categoria := leer_categoria();

  crear := FALSE;
  NCategoria := nodo_categoria(Aplicaciones, categoria, crear);
  if (NCategoria <> nil) then begin
    crear := FALSE;
    NAplicacion := nodo_aplicacion(NCategoria^.aplicaciones, aplicacion, crear);
  end else
    NAplicacion := nil;

  if (NAplicacion <> nil) then begin
    NAplicacion^.cantidad_de_descargas := NAplicacion^.cantidad_de_descargas+1;
    mostrar_aplicacion_descarga(NAplicacion, categoria);
  end else begin
    writeln();
    writeln('La aplicación no existe');
  end;

  limpiar_pantalla();
end;

{
  Procedimiento que ejecuta la opción 6 del menú principal:
  - Ver ranking de aplicaciones.
}
procedure ejecutar_opcion_6(Aplicaciones : LAplicaciones);
var
  auxiliar : LAuxRanking;
begin
  clrscr;
  auxiliar := nil;
  generar_ranking(auxiliar, Aplicaciones);
  mostrar_ranking(auxiliar);
  eliminar_ranking(auxiliar);
  limpiar_pantalla();
end;

{
  Procedimiento que ejecuta la opción 7 del menú principal:
  - Ver aplicaciones de un usuario.
}
procedure ejecutar_opcion_7(Aplicaciones : LAplicaciones;
                            Usuarios : AUsuarios);
begin
  clrscr;
  if (Aplicaciones = nil) then
    writeln('No hay aplicaciones en la tienda')
  else begin
    imprimir_titulo('Aplicaciones de un usuario');
    mostrar_aplicaciones_usuario(nodo_usuario(Usuarios, leer_usuario(), FALSE));
  end;
  limpiar_pantalla();
end;

{
  Procedimiento que ejecuta la opción 8 del menú principal:
  - Ventas por categoría.
}
procedure ejecutar_opcion_8(Categorias : LAplicaciones);
var
  auxiliar : LAuxRanking2;
begin
  clrscr;
  auxiliar := nil;
  generar_ranking_categorias(auxiliar, Categorias);
  mostrar_ranking_categorias(auxiliar);
  eliminar_ranking_categorias(auxiliar);
  limpiar_pantalla();
end;

{
  Procedimiento que ejecuta la opción 9 del menú principal:
  - Salir.
}
procedure ejecutar_opcion_9(Aplicaciones : LAplicaciones;
                            var Archivo : ArcAplicaciones);
begin
  clrscr;
  rewrite(Archivo);
  salvar_datos(Archivo, Aplicaciones);
  writeln();
  writeln('---------- ¡Gracias por utilizar Pascal Market! ----------');
  writeln();
  halt;
end;

{
  Función que muestra un menú de opciones para interactuar con el usuario
  Se retorna la opción que se seleccionó. El tipo de la opción es char para que
  el programa no falle si el usuario tipea algo que no esté dentro de las
  opciones del menú, por ejemplo "A".
}
function menu_principal() : integer;
begin
  writeln();
  writeln('=============================================================');
  writeln('Tienda de aplicaciones "Pascal Market"');
  writeln('=============================================================');
  writeln();
  writeln('Menú principal:');
  writeln();
  writeln('	1) Ver aplicaciones');
  writeln('	2) Registrar aplicación');
  writeln('	3) Buscar aplicación');
  writeln('	4) Eliminar aplicación');
  writeln('	5) Descargar aplicación');
  writeln('	6) Ver ranking de aplicaciones');
  writeln('	7) Ver aplicaciones de un usuario');
  writeln('	8) Ventas por categoría');
  writeln('	9) Salir');
  writeln('-------------------------------------------------------------');
  writeln();
  writeln();
  writeln();

  menu_principal := leer_opcion_menu();
end;

{
  ==============================================================================
  INICIO DEL BLOQUE PRINCIPAL.
  ==============================================================================
}
var
  _Archivo : ArcAplicaciones;
  _Usuarios : AUsuarios;
  _Aplicaciones : LAplicaciones;
  OPCION_MP : integer;
begin
  _Usuarios := nil;
  _Aplicaciones := nil;

  cargar_archivo(_Archivo, _Usuarios, _Aplicaciones);

  clrscr;

  OPCION_MP := 99;

  while (OPCION_MP <> 0) do begin
    OPCION_MP := menu_principal();
    case OPCION_MP of
      1: ejecutar_opcion_1(_Aplicaciones);
      2: ejecutar_opcion_2(_Usuarios, _Aplicaciones);
      3: ejecutar_opcion_3(_Aplicaciones);
      4: ejecutar_opcion_4(_Usuarios, _Aplicaciones);
      5: ejecutar_opcion_5(_Aplicaciones);
      6: ejecutar_opcion_6(_Aplicaciones);
      7: ejecutar_opcion_7(_Aplicaciones, _Usuarios);
      8: ejecutar_opcion_8(_Aplicaciones);
      9: ejecutar_opcion_9(_Aplicaciones, _Archivo);
      else clrscr;
    end;
  end;
end.
