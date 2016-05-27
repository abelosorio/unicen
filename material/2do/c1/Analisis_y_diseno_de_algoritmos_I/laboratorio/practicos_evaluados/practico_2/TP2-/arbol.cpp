#include "arbol.h"
#include "lista.h"

#include <climits>
#include <cmath>
#include <cstdlib>
#include <iostream>
#include <string>

using namespace std;

void inicializar_arbol(int * & arbol, int tamanio) {
    arbol[0] = tamanio;

    for (int i = 1; i <= tamanio; i++) {
        arbol[i] = INT_MAX;
    }
}

int * nuevo_arbol(int tamanio) {
    int * nuevo = new int[tamanio];
    inicializar_arbol(nuevo, tamanio);

    return nuevo;
}

// Notar que esta funci�n es privada, ya que solo se encuentra definida en el .cpp
// Leer un valor entero separado por comas. El valor se devuelve en elemento, y el
// �ndice i es adelantado al caracter despu�s de la coma.
void leer_valor(const char * cadena, int & i, int & elemento) {
    char num[255];
    int l = 0;
    // Leemos caracteres hasta una coma o el fin de cadena
    while ((cadena[i] != '\0') && (cadena[i] != ',')) {
        num[l] = cadena[i];
        i++;
        l++;
    }
    // Es necesario agregar '\0' para que el arreglo de caracteres sea
    // interpretado como una cadena.
    num[l] = '\0';
    elemento = atoi(num);
    // Si no llegamos al final de la cadena, salteamos la coma.
    if (cadena[i] != '\0')
        i++;
}

/* Funci�n para determinar la posici�n del �ltimo elemento
 * de la cadena.
 */
int ultimo_elemento(const char * cadena) {
    int i   = 0;
    int pos = 0;

    while (cadena[i] != '\0') {
        if (cadena[i] != '-') {
            int elemento;
            leer_valor(cadena, i, elemento);
            if (elemento != '\0') {
                pos++;
            }
        } else {
            i += 2;
            pos++;
        }
    }

    return pos;
}

/* Funci�n para determinar el tama�o de la cadena.
 */
int tamanio_cadena(const char * cadena) {
    int i       = 0;
    int tamanio = 0;

    while (cadena[i] != '\0') {
        if (cadena[i] != '-') {
            int elemento;
            leer_valor(cadena, i, elemento);
            if (elemento != '\0') {
                tamanio++;
            }
        } else {
            i += 2;
        }
    }

    return tamanio;
}

/* Funci�n para calcular el tama�o total del �rbol en base a la cadena
 * de entrada.
 */
int tamanio_arbol(const char * cadena) {
    // El tama�o total del �rbol se calcula como 2 elevado a la cantidad
    // de niveles que tenga el �rbol.
    return pow(2, tamanio_cadena(cadena));
}

/* Funci�n privada de carga de �rbol.
 */
void cargar_arbol(int * & arb, const char * cadena, int & pos_cadena, int pos_arbol) {
    if (cadena[pos_cadena] != '\0') {
        if (cadena[pos_cadena] != '-') {
            int elemento;
            leer_valor(cadena, pos_cadena, elemento);
            arb[pos_arbol] = elemento;
            cargar_arbol(arb, cadena, pos_cadena, pos_arbol * 2);
            cargar_arbol(arb, cadena, pos_cadena, pos_arbol * 2 + 1);
        } else {
            pos_cadena += 2;
        }
    }
}

/* Funci�n p�blica de carga de �rbol.
 */
void cargar_arbol(int * & arb, const char * cadena) {
    int pos_cadena = 0;

    arb = nuevo_arbol(tamanio_arbol(cadena) + 1);
    cargar_arbol(arb, cadena, pos_cadena, 1);
}

/* Funci�n para imprimir n veces un string.
 */
void imprimir_n(string cadena, int repeticiones) {
    for (int i = 1; i <= repeticiones; i++) {
        cout << cadena;
    }
}

/* Funci�n para mostrar un nivel del �rbol.
 */
void mostrar_nivel(int * arb, int nivel, int prefijo, int espacios, int cifras) {
    char espacio = ' ';
    char vacio   = 'X';
    char sep     = '-';

    imprimir_n(string(cifras, espacio), prefijo);

    for (int j = pow(2, nivel - 1); j <= pow(2, nivel) - 1; j++) {
        if (arb[j] == INT_MAX) {
            // Si no hay un valor en esta posici�n, imprimir el caracter
            // que indica vac�o.
            cout << string(cifras, vacio);
        } else {
            // Sino imprimir el caracter.
            cout << arb[j];
        }

        // Si la posici�n es par, imprimir el separador de hermanos.
        // Sino, tabular con espacios.
        if (j % 2 == 0) {
            imprimir_n(string(cifras, sep), espacios);
        } else {
            imprimir_n(string(cifras, espacio), espacios);
        }
    }

    cout << endl;
}

/* Funci�n para encontrar el valor m�ximo en el �rbol.
 * Como los elementos del �rbol no presentan ning�n tipo de orden en este caso,
 * deberemos recorrer todos los elementos del mismo.
 */
int elemento_maximo(int * arb) {
    int maximo = 0;

    for (int i = 1; i <= arb[0]; i++) {
        if ((arb[i] != INT_MAX) && (arb[i] > maximo)) {
            maximo = arb[i];
        }
    }

    return maximo;
}

/* Funci�n para calcular la cantidad de niveles que tiene el �rbol, tomando
 * como entrada la representaci�n final (arreglo).
 */
int niveles_arbol(int * arb) {
    // Se inicializa en 1 para que no falle el log2() en caso de no entrar
    // nunca en el if.
    int ultimo = 1;

    for (int i = 1; i < arb[0]; i++) {
        if (arb[i] != INT_MAX) {
            ultimo = i;
        }
    }

    return log2(ultimo) + 1;
 }

/* Funci�n para mostrar el �rbol.
 */
void mostrar_arbol(int * arb) {
    // Cantidad de espacios a la izquierda de los elementos del nivel.
    int prefijo  = 0;
    // Cantidad de espacios entre elementos de un nivel.
    int espacios = 0;
    int niveles  = niveles_arbol(arb);
    int maximo   = elemento_maximo(arb);
    // Cantidad de cifras que tiene, como m�ximo, un elemento del �rbol.
    int cifras;

    // Si el elemento m�ximo es 0 no se ejecuta el log10().
    cifras = (maximo == 0) ? 1 : log10(elemento_maximo(arb)) + 1;

    for (int i = 1; i <= niveles; i++) {
        prefijo = pow(2, niveles - i) - 1;
        espacios = pow(2, niveles - i + 1) - 1;
        mostrar_nivel(arb, i, prefijo, espacios, cifras);
    }
}

/* Funci�n para vaciar la memoria ocupada por el �rbol.
 */
void vaciar_arbol(int * & arb) {
    delete [] arb;
}

/* Funci�n para determinar si un elemento del �rbol es hoja.
 */
bool es_hoja(int * arb, int elemento) {
    // Un elemento vac�o no es considerado hoja.
    if (arb[elemento] == INT_MAX) {
        return false;
    }

    // Si las ramas del elemento est�n fuera del arreglo, entonces el elemento
    // es hoja.
    if (elemento * 2 > arb[0]) {
        return true;
    }

    return ((arb[elemento * 2] == INT_MAX) && ((elemento * 2 + 1) > arb[0] || arb[elemento * 2 + 1] == INT_MAX));
}

/* Funci�n privada para construir la frontera del �rbol.
 */
void construir_frontera(int * arb, nodo_lista * & l, int elemento) {
    if (!((arb[elemento] == INT_MAX) || elemento > arb[0])) {
        if (es_hoja(arb, elemento)) {
            agregar_final(l, arb[elemento]);
        } else {
            construir_frontera(arb, l, elemento * 2);
            construir_frontera(arb, l, elemento * 2 + 1);
        }
    }
}

/* Funci�n p�blica para construir la frontera del �rbol en una lista.
 */
void construir_frontera(int * arb, nodo_lista * & l) {
    construir_frontera(arb, l, 1);
}

/* Funci�n privada para calcular la m�xima diferencia (en valor absoluto) entre
 * dos hojas adyacentes.
 */
void maxima_diferencia_hojas_adyacentes(int * arb, int actual, int & anterior, int & diferencia) {
    if (!((arb[actual] == INT_MAX) || actual > arb[0])) {
        if (es_hoja(arb, actual)) {
            if ((anterior != INT_MAX) && (abs(anterior - arb[actual]) > diferencia)) {
                diferencia = abs(anterior - arb[actual]);
            }
            anterior = arb[actual];
        } else {
            maxima_diferencia_hojas_adyacentes(arb, actual * 2, anterior, diferencia);
            maxima_diferencia_hojas_adyacentes(arb, actual * 2 + 1, anterior, diferencia);
        }
    }
}

/* Funci�n p�blica para calcular la m�xima diferencia entre dos hojas
 * adyacentes.
 */
int maxima_diferencia_hojas_adyacentes(int * arb) {
    int diferencia = 0;
    int anterior   = INT_MAX;

    maxima_diferencia_hojas_adyacentes(arb, 1, anterior, diferencia);
    return diferencia;
}
