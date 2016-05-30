#include <iostream>
#include "lista.h"
#include "arbin.h"

using namespace std;

/* Función para mostrar la lista utilizando los métodos proporcionados
 * por la clase.
 */
void mostrarLista(Lista<int> * lista)
{
    int valor = INT_MAX;

    cout << "Lista: ";
    lista->leerPrimero(valor);
    while (valor != INT_MAX) {
        cout << valor;
        valor = INT_MAX;
        lista->leerSiguiente(valor);
        if (valor != INT_MAX)
            cout << ",";
    }

    cout << endl;
}

int main()
{
    // Prueba de el TDA Lista
    // ----------------------
    cout << "Prueba TDA Lista" << endl;

    Lista<int> * miLista = new Lista<int>;

    // Se crea la lista 32, 31, 35, 4, 3, 55, 57.
    miLista->agregarPrincipioLista(3);
    miLista->agregarPrincipioLista(4);
    miLista->agregarPrincipioLista(35);
    miLista->agregarPrincipioLista(31);
    miLista->agregarPrincipioLista(32);
    miLista->agregarFinalLista(55);
    miLista->agregarFinalLista(57);
    // Se elimina el primer elemento (32).
    miLista->eliminarLista(1);
    // Se muestra la longitud de la lista (6).
    cout << "Longitud lista: " << miLista->longLista() << endl;
    // Se pregunta si el elemento 31 está incluído.
    if (miLista->estaIncluido(31)) {
        cout << "El 31 esta incluido" << endl;
    } else {
        cout << "El 31 no esta incluido" << endl;
    }

    // Se recorre la lista usando los métodos proporcionados.
    mostrarLista(miLista);

    // Prueba del TDA Arbin
    // --------------------
    cout << "\nPrueba TDA Arbin" << endl;

    Arbin<int> * miArbol = new Arbin<int>;
    Lista<int> * miListaAux = new Lista<int>;
    Lista<int> * miListaAux2 = new Lista<int>;

    // Se agregan los elementos: 32, 31, 35, 4, 3, 55, 57.
    miArbol->agregarElemento(32);
    miArbol->agregarElemento(31);
    miArbol->agregarElemento(35);
    miArbol->agregarElemento(4);
    miArbol->agregarElemento(3);
    miArbol->agregarElemento(55);
    miArbol->agregarElemento(57);
    // Se listan los elementos inorden.
    miArbol->listarInorden(miListaAux);
    mostrarLista(miListaAux);
    // Se pregunta el el elemento 3 está incluído en el árbol.
    if (miArbol->estaIncluido(3)) {
        cout << "El 3 esta incluido" << endl;
    } else {
        cout << "El 3 no esta incluido" << endl;
    }
    // Cantidad de nodos.
    cout << "La cantidad de nodos es: " << miArbol->cantidadNodos() << endl;
    // Profundidad del árbol.
    cout << "La profundidad del arbol es: " << miArbol->profundidad() << endl;
    // Frontera
    miArbol->construirFrontera(miListaAux2);
    mostrarLista(miListaAux2);

    return 0;
}
