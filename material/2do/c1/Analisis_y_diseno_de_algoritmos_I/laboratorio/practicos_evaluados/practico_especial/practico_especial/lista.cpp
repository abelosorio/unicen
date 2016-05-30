#include "lista.h"

/* Constructora del objeto.
 * Inicializa el primer nodo con valores NULL.
 */
template <typename Elem>
Lista<Elem>::Lista()
{
    inicio = NULL;
    punteroPosicion = 1;
}

/* Destructora del objeto.
 * Llama a vaciar() para eliminar todos los nodos de la lista.
 */
template <typename Elem>
Lista<Elem>::~Lista()
{
    vaciar();
}

/* Funci�n para vaciar la lista.
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

    inicio->siguiente = NULL;
}

/* Funci�n para agregar un elemento al principio de la lista.
 */
template <typename Elem>
void Lista<Elem>::agregarPrincipioLista(Elem valor)
{
    Nodo * nuevo;

    nuevo = new Nodo;
    nuevo->siguiente = inicio;
    nuevo->elemento = valor;

    inicio = nuevo;
}

/* Funci�n para agregar un elemento al final de la lista.
 */
template <typename Elem>
void Lista<Elem>::agregarFinalLista(Elem valor)
{
    Nodo * aux = inicio;
    Nodo * nuevo;

    if (aux != NULL) {
        while (aux->siguiente != NULL) {
            aux = aux->siguiente;
        }
        nuevo = new Nodo;
        nuevo->siguiente = NULL;
        nuevo->elemento = valor;

        aux->siguiente = nuevo;
    } else {
        // La lista est� vac�a. Agregar el elemento al inicio o al final de
        // la lista, es lo mismo.
        agregarPrincipioLista(valor);
    }
}

/* Funci�n para agregar un elemento en una posici�n arbitraria de la lista.
 */
template <typename Elem>
void Lista<Elem>::agregarLista(int posicion, Elem valor)
{
    if ((posicion < 1) or (posicion > longLista()) or estaVacia()) {
        return;
    }

    Nodo * aux = inicio;
    Nodo * nuevo;
    int actual = 0;

    if (aux != NULL) {
        while (aux->siguiente != NULL and posicion < actual) {
            aux = aux->siguiente;
        }
        nuevo = new Nodo;
        nuevo->siguiente = aux->siguiente;
        nuevo->elemento = valor;

        aux = nuevo;
    } else {
        // La lista est� vac�a. Se agrega el elemento al principio.
        agregarPrincipioLista(valor);
    }
}

/* Devuelve el tama�o de la lista (cantidad de elementos inclu�dos).
 */
template <typename Elem>
int Lista<Elem>::longLista() const
{
    Nodo * aux = inicio;
    int longitud = 0;

    while (aux != NULL) {
        longitud++;
        aux = aux->siguiente;
    }

    return longitud;
}

/* Funci�n para determinar si un elemento est� inclu�do en la lista.
 */
template <typename Elem>
bool Lista<Elem>::estaIncluido(Elem buscado) const
{
    if (estaVacia()) {
        return false;
    }

    Nodo * aux = inicio;

    while (aux != NULL) {
        if (aux->elemento == buscado) {
            return true;
        }
        aux = aux->siguiente;
    }

    return false;
}

/* Funci�n para chequear si la lista est� vac�a.
 */
template <typename Elem>
bool Lista<Elem>::estaVacia() const
{
    return (inicio == NULL);
}

/* Funci�n para eliminar un elemento de una posici�n determinada.
 */
template <typename Elem>
void Lista<Elem>::eliminarLista(int posicion)
{
    // Si la posici�n es menor a 1 o excede la longitud de la lista, entonces
    // no hago nada.
    if ((posicion < 1) or (posicion > longLista()) or estaVacia()) {
        return;
    }

    int actual = 1;
    Nodo * aux = inicio;
    Nodo * victima;
    Nodo * anterior = NULL;

    while (actual < posicion) {
        anterior = aux;
        aux = aux->siguiente;
        actual++;
    }

    victima = aux;

    if (anterior != NULL) {
        anterior->siguiente = aux->siguiente;
    } else {
        // Se est� borrando el primer nodo, por lo tanto hay que
        // actualizar el puntero de inicio de la lista.
        inicio = aux->siguiente;
    }

    delete victima;
}

/* Funci�n para obtener un valor de la lista.
 */
template <typename Elem>
void Lista<Elem>::recuperarLista(int posicion, Elem & valor) const
{
    if ((posicion < 1) or (posicion > longLista()) or estaVacia()) {
        return;
    }

    int actual = 1;
    Nodo * aux = inicio;

    while (actual < posicion) {
        actual++;
        aux = aux->siguiente;
    }

    valor = aux->elemento;
}

/* Funci�n para obtener el primer valor de la lista.
 */
template <typename Elem>
void Lista<Elem>::leerPrimero(Elem & primero)
{
    if (!estaVacia()) {
        primero = inicio->elemento;
        punteroPosicion = 2;
        puntero = inicio->siguiente;
    }
}

/* Funci�n para obtener el pr�ximo valor de la lista.
 */
template <typename Elem>
void Lista<Elem>::leerSiguiente(Elem & siguiente)
{
    if (!estaVacia()) {
        if (punteroPosicion <= longLista()) {
            siguiente = puntero->elemento;
            puntero = puntero->siguiente;
            punteroPosicion++;
        }
    }
}

// Tipos para los cuales la clase est� implementada
template class Lista<unsigned int>;
template class Lista<int>;
template class Lista<float>;
template class Lista<char>;
template class Lista<string>;
