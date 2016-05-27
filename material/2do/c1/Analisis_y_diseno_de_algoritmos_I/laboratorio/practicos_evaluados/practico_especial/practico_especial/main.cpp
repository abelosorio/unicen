#include <iostream>
#include "lista.h"

using namespace std;

int main()
{
    Lista<int> * miLista = new Lista<int>;

    miLista->agregarPrincipioLista(3);
    miLista->agregarPrincipioLista(4);
    miLista->agregarPrincipioLista(35);
    miLista->agregarPrincipioLista(31);
    miLista->agregarPrincipioLista(32);
    miLista->agregarFinalLista(55);
    miLista->agregarFinalLista(57);

    miLista->mostrarLista();

    return 0;
}
