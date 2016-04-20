#include "lista.h"

#include <iostream>

using namespace std;

int main(int argc, char *argv[])
{
    nodo_lista * l = NULL;
    agregar_final(l, 10);
    agregar_final(l, 17);
    agregar_final(l, 1);

    agregar_principio(l, 5);

    cout << "La lista l contiene los siguientes elementos: " << endl;
    mostrar_lista(l);

    vaciar_lista(l);
    return 0;
}
