class Position {
  final int _row, _col;

  Position(this._row, this._col);

  bool isValid() {
    return _row > 0 && _row < 3 && _col > 0 && _col < 3;
  }
}
