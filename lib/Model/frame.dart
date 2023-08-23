class Frame {
  int index;
  String square1;
  String square2;
  String pontuation;
  bool played;
  bool strike;

  Frame (this.index, this.square1, this.square2, this.pontuation, this.played, this.strike);

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
  void setStrike (){
    strike = true;
  }
  void setPlayed(){
    played = true;
  }


// ====================== O MÉTODO TENEBROSO ======================\\
  int getOpenPontuation (int total, int square1, int square2) {
    return total + square1 + square2;
  }

  int getSparePontuation (int total, Frame frame) {
    // ENVOLVE UM ÚNICA JOGADA EXTRA ADICIONADA AO TOTAL
    if (frame.strike){
      return total + 10 + 10;
    } else if (frame.getSquare1() == -1 && frame.getSquare2() == -1) {
      return -1;
    } else {
      return total + frame.getSquare1();
    }
  }
  int getStrikePontuation (int total, Frame frame1, Frame frame2){
    // ENVOLVE DUAS JOGADAS EXTRAS ADICIONADAS AO TOTAL
    if (frame1.strike && frame2.strike){
      return total + 10 + 10 + 10;
    } else if (frame1.getSquare1() == 1 ){
      return 1;
    }
    return 1;
    
  }
}