#include <iostream>

using namespace std;

int posicion(string numeros, string numero, int izq, int der, int &iteraciones)
{
  int mitad;

  iteraciones++;

  if (izq == der) {
    return (numeros[izq] == numero[0]) ? izq : -1;
  }

  mitad = (izq + der) / 2;

  if (numero <= mitad) {
    return posicion(numeros, numero, izq, mitad, iteraciones);
  } else {
    return posicion(numeros, numero, mitad + 1, der, iteraciones);
  }
}

void contar_ocurrencias(string numeros, string numero, int posicion, int &ocurrencias, int &iteraciones)
{
  for ( int i = posicion; i <= numeros.length(); i++) {
    iteraciones++;
    if (numeros[i] == numero[0]) {
      ocurrencias++;
    } else {
      return;
    }
  }

  return;
}

int main()
{
  string numeros;
  int    ocurrencias = 0,
         iteraciones = 0,
         posicion;

  cout << "Ingrese números naturales (ordenados de menor a mayor): ";
  getline(cin, numeros);

  posicion = posicion(numeros, numer)

  cout << "La cantidad de ocurrencias es: " << ocurrencias << endl;
  cout << "Las iteraciones fueron: " << iteraciones << endl;

  return 0;
}
