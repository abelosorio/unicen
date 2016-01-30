program Crear;

type
  TArch = File of Integer;
  TArbol = ^RArbol;
  RArbol = record
             Valor: Integer;
             Izq, Der: TArbol;
           end;
           

procedure InsertarenArbol (Var Arb: TArbol; DatoInt: Integer);
Begin
  if (Arb = Nil) Then Begin
    New (Arb);
    Arb^.Izq := nil;
    Arb^.Der := nil;
    Arb^.Valor := DatoInt;
  End
  else if (Arb^.Valor > DatoInt)
     Then InsertarenArbol (Arb^.Izq, DatoInt)
     Else InsertarenArbol (Arb^.Der, DatoInt)
End;

procedure CrearArbol (Var Arch: TArch; Var Arbol: TArbol);
Var
  Dato: Integer;
begin
  // En el programa ppal haggo el assign
  Reset (Arch);
  While not EOF (Arch) do Begin
    Read (Arch, Dato);
    InsertarenArbol (Arbol, Dato);
  End;
  Close (Arch);
end;

procedure ImprimirArbol (Arb: TArbol);
Begin
  // lo imprimo in-order (Ejercicio 2)
  If (Arb <> nil) Then Begin
    ImprimirArbol (Arb^.Izq);
    writeln (Arb^.Valor);
    ImprimirArbol (Arb^.Der);
  End
End;

Var
  ArchInt: TArch;
  ArbolInt: TArbol;
  
Begin
  ArbolInt := nil;
  Assign (ArchInt, 'Enteros.dat');
  CrearArbol (ArchInt, ArbolInt);
  ImprimirArbol (ArbolInt);
End.
