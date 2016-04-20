#include <iostream>
#include <fstream>

using namespace std;

void imprimirInstrucciones(char * nombrePrograma) {
    cout << "Uso: " << nombrePrograma << " archivoOrigen archivoDestino \n";
}

void reemplazarPalabras(fstream & archivoOrigen, fstream & archivoDestino, string palabraR, string palabraN) {
    while (!archivoOrigen.eof()) {
        string linea;
        getline(archivoOrigen, linea);
        size_t pos = linea.find(palabraR, 0);
        while (pos != string::npos) {
            linea = linea.replace(pos, palabraR.size(), palabraN);
            pos = linea.find(palabraR, pos + palabraN.size());
        }
        archivoDestino << linea << '\n';
    }
}


int main(int argc, char * argv[]) {
    if (argc != 3) {
        imprimirInstrucciones(argv[0]);
    } else {
        // Abrir el archivo
        char * nombreArchivoOrigen = argv[1];
        char * nombreArchivoDestino = argv[2];

        fstream archivoOrigen;
        archivoOrigen.open(nombreArchivoOrigen, ios::in);
        if (!archivoOrigen.is_open()) {
            cout << "Error al abrir el archivo origen\n";
        } else {
            fstream archivoDestino(nombreArchivoDestino, ios::out);
            if (!archivoDestino.is_open()){
                cout << "Error al abrir el archivo destino\n";
            }else {
                string palabraR, palabraN;
                cout << "Ingrese la palabra a reemplazar: \n";
                cin >> palabraR;
                cin.sync();
                cout << "Ingrese la nueva palabra: \n";
                cin >> palabraN;
                cin.sync();
                reemplazarPalabras(archivoOrigen, archivoDestino, palabraR, palabraN);
                archivoDestino.close();
            }
            archivoOrigen.close();
        }
    }
    return 0;
}
