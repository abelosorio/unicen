#include <iostream>

using namespace std;

template <typename Elem>
class Lista {
    private:
        struct Nodo {
            Elem elemento;
            Nodo * siguiente;
            Nodo * anterior;
        };
        // Inicio de la lista.
        Nodo * inicio;
        // Funci�n para vaciar la lista.
        void vaciar();
        Nodo * crearNodo(Nodo *, Nodo *, Elem);

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
        bool estaIncluido(int);
        // Funci�n para mostrar la lista por salida est�ndar.
        void mostrarLista();
};
