#include <iostream>
#include <string>
using namespace std;

int main()
{
  string cadena;
  int    mayusculas = 0;
  int    minusculas = 0;
  int    digitos    = 0;

  cout << "Ingrese una cadena: ";
  cin >> cadena;

  for (unsigned i = 0; i <= cadena.length(); i++) {
    if (islower(cadena[i])) {
      minusculas++;
    } else if (isupper(cadena[i])) {
      mayusculas++;
    } else if (isdigit(cadena[i])) {
      digitos++;
    }
  }

  cout << "La cadena tiene " << digitos << " digitos, ";
  cout << mayusculas << " mayusculas y " << minusculas;
  cout << " minusculas." << endl;

  return 0;
}
