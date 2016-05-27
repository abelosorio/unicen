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
        // Función para vaciar la lista.
        void vaciar();
        Nodo * crearNodo(Nodo *, Nodo *, Elem);

    public:
        // Inicializadora de la lista.
        Lista();
        // Destructora de la lista.
        ~Lista();
        // Devuelve el tamaño de la lista (cantidad de elementos incluídos).
        int longLista() const;
        // Agrega un elemento al principio de la lista.
        void agregarPrincipioLista(Elem);
        // Agrega un elemento al final de la lista.
        void agregarFinalLista(Elem);
        // Agrega un elemento en una posición de determinada de la lista.
        void agregarLista(int, Elem);
        // Elimina un elemento de la lista.
        void eliminarLista(int);
        // Devuelve el elemento de una posición determinada.
        Elem recuperarLista(int);
        // Indica si un elemento está incluído en la lista.
        bool estaIncluido(int);
        // Función para mostrar la lista por salida estándar.
        void mostrarLista();
};
