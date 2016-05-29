#include <iostream>

using namespace std;

template <typename Elem>
class Arbin {
    private:
        struct Nodo {
            Elem elemento;
            Nodo * subIzquierdo;
            Nodo * subDerecho;
        };
