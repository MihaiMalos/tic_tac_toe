import 'package:tic_tac_toe/src/classes/position.dart';
import 'package:tic_tac_toe/src/enums/mark.dart';
import 'package:tic_tac_toe/src/interfaces/iboard.dart';

typedef MarkMatrix = List<List<Mark>>;

class Board implements IBoard {
  static const size = 3;
  final MarkMatrix _board;

  Board() : _board = MarkMatrix.filled(size, List.filled(size, Mark.empty));

  @override
  void placeMark(Position pos) {}

  @override
  String toString() {
    final out = StringBuffer();
    for (var row = 0; row < size; row++) {
      for (var column = 0; column < size; column++) {
        out.write('${_board[row][column].name} ');
      }
      out.write('\n');
    }
    return out.toString();
  }
}
