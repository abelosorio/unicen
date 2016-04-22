#ifndef ARBOL_BINARIO_H_INCLUDED
#define ARBOL_BINARIO_H_INCLUDED

#include "lista.h"

int * nuevo_arbol(int tamanio);

//bool es_hoja(int indice);

void cargar_arbol(int * & arb, const char * valores);

void mostrar_arbol(int * arb);

//void vaciar_arbol(int * & arb);

//void construir_frontera(arreglo_arbol * arb, nodo_lista * & l);




//Representación de un árbol binario utilizando nodos.
//struct nodo_arbol {
//    int elemento;
//    nodo_arbol * izq;
//    nodo_arbol * der;
//};

//nodo_arbol * nuevo_arbol(int elemento, nodo_arbol * izq, nodo_arbol * der);

//bool es_hoja(nodo_arbol * arb);

//void cargar_arbol(nodo_arbol * & arb, const char * valores);

//void mostrar_arbol(nodo_arbol * arb);

//void vaciar_arbol(nodo_arbol * & arb);

//void construir_frontera(nodo_arbol * arb, nodo_lista * & l);




#endif
