program ArmaLista;
type
  TLista = ^Lista;
  Lista = record
            Valor: Integer;
            Sig: TLista;
          end;
          
  TArbol = ^Arbol;
  Arbol = record
            ValArbol: Integer;
            Izq, Der: TArbol;
          end;
          
procedure InsertarenLista (Var L: TLista; V: Integer);
Begin
  // Inserto siempre al final de la lista
  If L = nil Then Begin
    New (L);
    L^.Valor := V;
    L^.Sig := nil;
  End
  Else InsertarenLista (L^.Sig, V);
End;

procedure RecorrerArbol (A: TArbol; Var List: TLista);
Begin
  // Recorro en pre-orden
  If (A <> nil) Then Begin
    InsertarenLista (List, List^.Valor);
    RecorrerArbol (A^.Izq, List);
    RecorrerArbol (A^.Der, List);
  End
End;

Var
  Arb: TArbol;
  Lis: TLista;
begin
  // Cargar Arbol;
  Lis := nil;
  RecorrerArbol (Arb, Lis);
  // Imprimir lista
end.
