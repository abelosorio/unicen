#include <iostream>
#include <string>

using namespace std;

void ocurrencias_en_cadena(string cadena, string caracter, int izq, int der, int &ocurrencias, int &iteraciones)
{
  iteraciones++;

  if (izq == der) {
    ocurrencias += (cadena[izq] == caracter[0]) ? 1 : 0;
    return;
  }

  ocurrencias_en_cadena(cadena, caracter, izq, (izq + der) / 2, ocurrencias, iteraciones);
  ocurrencias_en_cadena(cadena, caracter, (izq + der) / 2 + 1, der, ocurrencias, iteraciones);

  return;
}

int ocurrencias_en_cadena_for(string cadena, string caracter, int &iteraciones)
{
  int ocurrencias = 0;

  for (unsigned int i = 0; i < cadena.length(); i++) {
    iteraciones++;
    ocurrencias += (cadena[i] == caracter[0]) ? 1 : 0;
  }

  return ocurrencias;
}

int main()
{
  string cadena, caracter;
  int ocurrencias = 0, iteraciones = 0;

  cout << "Ingrese una cadena de texto: ";
  getline(cin, cadena);
  cout << "Ingrese un caracter a buscar: ";
  getline(cin, caracter);

  ocurrencias_en_cadena(cadena, caracter, 0, cadena.length(), ocurrencias, iteraciones);

  cout << "Cadena de largo " << cadena.length() << endl;
  cout << "El caracter " << caracter << " se encuentra ";
  cout << ocurrencias << " veces." << endl;
  cout << "Iteraciones: " << iteraciones << endl;

  iteraciones = 0;

  cout << "Con implementación 'for': ";
  cout << ocurrencias_en_cadena_for(cadena, caracter, iteraciones) << endl;
  cout << "Iteraciones: " << iteraciones << endl;

  return 0;
}
