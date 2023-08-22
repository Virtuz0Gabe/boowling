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
      body: ListView.builder(
        scrollDirection: Axis.horizontal, 
        itemCount: (10),
        itemBuilder: (BuildContext context, int index){
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 5,
                    ),
                  ),
                child: GestureDetector(
                  onTap: () {
                    // adicionar o valor ao respectivo frame 
                    debugPrint("valor ${(index+1)} Adicionado");
                  },
                  child: Container(
                    width: 60,
                    height: 80,
                    color: Colors.amber,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text((index+1).toString()),
                        ])
                  ),
                ),
              ),
            ),
          );
        }

      ),
    );
  }

  int pointsCalculator (List<int> frame){
    int sum = frame[0] + frame[1];

    if (sum < 10)
      return sum;
    
    if (frame[0] == 10)
      return 11;

    return 12;
  }


}