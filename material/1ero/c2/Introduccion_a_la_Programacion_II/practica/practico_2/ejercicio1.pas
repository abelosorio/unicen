type
  fecha = record
    dia : 1..31 ;
    mes : 1..12 ;
    ano : 1960..2050 ;
  end ;

  hora = record
    hora : 0..23 ;
    minuto : 0..59 ;
    segundo : 0..50 ;
  end ;

  materia_unicen = ( algebra_1, analisis_1, programacion_1, ciencias_1 ) ;

  permiso_de_examen = record
    fecha_de_examen : fecha ;
    hora_de_examen : hora ;
    materia : materia_unicen ;
    alumno : string ;
    llamado : 1..3 ;
  end ;

  datos_de_un_alumno = record
    nombre : string ;
    apellido : string ;
    fecha_de_nacimiento : fecha ;
    domicilio : string ;
    telefono : integer ;
  end ;

  color_automovil = ( blanco, gris, negro, rojo, amarillo, azul, verde ) ;

  motorizacion_automovil = ( nafta, diesel, hibrido, electrico ) ;

  descripcion_automovil = record
    marca : string ;
    modelo : string ;
    fecha_de_lanzamiento : fecha ;
    color : color_automovil ;
    motorizacion : motorizacion_automovil ;
  end ;

  recibo = record
    fecha_de_emision : fecha ;
    emisor : string ;
    monto : integer ;
    receptor : string ;
  end ;

  condicion_de_venta = ( contado, efectivo, cheque ) ;

  items_factura = array [1..10,1..3] of integer ;

  factura = record
    tipo : a..c ;
    numero : integer ;
    emisor : string ;
    condicion : condicion_de_venta ;
    items : items_factura ;
    iva : 1..100 ;
    bruto : integer ;
    neto : integer ;
  end ;
