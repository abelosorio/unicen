#ifndef LISTA_EJEMPLO_H
#define LISTA_EJEMPLO_H

struct nodo_lista {
    int elemento;
    nodo_lista * sig;
};

// Agrega al final de la lista l, en un nuevo nodo, el elemento pasado.
void agregar_final(nodo_lista * & l, int elemento);

void agregar_principio(nodo_lista * & l, int elemento);

// Muestra por pantalla los elementos de la lista con raíz l.
void mostrar_lista(nodo_lista * l);

// Elimina todos los nodos de la lista l.
void vaciar_lista(nodo_lista * & l);

#endif
