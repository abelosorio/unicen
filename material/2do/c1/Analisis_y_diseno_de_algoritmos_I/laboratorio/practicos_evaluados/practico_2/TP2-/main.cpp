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

    cargar_arbol(arb, "10,5,-,1,2,-,-,3,-,-,7,8,-,-,9,-,5");
    //cargar_arbol(arb, "10,5,-,1,2,-,-,3,-,-,7,8,-,-,9,-,5,-,4");
    mostrar_arbol(arb);

    cout << "Maxima diferencia: " << maxima_diferencia_hojas_adyacentes(arb) << endl;

    construir_frontera(arb, frontera);
    cout << "Frontera:" << endl;
    mostrar_lista(frontera);

    vaciar_arbol(arb);
    vaciar_lista(frontera);

    return 0;
}
