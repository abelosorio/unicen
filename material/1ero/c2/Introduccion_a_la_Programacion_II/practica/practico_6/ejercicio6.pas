program ejercicio6 ;
{
  $Id: ejercicio6.pas,v 1.2 2016/01/30 19:06:35 aosorio Exp $

  6) Realice un procedimiento que dado un número lo busque en el árbol y lo
  borre si existe. Tenga en cuenta que dicho número se puede encontrar como una
  hoja del árbol (sin hijos que cuelguen de él) o como nodo interno con otros
  nodos colgando de él.
  Si el nodo a eliminar (B) es interno y tiene las dos subramas no vacías se
  utiliza la estrategia de reemplazo por el Nodo más Derecho (C) del Subarbol
  Izquierdo.
}

type
  puntero_arbol = ^registro_arbol ;
  registro_arbol = record
    valor : integer ;
    menores, mayores : puntero_arbol ;
  end ;

procedure eliminar( var arbol : puntero_arbol ;
                    valor : integer ) ;
begin
  if ( arbol <> nil ) then
    if ( arbol^.valor = valor ) then
      { BORRAR!! }
    else begin
      if ( arbol^.valor > valor ) then
        eliminar( arbol^.mayores, valor )
      else
        eliminar( arbol^.menores, valor ) ;
    end ;
end ;
