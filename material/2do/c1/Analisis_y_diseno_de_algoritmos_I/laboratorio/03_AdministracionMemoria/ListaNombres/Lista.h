#ifndef LISTA_H_INCLUDED
#define LISTA_H_INCLUDED

#include <iostream>

struct nodo_lista {
    std::string nombre;
    nodo_lista * siguiente;
};

void insertar_nombre(nodo_lista * & lista, std::string nombre);
void cargar_nombres(nodo_lista * & lista);
void mostrar_nombres(nodo_lista * lista);
void vaciar_nombres(nodo_lista * & lista);

#endif // LISTA_H_INCLUDED
