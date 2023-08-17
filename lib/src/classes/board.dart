import 'package:tic_tac_toe/src/classes/position.dart';
import 'package:tic_tac_toe/src/enums/mark.dart';

typedef MarkMatrix = List<List<Mark>>;

class Board {
  static const size = 3;
  final MarkMatrix _board;

  Board()
      : _board = List.generate(
            size, (rowIndex) => List.generate(size, (colIndex) => Mark.empty));

  void placeMark(Position pos, Mark mark) {
    // TODO: handling exceptions: position not valid, ocuppied position
    if (!pos.isValid()) {}
    _board[pos.row][pos.col] = mark;
  }

  @override
  String toString() {
    final out = StringBuffer();
    for (var row in _board) {
      for (var element in row) {
        out.write('${element.name} ');
      }
      out.write('\n');
    }
    return out.toString();
  }
}
