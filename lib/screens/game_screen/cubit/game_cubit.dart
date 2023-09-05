import 'package:tic_tac_toe_game/screens/game_screen/cubit/game_state.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameCubit extends Cubit<GameState> implements GameObserver {
  Game _game;
  GameCubit()
      : _game = Game.create(
          timerMoveDuration: const Duration(seconds: 5),
        ),
        super(const GameState()) {
    _game.addObserver(this);

    emit(state.copyWith(
      boardRepresentation: _game.boardRepresentation,
      turn: _game.turn,
    ));
  }

  MarkMatrix get board => _game.boardRepresentation;
  Mark get turn => _game.turn;
  Duration get timerElapsedTime => _game.timerElapsedTime;
  Duration get timerDuration => _game.timerDuration;

  set strategy(Strategy strategy) => _game.strategy = strategy;
  set game(Game newGame) {
    _game.removeObserver(this);
    _game = newGame;
    _game.addObserver(this);
  }

  void startTimer() => _game.startTimer();

  void restart() {
    _game.restart();
    emit(GameState.initialize(_game));
  }

  void stop() {
    restart();
    _game.stopTimer();
  }

  Future<void> placeMark(Position pos) async {
    await _game.placeMark(pos);
  }

  @override
  void onPlaceMark(Position pos, bool isComputerMove) {
    final newState = state.copyWith(
        boardRepresentation: _game.boardRepresentation, turn: _game.turn);

    emit(newState);
  }

  @override
  void onGameOver(GameStatus gameStatus) {
    emit(state.copyWith(gameStatus: gameStatus));
  }

  @override
  void onTimerTick(Duration remainingTime) {
    emit(state.copyWith(remainingTime: remainingTime));
  }
}
