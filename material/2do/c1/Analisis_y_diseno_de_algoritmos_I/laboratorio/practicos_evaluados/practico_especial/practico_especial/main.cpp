#include <iostream>
#include "lista.h"

using namespace std;

int main()
{
    int valor = INT_MAX;
    Lista<int> * miLista = new Lista<int>;

    miLista->agregarPrincipioLista(3);
    miLista->agregarPrincipioLista(4);
    miLista->agregarPrincipioLista(35);
    miLista->agregarPrincipioLista(31);
    miLista->agregarPrincipioLista(32);
    miLista->agregarFinalLista(55);
    miLista->agregarFinalLista(57);

    miLista->eliminarLista(1);

    cout << "Longitud lista: " << miLista->longLista() << endl;

    if (miLista->estaIncluido(31)) {
        cout << "El 31 esta incluido" << endl;
    } else {
        cout << "El 31 no esta incluido" << endl;
    }

    cout << "Lista: ";
    miLista->leerPrimero(valor);
    while (valor != INT_MAX) {
        cout << valor;
        valor = INT_MAX;
        miLista->leerSiguiente(valor);
        if (valor != INT_MAX)
            cout << ",";
    }

    return 0;
}
