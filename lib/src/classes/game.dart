import 'package:tic_tac_toe/src/classes/board.dart';
import 'package:tic_tac_toe/src/classes/position.dart';
import 'package:tic_tac_toe/src/enums/mark.dart';
import 'package:tic_tac_toe/src/interfaces/igame.dart';

class Game implements IGame {
  final Board _board;
  final Mark _turn;

  Game()
      : _board = Board(),
        _turn = Mark.x;

  Mark get turn => _turn;

  @override
  void placeMark(Position pos) {
    _board.placeMark(pos, _turn);
  }
}
