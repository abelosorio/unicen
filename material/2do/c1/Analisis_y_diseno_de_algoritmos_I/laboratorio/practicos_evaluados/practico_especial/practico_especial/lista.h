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
        // Puntero para recorrer la lista. Indica la posici�n del elemento
        // apuntado. Comienza en 1.
        int punteroPosicion;
        // Puntero para recorrer la lista. Es el puntero real del elemento
        // apuntado.
        Nodo * puntero = NULL;
        // Funci�n para vaciar la lista.
        void vaciar();

    public:
        // Inicializadora de la lista.
        Lista();
        // Destructora de la lista.
        ~Lista();
        // Devuelve el tama�o de la lista (cantidad de elementos inclu�dos).
        int longLista() const;
        // Agrega un elemento al principio de la lista.
        void agregarPrincipioLista(Elem);
        // Agrega un elemento al final de la lista.
        void agregarFinalLista(Elem);
        // Agrega un elemento en una posici�n de determinada de la lista.
        void agregarLista(int, Elem);
        // Elimina un elemento de la lista.
        void eliminarLista(int);
        // Devuelve el elemento de una posici�n determinada.
        Elem recuperarLista(int);
        // Indica si un elemento est� inclu�do en la lista.
        bool estaIncluido(Elem) const;
        // Funci�n para chequear si la lista est� vac�a.
        bool estaVacia() const;
        // Funci�n para mostrar el valor actual de la lista. El valor es
        // almacenado en el par�metro que pasa por referencia.
        void leerPrimero(Elem &);
        // Funci�n para obtener el pr�ximo valor de la lista. El puntero
        // se corre a la pr�xima posici�n. El valor es almacenado en el
        // par�metro que pasa por referencia.
        void leerSiguiente(Elem &);
};
