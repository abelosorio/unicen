/* Definición de TDA Punto.
 */

#include <cmath>

class Punto
{
  private:

    float x;
    float y;

  public:

    Punto(float, float);
    ~Punto();
    float coordX();
    float coordY();
    float distancia(Punto);
    bool operator==(Punto);
};
