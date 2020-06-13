import 'dart:collection';
import 'dart:io';
import 'Arco.dart';
import 'Nodo.dart';

class Grafo{
  //datos
  int numeroVertices = 0;
  List <Nodo> tablaVertices = [];
  //constructor vacio
  Grafo();

  void nuevoNodo(int dato){
    var esta = numeroVertice(dato) >= 0;
    if(!esta){
      var nodo = Nodo(dato);
      nodo.numeroVertice = numeroVertices;
      tablaVertices.add(nodo);
      numeroVertices++;
    }
    else{
      throw Exception('El nodo ya existe');
    }
  }

  void nuevoArco(int dato1, int dato2, double distancia){
    if(!adyacente(dato1, dato2)){
      var nd1 = numeroVertice(dato1), nd2 = numeroVertice(dato2);
      var n1n2 = Arco(nd2, distancia);
      var n2n1 = Arco(nd1, distancia);
      tablaVertices[nd1].listaAdyacencia.add(n1n2);
      if(nd1 != nd2){
        tablaVertices[nd2].listaAdyacencia.add(n2n1);
      }
    }
  }

  bool adyacente(int dato1, int dato2){
    var nd1 = numeroVertice(dato1), nd2 = numeroVertice(dato2);
    if(nd1 < 0 || nd2 < 0){
      throw Exception('No existe uno de los nodos');
    }
    for(Arco arco in tablaVertices[nd1].listaAdyacencia){
      if(arco.destino == nd2){
        return true;
      }
    }
    return false;
  }

  double longitud(int dato1, int dato2){
    var nd1 = numeroVertice(dato1), nd2 = numeroVertice(dato2);
    if(nd1 < 0 || nd2 < 0){
      throw Exception('No existe uno de los nodos');
    }
    for(Arco arco in tablaVertices[nd1].listaAdyacencia){
      if(arco.destino == nd2){
        return arco.distancia;
      }
    }
    return null;
  }

  int numeroVertice(int dato){
    var encontrado = false;
    var i = 0;
    while(i < numeroVertices){
      encontrado = tablaVertices[i].dato == dato;
      if(!encontrado){
        i++;
      }
      else{
        break;
      }
    }
    return (i < numeroVertices) ? i : -1;
  }

  void rutaMasCorta(int origen, int destino){
    //Verificacion de datos dados
    var norigen = numeroVertice(origen), ndestino = numeroVertice(destino);
    if(norigen < 0 || ndestino < 0){
      throw Exception('No existe uno de los nodos');
    }
    //Paso 1, crear cosas
    var nodosNoVisitados = <Nodo>{};
    var distancia = List<double>(numeroVertices);
    var previo = List<Nodo>(numeroVertices);
    for(var nodo in tablaVertices){
      // -1 = infinito
      distancia[nodo.numeroVertice] = double.infinity;
      previo[nodo.numeroVertice] = null;
      nodosNoVisitados.add(nodo);
    }
    distancia[norigen] = 0;
    //Paso 2
    while(nodosNoVisitados.isNotEmpty){
      var distanciaMasCorta = nodosNoVisitados.reduce((curr, next) => distancia[curr.numeroVertice] < distancia[next.numeroVertice] ? curr : next);
      nodosNoVisitados.remove(distanciaMasCorta);
      if(distanciaMasCorta.numeroVertice == ndestino){
        break;
      }
      for(var vecino in nodosNoVisitados){
        if(adyacente(vecino.dato, distanciaMasCorta.dato)){
          var distanciaTotal = distancia[distanciaMasCorta.numeroVertice] + longitud(vecino.dato, distanciaMasCorta.dato);
          if(distanciaTotal < distancia[vecino.numeroVertice]){
            distancia[vecino.numeroVertice] = distanciaTotal;
            previo[vecino.numeroVertice] = distanciaMasCorta;
          }
        }
      }
    }
    //Paso 3
    var imprimir = ListQueue<Nodo>();
    var regresarNodo = tablaVertices[ndestino];
    var distanciaFinal = distancia[ndestino];
    print('Distancia: $distanciaFinal\n');
    if(previo[regresarNodo.numeroVertice] != null || regresarNodo.numeroVertice == norigen){
      while(regresarNodo != null){
        imprimir.addLast(regresarNodo);
        regresarNodo = previo[regresarNodo.numeroVertice];
      }
    }
    while(imprimir.isNotEmpty){
      var imprimirNodo = imprimir.last.dato;
      stdout.write('$imprimirNodo');
      imprimir.removeLast();
      if(imprimir.isNotEmpty){
        stdout.write(' -> ');
      }
    }
    stdout.writeln();
  }
}