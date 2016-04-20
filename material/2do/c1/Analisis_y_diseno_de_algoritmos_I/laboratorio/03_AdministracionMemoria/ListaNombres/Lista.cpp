#include "Lista.h"

#include <iostream>

using namespace std;

void insertar_nombre(nodo_lista * & lista, string nombre) {
    nodo_lista * nodo = new nodo_lista;
    nodo->nombre = nombre;
    nodo->siguiente = lista;
    lista = nodo;
}

void cargar_nombres(nodo_lista * & lista) {
    string nombre(" ");
    while (nombre != "") {
        cout << "Ingresar nombre (vacío para terminar):\n";
        getline(cin, nombre);
        insertar_nombre(lista, nombre);
    }
}

void mostrar_nombres(nodo_lista * lista) {
    while (lista != NULL) {
        cout << lista->nombre << "\n";
        lista = lista->siguiente;
    }
}

void vaciar_nombres(nodo_lista * & lista) {
    nodo_lista * actual;
    while (lista != NULL) {
        actual = lista;
        lista = lista->siguiente;
        delete actual;
    }
    lista = NULL;
}
