class Frame {
  int index;
  String square1;
  String square2;
  String square3;
  String pontuation;
  bool played;
  bool spare;
  bool strike;

  Frame (this.index, this.square1, this.square2, this.square3, this.pontuation, this.played, this.spare, this.strike);

// === GETTERS =================================================\\
  String getIndex () {
    return index.toString();
  }
  int getSquare1 () {
    return int.tryParse(square1) ?? 0; 
  }
  int getSquare2 () {
    return int.tryParse(square2) ?? 0; 
  }
  int getSquare3 () {
    return int.tryParse(square3) ?? 0; 
  }
  int getPontuation () {
    return int.tryParse(pontuation) ?? 0; 
  }
  
// === SETTERS =================================================\\
  void setIndex (int newIndex) {
    index = newIndex;
  }
  void setSquare1 (String point) {
    square1 = point;
  }
  void setSquare2 (String point) {
    square2 = point;
  }
  void setSquare3 (String point) {
    square3 = point;
  }
  void setStrike (){
    strike = true;
  }
  void setSpare () {
    spare = true;
  }
  void setPlayed(){
    played = true;
  }
  void setUnplayed(){
    played = false;
  }


// ====================== O MÉTODO TENEBROSO ======================\\
  setPontuation (List<Frame> listaDeFrames){
    // a pontuação só deve ser retornada caso o frame atual já tenha sido jogado
    if (!played){
      pontuation = " ";
      return;
    }

    if (pontuation != " "){
      return;
    }

    int total;
    if (index > 1){
      total = listaDeFrames[index-2].getPontuation();
    } else {
      total = 0;
    }

    // Nem Spare nem Strike equivale a uma pontuação normal, vulgo Pontuação Aberta
    if (!spare && !strike) {
      if (index > 1){
        if (listaDeFrames[index-2].pontuation != " "){
          pontuation = (total + getSquare1() + getSquare2()).toString();
          return;
        }
      } else {
        pontuation = (total + getSquare1() + getSquare2()).toString();
        return;
      }
    }

    // no caso do spare a soma dos pontos deve ser 10 para que ele ocorra
    // então assumimos que o valor dos pontos deste frame equivalem a 10
    // caso contrário não haveria Spare

    // O motivo do if segundoFrame.played, é pq tanto Spare quanto Strike só devem aparecer pontuação 
    // caso a próxima jogada já tenha sido efetuada
    // ou seja, eu coloquei tudo num if, pra não ficar repetindo a verificação
    if (index < 9){
      Frame segundoFrame = listaDeFrames[index];
      // ======||==============| ..:: SPARE ::.. |============||====== \\
      if (spare && (segundoFrame.played || segundoFrame.square1 != " ")){

        if (segundoFrame.strike){
          pontuation = (total + 10 + 10).toString();
          return;
        } else {
          pontuation = (total + 10 + segundoFrame.getSquare1()).toString();
          return;
        }
      }// ======||==============| ..:: SPARE ::.. |============||========
      
      if (strike && segundoFrame.played){
        if (segundoFrame.spare){
          pontuation = (total + 10 +10).toString();
          return;
        }
        if (!segundoFrame.strike){
          pontuation = (total + 10 + segundoFrame.getSquare1() + segundoFrame.getSquare2()).toString();
          return;
        }
        if (segundoFrame.strike){
          Frame terceiroFrame = listaDeFrames[index+1];
          if (terceiroFrame.strike){
            pontuation = (total + 10 + 10 + 10).toString();
            return;
          } else if (terceiroFrame.square1 != " ") {
            pontuation = (total + 10 + 10 + terceiroFrame.getSquare1()).toString();
            return;
          }
        }
      }
      if (strike && index ==9){
        if (segundoFrame.square1 == "x"){
          if (segundoFrame.square2=="x"){
            pontuation = (total + 10 + 10 + 10).toString();
            return;
          }
          if (segundoFrame.square2 != " ") {
            pontuation = (total + 10 + 10 + segundoFrame.getSquare2()).toString();
            return;
          }
        }
      }

    } else {
      if (!strike && !spare){
        pontuation = (total + getSquare1() + getSquare2()).toString();
        return;
      }
      if (spare && played && square3!= " "){
        if (square3 == "x"){
          pontuation = (total + 10 + 10).toString();
          return;
        }
        pontuation = (total + 10 + getSquare3()).toString();
        return;
      }
      if (strike && square3 != " "){
        if (square2 == "x"){
          if (square3 == "x") {
            pontuation = (total + 10 + 10 + 10).toString();
            return;
          }
          pontuation = (total + 10 + 10 + getSquare3()).toString();
          return;
        }
        pontuation = (total + 10 + getSquare2() + getSquare3()).toString();
        return;
      }
    }
    // CASOS ESPECIAIS E CALTELÓSOS
  }
}