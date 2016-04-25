#include "arbol.h"
#include "lista.h"

#include <iostream>

using namespace std;

int main(int argc, char *argv[])
{
    int * arb             = NULL;
    nodo_lista * frontera = NULL;

//  Se podría solicitar la cadena por consola.
//  string cad;
//  cin >> cad;
//  cargarArbol(arb, cad.c_str());

    cargar_arbol(arb, "6,10,12,-,-,-,1,-,9,5,-,3,-,-,2,-,-,-,-,-,-");
    mostrar_arbol(arb);

    cout << "Maxima diferencia: " << maxima_diferencia_hojas_adyacentes(arb) << endl;

    construir_frontera(arb, frontera);
    cout << "Frontera:" << endl;
    mostrar_lista(frontera);

    vaciar_arbol(arb);
    vaciar_lista(frontera);

    return 0;
}
