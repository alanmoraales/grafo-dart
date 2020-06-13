import 'Arco.dart';

class Nodo{
  //datos
  final int dato;
  int numeroVertice;
  List <Arco> listaAdyacencia = [];
  //constructor
  Nodo(this.dato){
    numeroVertice = -1;
  }

}