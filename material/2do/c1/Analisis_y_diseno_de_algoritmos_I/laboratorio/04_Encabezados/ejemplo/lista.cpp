#include "lista.h"

#include <iostream>

using namespace std;

nodo_lista * nueva_lista(int elemento, nodo_lista * sig) {
    nodo_lista * nuevo = new nodo_lista;
    nuevo->elemento = elemento;
    nuevo->sig = sig;
    return nuevo;
}

void agregar_final(nodo_lista * & l, int elemento) {
    if (l == NULL)
        l = nueva_lista(elemento, NULL);
    else {
        nodo_lista * aux = l;
        while (aux->sig != NULL)
            aux = aux->sig;
        aux->sig = nueva_lista(elemento, NULL);
    }
}

void agregar_principio(nodo_lista * % l, int elemento) {
    nodo_lista * aux = nueva_lista(elemento, l);
    l = aux;
}

void mostrar_lista(nodo_lista * l) {
    while (l != NULL) {
        cout << l->elemento << "  ";
        l = l->sig;
    }
    cout << '\n';
}

void vaciar_lista(nodo_lista * & l) {
    nodo_lista * aux;
    while (l != NULL) {
        aux = l->sig;
        delete l;
        l = aux;
    }
}
