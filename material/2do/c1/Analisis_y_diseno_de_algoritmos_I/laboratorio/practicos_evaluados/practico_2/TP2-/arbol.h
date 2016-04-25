#ifndef ARBOL_BINARIO_H_INCLUDED
#define ARBOL_BINARIO_H_INCLUDED

#include "lista.h"

int * nuevo_arbol(int tamanio);

bool es_hoja(int * arb, int elemento);

void cargar_arbol(int * & arb, const char * valores);

void mostrar_arbol(int * arb);

void vaciar_arbol(int * & arb);

void construir_frontera(int * arb, nodo_lista * & l);

int maxima_diferencia_hojas_adyacentes(int * arb);

#endif
