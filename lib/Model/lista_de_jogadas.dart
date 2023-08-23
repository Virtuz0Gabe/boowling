import 'dart:async';

class ListOfListsObject {
  List<List<int>> listaDeJogadas;
  int jogadaAtual;

  ListOfListsObject(this.listaDeJogadas, this.jogadaAtual);
}

class ListOfListsController {
  final StreamController<ListOfListsObject> _listStreamController = StreamController<ListOfListsObject>.broadcast();
  Stream<ListOfListsObject> get listStream => _listStreamController.stream;

  void updateList(ListOfListsObject updatedList) {
    _listStreamController.add(updatedList);
  }
  

  void dispose() {
    _listStreamController.close();
  }
}