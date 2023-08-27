import 'dart:async';

class ListOfListsObject {
  List<List<int>> listaDeJogadas;
  int jogadaAtual;

  ListOfListsObject(this.listaDeJogadas, this.jogadaAtual);
}

class ListOfListsController {
  final StreamController<ListOfListsObject> _listStreamController = StreamController<ListOfListsObject>.broadcast();
  Stream<ListOfListsObject> get listStream => _listStreamController.stream;

  ListOfListsController() {
    // Inicialize a lista de jogadas com valores iniciais aqui
    List<List<int>> listaDeJogadas = [
    [-1, -1],  // | Frame 1
    [-1, -1],  // | Frame 2
    [-1, -1],  // | Frame 3
    [-1, -1],  // | Frame 4
    [-1, -1],  // | Frame 5
    [-1, -1],  // | Frame 6
    [-1, -1],  // | Frame 7
    [-1, -1],  // | Frame 8
    [-1, -1],  // | Frame 9
    [-1, -1, -1],  // | Frame 10     
  ];
    _listStreamController.add(ListOfListsObject(listaDeJogadas, 0));
  }

  void updateList(ListOfListsObject updatedList) {
    _listStreamController.add(updatedList);
  }
  

  void dispose() {
    _listStreamController.close();
  }
}