import 'package:tic_tac_toe/src/classes/position.dart';
import 'package:tic_tac_toe/src/enums/mark.dart';
import 'package:tic_tac_toe/src/interfaces/iboard.dart';

typedef MarkMatrix = List<List>;

class Board implements IBoard {
  static const size = 3;
  final MarkMatrix _board = [];

  Board() {
    for (int row = 0; row < size; row++) {
      _board.add([]);
      for (int column = 0; column < size; column++) {
        _board[row].add(Mark.empty);
      }
    }
  }

  @override
  void placeMark(Position pos) {}
}
