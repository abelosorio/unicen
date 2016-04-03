#include <iostream>
#include <math.h>

using namespace std;

int main()
{
  float a, b, c, d, x1, x2, xr, xi;

  cout << "Coeficiente de 2do grado (a): ";
  cin >> a;
  cout << "Coeficiente de 1er grado (b): ";
  cin >> b;
  cout << "Termino independiente (c): ";
  cin >> c;

  d = b * b - 4 * a * c;

  if (d > 0) {
    x1 = (-b + sqrt(d)) / (2 * a);
    x2 = (-b - sqrt(d)) / (2 * a);
  } else if (d == 0) {
    x1 = -b / 2 * a;
    x2 = x1;
  } else {
    xr = -b / 2 * a;
    xi = sqrt(-d) / 2 * a;
  }

  if (d >= 0) {
    cout << "Las raíces son:" << endl;
    cout << "x1: " << x1 << ", x2: " << x2 << endl;
  } else {
    cout << "La ecuación tiene raíces complejas." << endl;
    cout << "Parte real: " << xr << ", imaginaria: " << xi << endl;
  }

  return 0;
}
