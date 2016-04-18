/* Implementación del TDA Punto.
 */

#include "Punto.h"

#include <iostream>
using namespace std;

/* Constructor de Punto.
 */
Punto::Punto(float x1, float y1) {
  x = x1;
  y = y1;
};

/* Destructor de Punto.
 */
Punto::~Punto() {};

/* Coordenada X del Punto.
 */
float Punto::coordX() {
  return x;
}

/* Coordenada Y del Punto.
 */
float Punto::coordY() {
  return y;
}

/* Distancia entre el punto instanciado y otro punto P.
 */
float Punto::distancia(Punto P) {
  return sqrt(pow(P.coordX() - x, 2) + pow(P.coordY() - y, 2));
}

/* Operador de igualdad entre dos puntos.
 */
bool Punto::operator==(Punto P) {
  return (x == P.coordX() && y == P.coordY());
}

int main() {
}
