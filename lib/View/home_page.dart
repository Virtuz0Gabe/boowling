import "package:boowling/Model/frame.dart";
import "package:flutter/material.dart";
import "../Model/lista_de_jogadas.dart";


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final ListOfListsController controller = ListOfListsController();

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

  List<Frame> listaDeFrames = [
    Frame(1, " ", " ", " ", false, false),
    Frame(2, " ", " ", " ", false, false),
    Frame(3, " ", " ", " ", false, false),
    Frame(4, " ", " ", " ", false, false),
    Frame(5, " ", " ", " ", false, false),
    Frame(6, " ", " ", " ", false, false),
    Frame(7, " ", " ", " ", false, false),
    Frame(8, " ", " ", " ", false, false),
    Frame(9, " ", " ", " ", false, false),
  ];
  int jogadaAtual = 0;
  int frameAtual = 0;
  int totalPontuation = 0;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Boowling"),
        leading: IconButton(
          alignment:  Alignment.center,
          icon: const Icon(Icons.pin_invoke_sharp),
          onPressed: () {
          },
        ),
      ),
      body: Column(
        children: [
                        // =========================== | =========== :. BOTÕES DE PONTUAÇÃO .: =========== | ===========================\\
          Expanded(
            child: StreamBuilder(
              stream: controller.listStream,
              builder: (BuildContext context, AsyncSnapshot<ListOfListsObject> snapshot) {
                if (snapshot.hasError) {
                  return Text('Erro: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data == null) {
                }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: (
                  jogadaAtual == 0 
                  ?  10
                  : 10 - listaDeJogadas[frameAtual][0]
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        FloatingActionButton(
                          backgroundColor: Colors.amberAccent,
                          foregroundColor: const Color.fromARGB(255, 89, 71, 7),
                          elevation: 6,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          onPressed: () {
                            atualizarJogadas(frameAtual, jogadaAtual, index+1);
                            if (jogadaAtual >= 1){
                              jogadaAtual = 0;
                              frameAtual ++;
                            } else {
                              jogadaAtual ++;
                            }
                            totalPontuation += index+1;
                            List<List<int>> copiaListaDeJogadas = List.from(listaDeJogadas);
                            debugPrint(copiaListaDeJogadas.toString());
                          },
                          child: Text((index+1).toString()),
                        )
                      ],
                    ),
                  );
                },
              );}
            ),
          ),
          
                              // =========================== | =========== :. PLACAR .: =========== | ===========================\\
          Expanded(
            child: StreamBuilder(
              stream: controller.listStream,
              builder: (BuildContext context, AsyncSnapshot<ListOfListsObject> snapshot) {
                if (snapshot.hasError) {
                  return Text('Erro: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const CircularProgressIndicator(); // ou qualquer outro widget de carregamento
                }
                List<List<int>> listaDeJogadas = snapshot.data!.listaDeJogadas;

              return ListView.builder(
              scrollDirection: Axis.horizontal, 
              itemCount: (9),
              itemBuilder: (BuildContext context, int index){
                Frame frameAtual = listaDeFrames[index];
                int aux1 = listaDeJogadas[index][0];
                int aux2 = listaDeJogadas[index][1];

                switch (aux1) {
                  case -1:
                    frameAtual.setSquare1(" ");
                    break;
                  case 10:
                    frameAtual.setSquare1(" ");
                    frameAtual.setSquare2("X");
                    frameAtual.setPlayed();
                    frameAtual.setStrike();
                    break;  
                  default:
                    frameAtual.setSquare1(aux1.toString());
                }
                if (frameAtual.played != true){
                  switch (aux2) {
                  case -1:
                    frameAtual.setSquare2(" ");
                    break;
                  case 10:
                    frameAtual.setSquare2("x");
                    frameAtual.setStrike();
                    frameAtual.setPlayed();
                    break;
                  default:
                    frameAtual.setSquare2(aux2.toString());
                    frameAtual.setPlayed();
                  }
                  if (aux1 + aux2 == 10 && aux1 != 10){
                    frameAtual.setSquare2("/");
                  }
                }
                
                
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(frameAtual.getIndex()),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 5,
                          ),
                        ),
                        child:Container(
                          width: 70,
                          height: 70,
                          color: Colors.amber,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(frameAtual.square1),
                                Text(frameAtual.square2)
                              ]),
                              const Padding(
                                padding: EdgeInsets.all(15),
                                child: Text("total")
                                )
                              ]
                            )
                          ),
                        ),
                      ]
                    ),
                  );
                }
              );}
            ),
          ),
      ]),
    );
  }
  void atualizarJogadas(int linha, int coluna, int novoValor) {
    List<List<int>> copiaListaDeJogadas = List.from(listaDeJogadas); // Copiar a lista original
    copiaListaDeJogadas[linha][coluna] = novoValor; // Fazer a edição na cópia da lista

    ListOfListsObject updatedObject = ListOfListsObject(copiaListaDeJogadas, jogadaAtual);
    controller.updateList(updatedObject); // Atualizar o fluxo com o novo objeto
}


}