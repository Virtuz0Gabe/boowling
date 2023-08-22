class Frame {
  int index;
  int square1;
  int square2;

  Frame (this.index, this.square1, this.square2);

// === GETTERS =================================================\\
  String getIndex () {
    return index.toString();
  }
  String getSquare1 () {
    return square1.toString();
  }
  String getSquare2 () {
    return square2.toString();
  }
// === SETTERS =================================================\\
  void setIndex (int newIndex) {
    index = newIndex;
  }
  void setSquare1 (int point) {
    square1 = point;
  }
  void setSquare2 (int point) {
    square2 = point;
  }
}