import 'dart:io';

import 'Grafo.dart';

void main(List<String> arguments) {
  var menu = true;
  var grafo = Grafo();
  while(menu){
    stdout.writeln('Menu de opciones\n1.- Nuevo nodo\n2.- Nueva union\n3.- Algoritmo de Dijkstra\nEscribe la opcion que deseas utilizar: ');
    var opcion = int.parse(stdin.readLineSync());
    switch(opcion){
      case 1:
        stdout.writeln('Escribe el valor llave del nodo (entero): ');
        var llave = int.parse(stdin.readLineSync());
        grafo.nuevoNodo(llave);
        stdout.writeln('Se agrego el nuevo nodo al grafo');
        break;
      case 2:
        stdout.writeln('Escribe el valor llave del primer nodo (tiene que estar en el grafo): ');
        var primerNodo = int.parse(stdin.readLineSync());
        stdout.writeln('Escribe el valor llave del segundo nodo (tiene que estar en el grafo): ');
        var segundoNodo = int.parse(stdin.readLineSync());
        stdout.writeln('Escribe la distancia de la union de ambos nodos (puede ser double): ');
        var distancia = double.parse(stdin.readLineSync());
        grafo.nuevoArco(primerNodo, segundoNodo, distancia);
        break;
      case 3:
        stdout.writeln('Escribe el valor llave del nodo origen (tiene que estar en el grafo): ');
        var origenGrafo = int.parse(stdin.readLineSync());
        stdout.writeln('Escribe el valor llave del nodo destino (tiene que estar en el grafo): ');
        var destinoGrafo = int.parse(stdin.readLineSync());
        stdout.writeln('Resultado');
        grafo.rutaMasCorta(origenGrafo, destinoGrafo);
        break;
      default:
    }
  }
}
