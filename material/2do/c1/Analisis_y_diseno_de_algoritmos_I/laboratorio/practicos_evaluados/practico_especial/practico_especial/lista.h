#ifndef LISTA_H_INCLUDED
#define LISTA_H_INCLUDED

#include <iostream>

using namespace std;

template <typename Elem>
class Lista {
    private:
        struct Nodo {
            Elem elemento;
            Nodo * siguiente;
        };
        // Inicio de la lista.
        Nodo * inicio;
        // Puntero para recorrer la lista. Indica la posición del elemento
        // apuntado. Comienza en 1.
        int punteroPosicion;
        // Puntero para recorrer la lista. Es el puntero real del elemento
        // apuntado.
        Nodo * puntero = NULL;
        // Función para vaciar la lista.
        void vaciar();

    public:
        // Inicializadora de la lista.
        // Complejidad: O(1).
        Lista();
        // Destructora de la lista.
        // Complejidad: O(n).
        ~Lista();
        // Devuelve el tamaño de la lista (cantidad de elementos incluídos).
        // Complejidad: O(n).
        int longLista() const;
        // Agrega un elemento al principio de la lista.
        // Complejidad: O(1).
        void agregarPrincipioLista(Elem);
        // Agrega un elemento al final de la lista.
        // Complejidad: O(n).
        void agregarFinalLista(Elem);
        // Agrega un elemento en una posición de determinada de la lista.
        // Complejidad: O(n).
        void agregarLista(int, Elem);
        // Elimina un elemento de la lista.
        // Complejidad: O(n).
        void eliminarLista(int);
        // Devuelve el elemento de una posición determinada.
        // Complejidad: O(n).
        void recuperarLista(int, Elem &) const;
        // Indica si un elemento está incluído en la lista.
        // Complejidad: O(n).
        bool estaIncluido(Elem) const;
        // Función para chequear si la lista está vacía.
        // Complejidad: O(1).
        bool estaVacia() const;
        // Función para mostrar el valor actual de la lista. El valor es
        // almacenado en el parámetro que pasa por referencia.
        // Complejidad: O(1).
        void leerPrimero(Elem &);
        // Función para obtener el próximo valor de la lista. El puntero
        // se corre a la próxima posición. El valor es almacenado en el
        // parámetro que pasa por referencia.
        // Complejidad: O(1).
        void leerSiguiente(Elem &);
};

#endif
