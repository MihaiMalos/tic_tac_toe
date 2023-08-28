import 'package:tic_tac_toe_game/cubit/game_state.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameCubit extends Cubit<TicTacToeState> implements GameObserver {
  Game? game;
  GameCubit() : super(TicTacToeState());

  void initializeGame(Strategy strategy) {
    game = Game.create(strategy: strategy);

    emit(GameContinueState(
        boardRepresentation: game!.boardRepresentation, turn: game!.turn));
  }

  MarkMatrix get board => game!.boardRepresentation;

  Mark get turn => game!.turn;

  void placeMark(Position pos) {
    game!.placeMark(pos);
  }

  @override
  void onPlaceMark(Position pos) {
    emit(GameContinueState(
        boardRepresentation: game!.boardRepresentation, turn: game!.turn));
  }

  @override
  void onGameOver(GameState state) {
    emit(GameOverState(gameOverState: state));
  }
}
