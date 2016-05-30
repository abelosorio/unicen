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

        // Nodo ra�z del �rbol binario.
        Nodo * raiz = NULL;
        // Funci�n privada para eliminar todos los nodos del �rbol.
        void vaciar(Nodo *);
        // Funci�n privada para agregar un elemento al �rbol.
        void agregarElemento(Nodo *, Elem);
        // Funci�n privada para lista los elementos del �rbol inorden.
        void listarInorden(Nodo *, Lista<Elem> * &) const;
        // Funci�n privada para determinar si un elemento est� inclu�do en el
        // �rbol.
        void estaIncluido(Nodo *, Elem, bool &) const;
        // Funci�n privada para contar la cantidad de elementos del �rbol.
        int cantidadNodos(Nodo *) const;
        // Funci�n privada para determinar la profundidad del �rbol.
        int profundidad(Nodo *) const;
        // Funci�n para determinar si un nodo es hoja.
        // Complejidad: O(1).
        bool esHoja(Nodo *) const;
        // Funci�n privada para construir la frontera del �rbol.
        void construirFrontera(Nodo *, Lista<Elem> * &) const;

    public:
        // Funci�n constructora del �rbol binario.
        // Complejidad: O(1).
        Arbin();
        // Funci�n destructora del �rbol.
        // Complejidad: O(n).
        ~Arbin();
        // Funci�n para determinar si el �rbol est� vac�o.
        // Complejidad: O(1).
        bool vacioArbin() const;
        // Funci�n para obtener el elemento ra�z del �rbol.
        // El valor de la ra�z se almacenar� en el par�metro enviado.
        // Complejidad: O(1).
        void recuperarRaiz(Elem &) const;
        // Funci�n para agregar un elemento al �rbol.
        // Complejidad: O(log(n)).
        void agregarElemento(Elem);
        // Funci�n para listar los elementos del �rbol inorden.
        // Los elementos se agregar�n en la lista pasada como par�metro.
        // Complejidad: O(n).
        void listarInorden(Lista<Elem> * &) const;
        // Funci�n para determinar si un elemento est� inclu�do en el �rbol.
        // Complejidad: O(log(n)).
        bool estaIncluido(Elem) const;
        // Funci�n para contar la cantidad de nodos que tiene el �rbol.
        // Complejidad: O(n).
        int cantidadNodos() const;
        // Funci�n para determinar la profundidad del �rbol.
        // Complejidad: O(n).
        int profundidad() const;
        // Funci�n para construir la frontera del �rbol.
        // Los elementos de la frontera se agregar�n en la lista pasada como
        // par�metro.
        // Complejidad: O(n).
        void construirFrontera(Lista<Elem> * &) const;
};

#endif
