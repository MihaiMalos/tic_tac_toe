import 'package:tic_tac_toe_game/cubit/game_state.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameCubit extends Cubit<GameState> implements GameObserver {
  Game? game;
  GameCubit() : super(const GameState());
  bool blocked = false;

  void initializeGame(Strategy strategy) {
    game = Game.create(
      strategy: strategy,
      computerMoveDuration: const Duration(milliseconds: 300),
    );
    game!.addObserver(this);

    emit(state.copyWith(
        boardRepresentation: game!.boardRepresentation, turn: game!.turn));
  }

  MarkMatrix get board => game!.boardRepresentation;
  Mark get turn => game!.turn;
  void restart() {
    if (blocked) return;
    game!.restart();

    final newState = state.copyWith(
        boardRepresentation: game!.boardRepresentation,
        turn: game!.turn,
        gameEvent: null);

    emit(newState);
  }

  Future<void> placeMark(Position pos) async {
    if (blocked) return;
    await game!.placeMark(pos);
  }

  @override
  void onPlaceMark(Position pos, bool isComputerMove) {
    blocked = true;
    final newState = state.copyWith(
        boardRepresentation: game!.boardRepresentation, turn: game!.turn);

    emit(newState);
    blocked = false;
  }

  @override
  void onGameOver(GameEvent gameState) {
    emit(state.copyWith(gameEvent: gameState));
  }
}
