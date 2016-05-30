#include "arbin.h"

/* Inicializadora del árbol binario.
 */
template <typename Elem>
Arbin<Elem>::Arbin()
{
    raiz = NULL;
}

/* Destructora del árbol binario.
 * Ejecuta vaciar() para eliminar uno a uno los nodos del árbol.
 */
template <typename Elem>
Arbin<Elem>::~Arbin()
{
    vaciar(raiz);
}

/* Función para eliminar, uno a uno, todos los nodos del árbol binario.
 */
template <typename Elem>
void Arbin<Elem>::vaciar(Nodo * arbol)
{
    if (arbol != NULL) {
        vaciar(arbol->subIzquierdo);
        vaciar(arbol->subDerecho);
        delete arbol;
    }
}

/* Función para determinar si el árbol binario está vacío.
 */
template <typename Elem>
bool Arbin<Elem>::vacioArbin() const
{
    return (raiz == NULL);
}

/* Función para obtener el elemento raíz del árbol (si no está vacío).
 */
template <typename Elem>
void Arbin<Elem>::recuperarRaiz(Elem & valor) const
{
    if (!vacioArbin()) {
        valor = raiz->elemento;
    }
}

/* Función privada para agregar un elemento al árbol binario.
 */
template <typename Elem>
void Arbin<Elem>::agregarElemento(Nodo * arbol, Elem elemento)
{
    if (elemento <= arbol->elemento) {
        // Insertar en rama izquierda
        if (arbol->subIzquierdo != NULL) {
            agregarElemento(arbol->subIzquierdo, elemento);
        } else {
            Nodo * nuevo;
            nuevo = new Nodo;
            nuevo->elemento = elemento;
            nuevo->subIzquierdo = NULL;
            nuevo->subDerecho = NULL;

            arbol->subIzquierdo = nuevo;
        }
    } else {
        // Insertar en rama derecha
        if (arbol->subDerecho != NULL) {
            agregarElemento(arbol->subDerecho, elemento);
        } else {
            Nodo * nuevo;
            nuevo = new Nodo;
            nuevo->elemento = elemento;
            nuevo->subIzquierdo = NULL;
            nuevo->subDerecho = NULL;

            arbol->subDerecho = nuevo;
        }
    }
}

/* Función pública para agregar un elemento al árbol binario.
 */
template <typename Elem>
void Arbin<Elem>::agregarElemento(Elem elemento)
{
    if (raiz == NULL) {
        // El arbol está vacío
        Nodo * nuevo;
        nuevo = new Nodo;
        nuevo->elemento = elemento;
        nuevo->subIzquierdo = NULL;
        nuevo->subDerecho = NULL;

        raiz = nuevo;
    } else {
        agregarElemento(raiz, elemento);
    }
}

/* Función privada para listar los elementos del árbol inorden.
 */
template <typename Elem>
void Arbin<Elem>::listarInorden(Nodo * arbol, Lista<Elem> * & lista) const
{
    if (arbol != NULL) {
        listarInorden(arbol->subIzquierdo, lista);
        lista->agregarFinalLista(arbol->elemento);
        listarInorden(arbol->subDerecho, lista);
    }
}

/* Función pública para listar los elementos del árbol inorden.
 */
template <typename Elem>
void Arbin<Elem>::listarInorden(Lista<Elem> * & lista) const
{
    if (!vacioArbin()) {
        listarInorden(raiz, lista);
    }
}

/* Función privada para determinar si un elemento está en el árbol.
 */
template <typename Elem>
void Arbin<Elem>::estaIncluido(Nodo * arbol, Elem valor, bool & existe) const
{
    if (arbol != NULL) {
        if (arbol->elemento == valor) {
            existe = true;
        } else {
            if (valor < arbol->elemento) {
                estaIncluido(arbol->subIzquierdo, valor, existe);
            } else {
                estaIncluido(arbol->subDerecho, valor, existe);
            }
        }
    }
}

/* Función pública para determinar si un elemento está en el árbol.
 */
template <typename Elem>
bool Arbin<Elem>::estaIncluido(Elem valor) const
{
    if (vacioArbin()) {
        return false;
    } else {
        bool existe = false;

        estaIncluido(raiz, valor, existe);
        return existe;
    }
}

/* Función privada para contar la cantidad de elementos que tiene el árbol.
 */
template <typename Elem>
int Arbin<Elem>::cantidadNodos(Nodo * arbol) const
{
    if (arbol == NULL) {
        return 0;
    } else {
        return (1 + cantidadNodos(arbol->subIzquierdo) + cantidadNodos(arbol->subDerecho));
    }
}

/* Función pública para contar la cantidad de elementos que tiene el árbol.
 */
template <typename Elem>
int Arbin<Elem>::cantidadNodos() const
{
    return cantidadNodos(raiz);
}

/* Función privada para determinar la profundidad del árbol.
 */
template <typename Elem>
int Arbin<Elem>::profundidad(Nodo * arbol) const
{
    if (arbol == NULL) {
        return 0;
    } else {
        return (1 + max(profundidad(arbol->subIzquierdo), profundidad(arbol->subDerecho)));
    }
}

/* Función pública para determinar la profundidad del árbol.
 */
template <typename Elem>
int Arbin<Elem>::profundidad() const
{
    return profundidad(raiz);
}

/* Función para determinar si un nodo es hoja.
 */
template <typename Elem>
bool Arbin<Elem>::esHoja(Nodo * nodo) const
{
    return (nodo != NULL and nodo->subIzquierdo == NULL and nodo->subDerecho == NULL);
}

/* Función privada para construir la frontera del árbol.
 */
template <typename Elem>
void Arbin<Elem>::construirFrontera(Nodo * nodo, Lista<Elem> * & frontera) const
{
    if (nodo != NULL) {
        if (esHoja(nodo)) {
            frontera->agregarFinalLista(nodo->elemento);
        } else {
            construirFrontera(nodo->subIzquierdo, frontera);
            construirFrontera(nodo->subDerecho, frontera);
        }
    }
}

/* Función privada para construir la frontera del árbol.
 */
template <typename Elem>
void Arbin<Elem>::construirFrontera(Lista<Elem> * & frontera) const
{
    if (!vacioArbin()) {
        construirFrontera(raiz, frontera);
    }
}

// Tipos para los cuales la clase está implementada
template class Arbin<unsigned int>;
template class Arbin<int>;
template class Arbin<float>;
template class Arbin<char>;
template class Arbin<string>;
