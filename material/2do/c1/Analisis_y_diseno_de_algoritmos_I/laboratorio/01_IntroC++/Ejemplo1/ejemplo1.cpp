#include <iostream>
#include <fstream>
using namespace std;

void imprimirInstrucciones(char * nombrePrograma) {
    cout << "Uso: " << nombrePrograma << " archivo \n";
}

void mostrarOpciones() {
    cout << "1. Imprimir el promedio de llamadas de un día dado\n";
    cout << "2. Calcular e imprimir el día con el mayor promedio de llamadas\n";
    cout << "0. Salir\n";
    cout << "Elija una opción: ";
}

void cargarLlamadas(fstream & archivo, int llamadas[]) {
    int i = 0;
    while (!archivo.eof()) {
        archivo >> llamadas[i];
        i++;
    }
}

float promedioDia(int llamadas[], int dia) {
    float promedio = 0;
    int horaFin = dia * 24;
    for (int hora = (dia-1) * 24; hora < horaFin; hora++) {
        promedio = promedio + llamadas[hora];
    }
    promedio = promedio / 24;
    return promedio;
}

void mayorPromedio(int llamadas[], int & mayorDia, float & mayorPromedio) {
    float promedio;
    mayorPromedio = 0;
    mayorDia = 1;
    for (int dia = 1; dia <= 30; dia++) {
        promedio = promedioDia(llamadas, dia);
        if (promedio > mayorPromedio) {
            mayorPromedio = promedio;
            mayorDia = dia;
        }
    }
}


int main(int argc, char * argv[]) {
    if (argc != 2) {
        imprimirInstrucciones(argv[0]);
    } else {
        // Abrir el archivo
        char * nombreArchivo = argv[1];
        int llamadas[720];
        fstream archivo;
        archivo.open(nombreArchivo, ios::in);
        if (!archivo.is_open()) {
            cout << "Error al abrir el archivo\n";
        } else {
            // Pasamos las llamadas del archivo a un arreglo
            cargarLlamadas(archivo, llamadas);
            archivo.close();

            // MenÃº de opciones
            char opcion;
            mostrarOpciones();
            cin >> opcion;
            cin.sync();
            while (opcion != '0') {
                switch (opcion) {
                    case '1': {
                        int dia;
                        cout << "Ingrese el día: ";
                        //printf("Ingrese el dÃ­a: ");
                        cin >> dia;
                        //scanf("%i", &dia);
                        cin.sync();
                        if ((dia > 0) && (dia < 30)) {
                            cout << "El promedio es: " << promedioDia(llamadas, dia) << "\n";
                        } else
                            cout << "Error al ingresar el día (debe ser entre 1 y 30)\n";
                    } break;
                    case '2': {
                        int dia;
                        float promedio;
                        mayorPromedio(llamadas, dia, promedio);
                        cout << "El mayor promedio es " << promedio << " del día " << dia << "\n";
                        //printf("El mayor promedio es %f del dÃ­a %d\n", promedio, dia);
                    } break;
                    case '0': break;
                    default: {
                        cout <<"OpciÃ³n incorrecta\n";
                    } break;
                }
                mostrarOpciones();
                cin >> opcion;
                cin.sync();
            }
        }
    }
}
