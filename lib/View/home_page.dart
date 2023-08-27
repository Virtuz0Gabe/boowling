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
    Frame(1, " ", " ", " ", " ", false, false, false),
    Frame(2, " ", " ", " ", " ", false, false, false),
    Frame(3, " ", " ", " ", " ", false, false, false),
    Frame(4, " ", " ", " ", " ", false, false, false),
    Frame(5, " ", " ", " ", " ", false, false, false),
    Frame(6, " ", " ", " ", " ", false, false, false),
    Frame(7, " ", " ", " ", " ", false, false, false),
    Frame(8, " ", " ", " ", " ", false, false, false),
    Frame(9, " ", " ", " ", " ", false, false, false),
    Frame(10," ", " ", " ", " ", false, false, false),
  ];
  int jogadaAtualNum = 0;
  int frameAtualNum = 0;
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
                  jogadaAtualNum == 0 || jogadaAtualNum == 2 ||
                    (frameAtualNum == 9 && (listaDeJogadas[frameAtualNum][0] == 10))
                  ?  11
                  : 11 - listaDeJogadas[frameAtualNum][0]
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
                            atualizarJogadas(frameAtualNum, jogadaAtualNum, index);
                            //adicionar validação para permitir mais jogadas em Spare e Strike
                            Frame frameAtual = atualizaFrame(frameAtualNum);
                            
                            if (frameAtualNum == 9){
                              debugPrint("FrameSpecial");
                              jogadaAtualNum ++;
                            } else {
                                if (jogadaAtualNum >= 1 || frameAtual.played){
                                jogadaAtualNum = 0;
                                frameAtualNum ++;
                              } else {
                                jogadaAtualNum ++;
                              }
                            }         

                            List<List<int>> copiaListaDeJogadas = List.from(listaDeJogadas);
                            totalPontuation =0;
                            for (List<int> frame in listaDeJogadas){
                              for (int ponto in frame){
                                if (ponto != -1){
                                  totalPontuation += ponto;
                                }
                              }
                            }

                            debugPrint("Pontuação total: $totalPontuation");
                            
                            debugPrint(copiaListaDeJogadas.toString());
                          },
                          child: Text((index).toString()),
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
              itemCount: (10),
              itemBuilder: (BuildContext context, int index){

                Frame frameAtual = atualizaFrame(index);
                
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
                              index != 9
                              ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(frameAtual.square1),
                                Text(frameAtual.square2)
                              ])
                              : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(frameAtual.square1),
                                Text(frameAtual.square2),
                                Text(frameAtual.square3)
                            ],
                            ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(frameAtual.pontuation)//pontosDoFrame.toString())
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

    ListOfListsObject updatedObject = ListOfListsObject(copiaListaDeJogadas, jogadaAtualNum);
    controller.updateList(updatedObject); // Atualizar o fluxo com o novo objeto
  }

  Frame atualizaFrame (int index) {
    Frame frameAtual = listaDeFrames[index];
    bool decimoFrame = false;
    int aux1;
    int aux2;
    aux1 = listaDeJogadas[index][0];
    aux2 = listaDeJogadas[index][1];
    
    if (index == 9) {
      decimoFrame = true;
    }
    
    if (!decimoFrame){
      switch (aux1) {
        case -1:
          frameAtual.setSquare1(" ");
          break;
        case 10:
          frameAtual.setSquare1(" ");
          frameAtual.setSquare2("x");
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
          frameAtual.setSpare();
        }
      }
    } else {
      // == tratamento especial para a princessa Frame numero 10 == \\
      int aux3 = listaDeJogadas[index][2];
      switch (aux1) {
        case -1:
          frameAtual.setSquare1(" ");
          break;
        case 10:
          frameAtual.setSquare1("x");
          break;  
        default:
          frameAtual.setSquare1(aux1.toString());
      }
      switch (aux2) {
        case -1:
          frameAtual.setSquare2(" ");
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
          frameAtual.setSpare();
        }
      switch (aux3) {
        case -1:
          frameAtual.setSquare3(" ");
        case 10:
          frameAtual.setSquare3("x");
          break; 
        default:
          frameAtual.setSquare3(aux3.toString());
      }
    }

    frameAtual.setPontuation(listaDeFrames);
    return frameAtual;
  }
}