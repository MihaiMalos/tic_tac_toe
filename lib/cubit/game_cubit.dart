import 'package:tic_tac_toe_game/cubit/game_state.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameCubit extends Cubit<GameState> implements GameObserver {
  Game? game;
  GameCubit() : super(const GameState());

  void initializeGame(Strategy strategy) {
    game = Game.create(strategy: strategy);
    game!.addObserver(this);

    emit(state.copyWith(
        boardRepresentation: game!.boardRepresentation, turn: game!.turn));
  }

  MarkMatrix get board => game!.boardRepresentation;
  Mark get turn => game!.turn;
  void restart() {
    game!.restart();
    emit(state.copyWith(
        boardRepresentation: game!.boardRepresentation,
        turn: game!.turn,
        gameState: GameEvent.playing));
  }

  void placeMark(Position pos) {
    game!.placeMark(pos);
  }

  @override
  void onPlaceMark(Position pos) {
    final newState = state.copyWith(
        boardRepresentation: game!.boardRepresentation, turn: game!.turn);
    emit(newState);
  }

  @override
  void onGameOver(GameEvent gameState) {
    emit(state.copyWith(gameState: gameState));
  }
}
