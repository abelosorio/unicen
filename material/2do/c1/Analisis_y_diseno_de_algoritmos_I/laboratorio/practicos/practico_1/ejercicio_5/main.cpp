#include <iostream>

using namespace std;

void mostrar_ayuda(string program)
{
    cout << "Error de parametros" << endl;
    cout << "Modo de uso:" << endl;
    cout << program << " -m|-M" << endl;
}

void imprimir_cadena_minusculas(string cadena)
{
    cout << "Su cadena «" << cadena << "» en minusculas es: " << endl;

    for (unsigned int i = 0; i <= cadena.length(); i++) {
        cout << (char) tolower(cadena[i]);
    }
    cout << endl;
}

void imprimir_cadena_mayusculas(string cadena)
{
    cout << "Su cadena «" << cadena << "» en mayusculas es: " << endl;

    for (unsigned int i = 0; i <= cadena.length(); i++) {
        cout << (char) toupper(cadena[i]);
    }
    cout << endl;
}

int main(int argc, char* argv[])
{
    string cadena;

    if (argc < 2) {
        mostrar_ayuda(argv[0]);
        return 1;
    }

    cout << "Ingrese cualquier texto:" << endl;
    getline(cin, cadena);

    if ((string) argv[1] == "-m") {
        imprimir_cadena_minusculas(cadena);
    } else {
        imprimir_cadena_mayusculas(cadena);
    }

    return 0;
}
