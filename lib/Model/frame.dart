class Frame {
  int index;
  String square1;
  String square2;
  String pontuation;
  bool spare;
  bool strike;

  Frame (this.index, this.square1, this.square2, this.pontuation, this.spare, this.strike);

// === GETTERS =================================================\\
  String getIndex () {
    return index.toString();
  }
  int getSquare1 () {
    return int.parse(square1);
  }
  int getSquare2 () {
    return int.parse(square2);
  }
  int getPontuation () {
    return int.parse(square1) + int.parse(square2);
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
}