#ifndef ARBOL_BINARIO_H_INCLUDED
#define ARBOL_BINARIO_H_INCLUDED

#include <iostream>
#include "lista.h"

using namespace std;

template <typename Elem>
class Arbin {
    private:
        struct Nodo {
            Elem elemento;
            Nodo * subIzquierdo;
            Nodo * subDerecho;
        };

        // Nodo raíz del árbol binario.
        Nodo * raiz = NULL;
        // Función privada para eliminar todos los nodos del árbol.
        void vaciar(Nodo *);
        // Función privada para agregar un elemento al árbol.
        void agregarElemento(Nodo *, Elem);
        // Función privada para lista los elementos del árbol inorden.
        void listarInorden(Nodo *, Lista<Elem> * &) const;
        // Función privada para determinar si un elemento está incluído en el
        // árbol.
        void estaIncluido(Nodo *, Elem, bool &) const;
        // Función privada para contar la cantidad de elementos del árbol.
        int cantidadNodos(Nodo *) const;
        // Función privada para determinar la profundidad del árbol.
        int profundidad(Nodo *) const;
        // Función para determinar si un nodo es hoja.
        // Complejidad: O(1).
        bool esHoja(Nodo *) const;
        // Función privada para construir la frontera del árbol.
        void construirFrontera(Nodo *, Lista<Elem> * &) const;

    public:
        // Función constructora del árbol binario.
        // Complejidad: O(1).
        Arbin();
        // Función destructora del árbol.
        // Complejidad: O(n).
        ~Arbin();
        // Función para determinar si el árbol está vacío.
        // Complejidad: O(1).
        bool vacioArbin() const;
        // Función para obtener el elemento raíz del árbol.
        // El valor de la raíz se almacenará en el parámetro enviado.
        // Complejidad: O(1).
        void recuperarRaiz(Elem &) const;
        // Función para agregar un elemento al árbol.
        // Complejidad: O(log(n)).
        void agregarElemento(Elem);
        // Función para listar los elementos del árbol inorden.
        // Los elementos se agregarán en la lista pasada como parámetro.
        // Complejidad: O(n).
        void listarInorden(Lista<Elem> * &) const;
        // Función para determinar si un elemento está incluído en el árbol.
        // Complejidad: O(log(n)).
        bool estaIncluido(Elem) const;
        // Función para contar la cantidad de nodos que tiene el árbol.
        // Complejidad: O(n).
        int cantidadNodos() const;
        // Función para determinar la profundidad del árbol.
        // Complejidad: O(n).
        int profundidad() const;
        // Función para construir la frontera del árbol.
        // Los elementos de la frontera se agregarán en la lista pasada como
        // parámetro.
        // Complejidad: O(n).
        void construirFrontera(Lista<Elem> * &) const;
};

#endif
