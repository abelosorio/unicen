#include "lista.h"

/* Constructora del objeto.
 * Inicializa el primer nodo con valores NULL.
 */
template <typename Elem>
Lista<Elem>::Lista()
{
    inicio = NULL;
}

/* Destructora del objeto.
 * Llama a vaciar() para eliminar todos los nodos de la lista.
 */
template <typename Elem>
Lista<Elem>::~Lista()
{
    vaciar();
}

/* Función privada para crear un nuevo nodo de la lista.
 */
template <typename Elem>
Nodo * Lista<Elem>::crearNodo(Nodo * ant, Nodo * sig, Elem valor)
{
    Nodo * nuevo;

    nuevo = new Nodo;
    nuevo->anterior  = ant;
    nuevo->elemento  = valor;
    nuevo->siguiente = sig;

    return nuevo;
}

/* Función para vaciar la lista.
 */
template <typename Elem>
void Lista<Elem>::vaciar()
{
    Nodo * aux;
    while (inicio->siguiente != NULL) {
        aux = inicio->siguiente->siguiente;
        delete inicio->siguiente;
        inicio->siguiente = aux;
    }

    inicio->anterior = NULL;
    inicio->siguiente = NULL;
}

/* Función para agregar un elemento al principio de la lista.
 */
template <typename Elem>
void Lista<Elem>::agregarPrincipioLista(Elem valor)
{
    inicio = crearNodo(NULL, inicio, valor);
}

/* Función para agregar un elemento al final de la lista.
 */
template <typename Elem>
void Lista<Elem>::agregarFinalLista(Elem valor)
{
    Nodo * aux = inicio;

    if (aux != NULL) {
        while (aux->siguiente != NULL) {
            aux = aux->siguiente;
        }
        aux->siguiente = crearNodo(aux, NULL, valor);
    } else {
        // La lista está vacía. Agregar el elemento al inicio o al final de
        // la lista, es lo mismo.
        agregarPrincipioLista(valor);
    }
}

/* Función para agregar un elemento en una posición arbitraria de la lista.
 * Si la posición excede el número de elementos de la lista, entonces el
 * elemento se agrega al final de la misma.
 */
template <typename Elem>
void Lista<Elem>::agregarLista(int posicion, Elem valor)
{
    Nodo * aux = inicio;
    int actual = 0;

    if (aux != NULL) {
        while (aux->siguiente != NULL and posicion < actual) {
            aux = aux->siguiente;
        }
        aux = crearNodo(aux, aux->siguiente, valor);
    } else {
        // La lista está vacía. Se agrega el elemento al principio.
        agregarPrincipioLista(valor);
    }
}

/* Función para mostrar la lista por salida estándar.
 */
template <typename Elem>
void Lista<Elem>::mostrarLista()
{
    Nodo * aux;
    aux = inicio;

    while (aux != NULL) {
        cout << aux->elemento << " -> ";
        aux = aux->siguiente;
    }

    cout << endl;
}

// Tipos para los cuales la clase está implementada
template class Lista<unsigned int>;
template class Lista<int>;
template class Lista<float>;
template class Lista<char>;
template class Lista<string>;
