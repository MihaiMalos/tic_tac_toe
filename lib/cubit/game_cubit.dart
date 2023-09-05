import 'package:tic_tac_toe_game/cubit/game_state.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameCubit extends Cubit<GameState> implements GameObserver {
  Game game;
  GameCubit()
      : game = Game.create(
          timerMoveDuration: const Duration(seconds: 5),
        ),
        super(const GameState()) {
    game.addObserver(this);

    emit(state.copyWith(
      boardRepresentation: game.boardRepresentation,
      turn: game.turn,
    ));
  }

  set strategy(Strategy strategy) => game.setStrategy = strategy.convertToObj;
  MarkMatrix get board => game.boardRepresentation;
  Mark get turn => game.turn;
  void startTimer() => game.startTimer();

  void restart() {
    game.restart();
    emit(GameState.initialize(game));
  }

  void stop() {
    restart();
    game.stopTimer();
  }

  Future<void> placeMark(Position pos) async {
    await game.placeMark(pos);
  }

  @override
  void onPlaceMark(Position pos, bool isComputerMove) {
    final newState = state.copyWith(
        boardRepresentation: game.boardRepresentation, turn: game.turn);

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
