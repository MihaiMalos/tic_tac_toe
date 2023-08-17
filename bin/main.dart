import 'package:tic_tac_toe/src/classes/position.dart';
import 'package:tic_tac_toe/src/enums/mark.dart';
import 'package:tic_tac_toe/tic_tac_toe.dart';

void main() {
  final board = Board();
  board.placeMark(Position(1, 2), Mark.o);
  print(board);
}
