#include "arreglo.h"
#include "lista.h"

#include <cstdlib>
#include <iostream>
#include <climits>
#include <cmath>

using namespace std;

int * nuevo_arbol(int tamanio) {
    int * nuevo = new int[tamanio];
    return nuevo;
}

bool es_hoja(int * arbol, int indice) {
    return (!(arbol[indice*2] == INT_MAX && arbol[indice*2 + 1] == INT_MAX));
}

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

void cargar_arbol(nodo_arbol * & arb, const char * cadena, int & i) {
    if (cadena[i] != '\0') {
        if (cadena[i] != '-') {
            int elemento;
            leer_valor(cadena, i, elemento);
            arb = nuevo_arbol(elemento, NULL, NULL);
            cargar_arbol(arb->izq, cadena, i);
            cargar_arbol(arb->der, cadena, i);
        } else
            i += 2;
    }
}

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

int tamanio_arbol(const char * cadena) {
    return pow(2, tamanio_cadena(cadena));
}

void cargar_arbol(int * & arb, const char * cadena) {
    cargar_arbol(arb, cadena, tamanio_arbol(cadena));
}

void mostrar_nivel(nodo_arbol * arb, int nivel, int actual, bool & existe) {
    if (arb == NULL) {
        if (actual < nivel)
            existe = false;
        else
            cout << " - ";
    } else {
        if (actual == nivel) {
            cout << arb->elemento << " ";
            existe = true;
        } else {
            mostrar_nivel(arb->izq, nivel, actual+1, existe);
            mostrar_nivel(arb->der, nivel, actual+1, existe);
        }
    }
}

void mostrar_arbol(nodo_arbol * arb) {
    int i = 0;
    bool cont = true;
    while (cont) {
        cout << "Nivel " << i << ":  ";
        mostrar_nivel(arb, i, 0, cont);
        cout << endl;
        i++;
    }
}

void vaciar_arbol(nodo_arbol * & arb) {
    if (arb != NULL) {
        vaciar_arbol(arb->izq);
        vaciar_arbol(arb->der);
        delete arb;
        arb = NULL;
    }
}

void construir_frontera(nodo_arbol * arb, nodo_lista * & l) {
    if (arb != NULL) {
        if (es_hoja(arb))
            agregar_final(l, arb->elemento);
        else {
            construir_frontera(arb->izq, l);
            construir_frontera(arb->der, l);
        }
    }
}
