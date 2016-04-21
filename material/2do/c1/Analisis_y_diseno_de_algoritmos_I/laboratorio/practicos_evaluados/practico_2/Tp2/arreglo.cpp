#include "arreglo.h"
#include "lista.h"

#include <cstdlib>
#include <iostream>
#include <climits>
#include <cmath>

using namespace std;

int * nuevo_arbol(int tamanio) {
    int * nuevo = new int[tamanio];
    inicializar_arbol(nuevo, tamanio);

    return nuevo;
}

void inicializar_arbol(int * & arbol, int tamanio) {
    for (i = 0; i <= tamanio; i++) {
        *arbol[i] = INT_MAX;
    }
}

//bool es_hoja(int * arbol, int indice) {
//    return (!(arbol[indice*2] == INT_MAX && arbol[indice*2 + 1] == INT_MAX));
//}

// Notar que esta función es privada, ya que solo se encuentra definida en el .cpp
// Leer un valor entero separado por comas. El valor se devuelve en elemento, y el
// índice i es adelantado al caracter después de la coma.
void leer_valor(const char * cadena, int & i, int & elemento) {
    char num[255];
    int l = 0;
    // Leemos caracteres hasta una coma o el fin de cadena
    while ((cadena[i] != '\0') && (cadena[i] != ',')) {
        num[l] = cadena[i];
        i++;
        l++;
    }
    // Es necesario agregar '\0' para que el arreglo de caracteres sea
    // interpretado como una cadena.
    num[l] = '\0';
    elemento = atoi(num);
    // Si no llegamos al final de la cadena, salteamos la coma.
    if (cadena[i] != '\0')
        i++;
}

/* Función para calcular el tamaño de la cadena de entrada de valores
 * del árbol.
 */
int tamanio_cadena(const char * cadena) {
    int i = 0;
    int tamanio = 1;

    while (cadena[i] != '\0') {
        if (cadena[i] != '-') {
            tamanio++;
        }
        i += 2;
    }

    return tamanio;
}

/* Función para calcular el tamaño total del árbol en base a la cadena
 * de entrada.
 */
int tamanio_arbol(const char * cadena) {
    return pow(2, tamanio_cadena(cadena));
}

void cargar_arbol(int * & arb, const char * cadena, int pos_cadena, int pos_arbol) {
    if (cadena != '\0') {
        if (cadena[pos_cadena] != '-') {
            leer_valor(cadena, pos_cadena, elemento);
            *arb[pos_arbol] = elemento;
            cargar_arbol(arb, cadena, pos_cadena + 1, pos_arbol*2);
            cargar_arbol(arb, cadena, pos_cadena + 2, pos_arbol*2 + 1);
        }
    }
}

void cargar_arbol(int * & arb, const char * cadena) {
    *arb = nuevo_arbol(tamanio_arbol(tamanio_cadena(cadena));
    cargar_arbol(arb, cadena, 0, 1);
}

//void mostrar_nivel(nodo_arbol * arb, int nivel, int actual, bool & existe) {
//    if (arb == NULL) {
//        if (actual < nivel)
//            existe = false;
//        else
//            cout << " - ";
//    } else {
//        if (actual == nivel) {
//            cout << arb->elemento << " ";
//            existe = true;
//        } else {
//            mostrar_nivel(arb->izq, nivel, actual+1, existe);
//            mostrar_nivel(arb->der, nivel, actual+1, existe);
//        }
//    }
//}

void mostrar_arbol(int * arb) {
    for (i = 0; i <= 8) {
      cout << i << ": " << *arb[i] << endl;
    }
}

//void mostrar_arbol(nodo_arbol * arb) {
//    int i = 0;
//    bool cont = true;
//    while (cont) {
//        cout << "Nivel " << i << ":  ";
//        mostrar_nivel(arb, i, 0, cont);
//        cout << endl;
//        i++;
//    }
//}

//void vaciar_arbol(nodo_arbol * & arb) {
//    if (arb != NULL) {
//        vaciar_arbol(arb->izq);
//        vaciar_arbol(arb->der);
//        delete arb;
//        arb = NULL;
//    }
//}
//
//void construir_frontera(nodo_arbol * arb, nodo_lista * & l) {
//    if (arb != NULL) {
//        if (es_hoja(arb))
//            agregar_final(l, arb->elemento);
//        else {
//            construir_frontera(arb->izq, l);
//            construir_frontera(arb->der, l);
//        }
//    }
//}
