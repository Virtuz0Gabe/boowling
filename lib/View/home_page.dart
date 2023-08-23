import "package:boowling/Model/frame.dart";
import "package:flutter/material.dart";


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<int>> listaDeJogadas = [
    [10, 0],           // Frame 1: Strike
    [5, 4],         // Frame 2: Spare
    [7, 3],         // Frame 3: Spare
    [10, 0],           // Frame 4: Strike
    [8, 2],         // Frame 5: Spare
    [9, 0],         // Frame 6: Open Frame
    [10, 0],           // Frame 7: Strike
    [10, 0],           // Frame 8: Strike
    [10, 0],           // Frame 9: Strike
    [10, 10, 10]    // Frame 10: Three Strikes
  ];

  List<Frame> listaDeFrames = [
    Frame(1, "10", " ", "10", false, true),
    Frame(2, "10", " ", "10", false, true),
    Frame(3, "10", " ", "10", false, true),
    Frame(4, "10", " ", "10", false, true),
    Frame(5, "10", " ", "10", false, true),
    Frame(6, "10", " ", "10", false, true),
    Frame(7, "10", " ", "10", false, true),
    Frame(8, "10", " ", "10", false, true),
    Frame(9, "10", " ", "10", false, true),
  ];

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
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (10),
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
                          // adicionar os pontos ao respectivo frame \\
                        },
                        child: Text((index+1).toString()),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          
          Expanded(
            child: ListView.builder(
            scrollDirection: Axis.horizontal, 
            itemCount: (9),
            itemBuilder: (BuildContext context, int index){
              Frame frameAtual = listaDeFrames[index];
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
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(frameAtual.pontuation))
                          ]
                        )
                      ),
                    ),
                  ]
                  ),
                );
            }
                
                  ),
          ),
      ]),
    );
  }
}