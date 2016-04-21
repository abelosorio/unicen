/* Representación de un árbol utilizando un arreglo.
 */

#ifndef ARBOL_BINARIO_H_INCLUDED
#define ARBOL_BINARIO_H_INCLUDED

int * nuevo_arbol(int tamanio);

//bool es_hoja(int indice);

void cargar_arbol(int * & arb, const char * valores);

void mostrar_arbol(int * arb);

void vaciar_arbol(int * & arb);

//void construir_frontera(arreglo_arbol * arb, nodo_lista * & l);

#endif
