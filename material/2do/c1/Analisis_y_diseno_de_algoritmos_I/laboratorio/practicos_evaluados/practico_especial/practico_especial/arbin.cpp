#include "arbin.h"

/* Inicializadora del �rbol binario.
 */
template <typename Elem>
Arbin<Elem>::Arbin()
{
    raiz = NULL;
}

/* Destructora del �rbol binario.
 * Ejecuta vaciar() para eliminar uno a uno los nodos del �rbol.
 */
template <typename Elem>
Arbin<Elem>::~Arbin()
{
    vaciar(raiz);
}

/* Funci�n para eliminar, uno a uno, todos los nodos del �rbol binario.
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

/* Funci�n para determinar si el �rbol binario est� vac�o.
 */
template <typename Elem>
bool Arbin<Elem>::vacioArbin() const
{
    return (raiz == NULL);
}

/* Funci�n para obtener el elemento ra�z del �rbol (si no est� vac�o).
 */
template <typename Elem>
void Arbin<Elem>::recuperarRaiz(Elem & valor) const
{
    if (!vacioArbin()) {
        valor = raiz->elemento;
    }
}

/* Funci�n privada para agregar un elemento al �rbol binario.
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

/* Funci�n p�blica para agregar un elemento al �rbol binario.
 */
template <typename Elem>
void Arbin<Elem>::agregarElemento(Elem elemento)
{
    if (raiz == NULL) {
        // El arbol est� vac�o
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

/* Funci�n privada para listar los elementos del �rbol inorden.
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

/* Funci�n p�blica para listar los elementos del �rbol inorden.
 */
template <typename Elem>
void Arbin<Elem>::listarInorden(Lista<Elem> * & lista) const
{
    if (!vacioArbin()) {
        listarInorden(raiz, lista);
    }
}

/* Funci�n privada para determinar si un elemento est� en el �rbol.
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

/* Funci�n p�blica para determinar si un elemento est� en el �rbol.
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

/* Funci�n privada para contar la cantidad de elementos que tiene el �rbol.
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

/* Funci�n p�blica para contar la cantidad de elementos que tiene el �rbol.
 */
template <typename Elem>
int Arbin<Elem>::cantidadNodos() const
{
    return cantidadNodos(raiz);
}

/* Funci�n privada para determinar la profundidad del �rbol.
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

/* Funci�n p�blica para determinar la profundidad del �rbol.
 */
template <typename Elem>
int Arbin<Elem>::profundidad() const
{
    return profundidad(raiz);
}

/* Funci�n para determinar si un nodo es hoja.
 */
template <typename Elem>
bool Arbin<Elem>::esHoja(Nodo * nodo) const
{
    return (nodo != NULL and nodo->subIzquierdo == NULL and nodo->subDerecho == NULL);
}

/* Funci�n privada para construir la frontera del �rbol.
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

/* Funci�n privada para construir la frontera del �rbol.
 */
template <typename Elem>
void Arbin<Elem>::construirFrontera(Lista<Elem> * & frontera) const
{
    if (!vacioArbin()) {
        construirFrontera(raiz, frontera);
    }
}

// Tipos para los cuales la clase est� implementada
template class Arbin<unsigned int>;
template class Arbin<int>;
template class Arbin<float>;
template class Arbin<char>;
template class Arbin<string>;
