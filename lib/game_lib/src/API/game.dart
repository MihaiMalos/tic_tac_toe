import 'package:tic_tac_toe_game/game_lib/src/API/game_observer.dart';
import 'package:tic_tac_toe_game/game_lib/src/API/position.dart';
import 'package:tic_tac_toe_game/game_lib/src/classes/board.dart';
import 'package:tic_tac_toe_game/game_lib/src/enums/game_state.dart';
import 'package:tic_tac_toe_game/game_lib/src/enums/mark.dart';
import 'package:tic_tac_toe_game/game_lib/src/exceptions/exceptions.dart';

class Game extends GameObservable {
  final Board _board;
  Mark _turn;
  GameState _state;

  Game()
      : _board = Board(),
        _turn = Mark.x,
        _state = GameState.playing;

  Mark get turn => _turn;

  void _changeTurn() => _turn = _turn.opposite;
  void _changeState(GameState state) => _state = state;

  void placeMark(Position pos) {
    if (_state.isGameOver) {
      throw GameOverException("Game is over, can't make anymore moves.");
    }
    _board.placeMark(pos, _turn);
    _notifyPlaceMark();
    _changeState(_board.checkWinning(pos, _turn));
    if (_state.isGameOver) _notifyGameOver(_state);
    _changeTurn();
  }

  @override
  String toString() => _board.toString();
}

class GameObservable {
  final List<GameObserver> _observers = [];

  bool addObserver(GameObserver observer) {
    if (_observers.contains(observer)) {
      return false;
    }
    _observers.add(observer);
    return true;
  }

  bool removeObserver(GameObserver observer) {
    return _observers.remove(observer);
  }

  void _notifyPlaceMark() {
    for (var observer in _observers) {
      observer.onPlaceMark();
    }
  }

  void _notifyGameOver(GameState state) {
    for (var observer in _observers) {
      observer.onGameOver(state);
    }
  }
}
