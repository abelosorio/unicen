#include <iostream>

#include "Lista.h"
using namespace std;

int main()
{
    nodo_lista * nombres = 0;
    cargar_nombres(nombres);
    mostrar_nombres(nombres);
    vaciar_nombres(nombres);
    return 0;
}
